# 5. Ensure the skeleton application depends on an oel6 vagrant basebox

Date: 2018-02-16

## Status

Accepted

## Context

There are a number of problems with the existing implementation:  
* The skeleton application depended on a non-existant OEL 6 Redhat base box, only one that I had defined on my laptop.  All ansible activities depend on this fact, e.g., yum not apt-get is the software package manager
* Booting up the skeleton application from scratch requires an unacceptable length of time for all the necessary software packages to be installed.  This restricts the development process because doing a restart after a "vagrant destroy" takes too long

As a result of the above problems, I introduced a vagrant basebox skeleton

## Decision

The skeleton application now depends on the oel6base/skeleton basebox, which must be created before running the skeleton application. First the ./base_boxes/oel6base must be created, then the ./base_boxes/oel6base.skeleton.  Only after these base boxes have been loaded up locally, can the skeleton application be run

## Consequences

The consequence of this decision is that users of the skeleton now have a way of creating their own skeleton application.  For example, if you are developing an ELK application then you may want to create a new basebox that already includes java, elasticsearch, logstash, etc.  Once you have your new base box, then iterative infrastructure development will be much quick: destroy your entire infrastructure and then recreate it in minutes.
