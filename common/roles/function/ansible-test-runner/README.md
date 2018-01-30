Role Name: ansible-test-runner
=========

This role is for running bash tests against target hosts

Requirements
------------

The only requirements are the variables that should be passed into the role, which is explained below.

Role Variables
--------------

_test_case_title:
    Required.

_bash_test_code.
    Required.

_should_debug_tests
    Optional.  Default for this is false.  If true, then the standard out from the server will be printed to screen.
    Tests that fail will always print the standard out to screen.  Failed tests will print the output in red; whereas
    passed tests will only print in green if the _should_debug_test is set to true

Dependencies
------------

None

Example Playbook
----------------

The following example test will run against all servers and check that the dnsmasq program is only bound to the local
"loopback" 127.0.0.1 interface.  The following variables have been passed:
* _test_case_title.  This is required.
* should_debug_test.  This is optional and by default false.  Set this to true if you want to output the stdout from the test
The standard output for the test will only be displayed if the test fails UNLESS the _should_debug_test is set to true.
When _should_debug_test is true then the standard out will be displayed whether the test passes or fails.
* _bash_test_code. This is required.

    - name: root/dnsmasq-installer tests
      hosts: all
      gather_facts: False
      tasks:
        - include_role: {name: function/ansible-test-runner}
          vars:
            _test_case_title: dnsmasq should only be listening on the loopback interface 127.0.0.1
            _should_debug_test: false
            _bash_test_code: |
                result=$(sudo netstat -tlnp)

                set -x
                # fail if...
                expected="1"
                actual=$( echo "${result}" | grep dnsmasq | wc -l )
                (( ${actual} != ${expected} )) && echo "only 1 dnsmasq interface listener should be present" && exit 1

                # fail if...
                expected="127.0.0.1:53"
                actual=$( echo "${result}" | grep dnsmasq | awk '{ print $4 }' )
                [[ "${actual}" != "${expected}" ]] && echo "dnsmasq listener should be bound to the local 127.0.0.1 interface" && exit 1

                # otherwise everything passed fine
                exit 0


License
-------

BSD

Author Information
------------------

Gavin Didrichsen
