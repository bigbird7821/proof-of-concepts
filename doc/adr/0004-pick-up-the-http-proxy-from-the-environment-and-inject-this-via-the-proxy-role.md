# 4. Pick up the http_proxy from the environment and inject this via the proxy role

Date: 2018-01-30

## Status

Accepted

## Context

When working behind a company firewall, the http_proxy usually needs to be set in various places:  the command-line environment, the yum configuration, etc.  Given that (1) the chance that different proxy's may be in effect for users of this framework and (2) the http_proxy should not be hardcoded in the codebase, the following decision was made.

## Decision

Extract the http_proxy from the local terminal environment, if it exists, rather than hard-code it.  The following code is an example of how this is done:
```
proxy_configurator_http_proxy: "{{ lookup('env','http_proxy') }}"
```
The consequence of this is as follows.

## Consequences

The http_proxy is no longer hardcoded but picked up depending on the environment.
