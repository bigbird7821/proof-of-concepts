# 3. Use ansible inventory directory with empty group definitions

Date: 2018-01-30

## Status

Accepted

## Context

When working with more complex infrastructures, there is a chance that the inventory groupings can also become complex.  

## Decision

Since (1) ansible allows inventory to be configured with a single file, like hosts.ini, or with a directory of files like ./inventory{usa-hosts,uk-hosts,canada-hosts} and (2) a single file can be used to define ALL groups without any IP settings while other files add the IPs to the groups, then it was decided to use this approach for all infrastructure groupings whether simple or complex.

## Consequences

The consequences of this decision is a much simplified means of adding or removing IPs from different groups.  For example, if ./inventory contains all the inventory files and a single group [apache] is defined, then geographical datacentre inventory files can be defined, e.g., ./inventory/usa-hosts and ./inventory/uk-hosts.  If you have IPs defined for [apache] in both these inventory files, then all the IPs will be considered in the "apache" group.  However, if you only wish to enable the uk-hosts, then simply remove the ./inventory/usa-hosts.  It is possible to take this even further by creating 2 directories, an "available" inventory directory and an "enabled" inventory directory.  Similar to the way that apache virtual hosts can be enabled or disabled, then here the same can be achieved by either enabling or disabling inventory host files.
