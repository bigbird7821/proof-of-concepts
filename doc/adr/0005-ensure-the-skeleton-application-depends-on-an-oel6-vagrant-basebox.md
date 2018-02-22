# 5. Ensure the skeleton application depends on an oel6 vagrant basebox

Date: 2018-02-16

## Status

Accepted

## Context

There are a number of problems with the existing implementation:  
* The skeleton application depends on a non-existant OEL 6 Redhat base box, only one that I have defined on my laptop.
* Booting up the skeleton application from scratch requires an unacceptable length of time for all the necessary software packages to be installed, restricting the ease of development

As a result of the above problems, the following decision was made

## Decision

A set of vagrant basebox's are now built from a publicly available OEL 6 Redhat variant.  The first one that must be created is "oel6base" and is created from the publicly available Oracle base box.  After this several other base boxes must be created all located beneath the ./base_boxes/oel6base directory. 

The consequences of this are as follows:

## Consequences

Users of the skeleton must create their own base boxes before running the skeleton.  For example, if you are developing an ELK application then you will first need to create all the base bases.  After this you will probably want to create a new baseboxes that include all your new software.  The new skeleton now includes all that is needed to create new base boxes.
