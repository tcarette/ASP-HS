ASP-HS
======

Atomic structure packages (ATSP2K, GRASP2K) helper scripts


### anaATSP2K_func.sh

Short functions that return various floats from ATSP2K output assuming standard
file names (<root>.<std extension>).

* default usage:
    * argument 1: file root name.
    * argument 2 (for hfs and bpci): J1 value in format Int or Int/2.
    * argument 3 (for hfs): J2 value in format Int or Int/2
* functions beginning with D: functions that compute differential effects (first - second)
    * argument 1: first state file root name.
    * argument 2: J value for first state (in format Int or Int/2.)
    * argument 3: second state file root name.
    * argument 4: J value for second state (in format Int or Int/2.)

### anaGRASP_func.sh

Short functions that return various floats from GRASP2K output assuming standard
file names (<root>.<std extension>).

* default usage:
    * argument 1: file root name.
    * argument 2: J value in format Int or Int/2.
    * argument 3: index of the level in the J block
* functions beginning with D: functions that compute differential effects (first - second)
    * argument 1-3: as above for first state
    * argument 4-6: as above for second state

### nrcfg (and tnrcfg)

Check number of configuration state functions in .c files (given in argument).
nrcfg allows several .c files as arguments.
nrcfg provides #CSF/block, tnrcfg provides the total #CSF.

### weights (ASTP2K)

Calculate configuration weights and cumulated weights using .l file
* argument 1: root name of the target
* argument 2: root name of the .c file containing the configuration to be condsidered

### W2C*

Weights to configuration list

##### W2C_ref: read a file containing a set of configurations line by line and form
the .c file containing all CSFs of those configurations for a specific LS
		* argument 1: <root>.weight file (e.g. std out of weights)
		* argument 2: number of lines (configurations) consider to form the list
		* argument 3: term as provided to lsgen

##### W2BPC_ref:
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs of those configurations for a range of Js
in LS coupling
* argument 1: <root>.weight file (e.g. std out of weights)
* argument 2: number of lines (configurations) consider to form the list
* argument 3: J min
* argument 4: J max

##### W2BPC_SDred:
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs interacting with those configurations
for a range of Js in LS coupling
* argument 1: <root>.weight file (e.g. std out of weights)
* argument 2: number of lines (configurations) consider to form the list
* argument 3: J min
* argument 4: J max
* argument 5: n max
* argument 6: l max (integer)



