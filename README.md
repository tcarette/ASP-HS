ASP-HS
======

Atomic structure packages (ATSP2K, GRASP2K) helper scripts

## General Purpose Scripts

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

### anaRelCorr_func.sh

Short functions that return difference between parameters computed with GRASP and ATSP2K

* default usage:
    * argument 1: GRASP file root name.
    * argument 2: J value in format Int or Int/2.
    * argument 3: index of level in block J
    * argument 4: ATSP2K file root name
    * argument 5: J value in format Int or Int/2.

### nrcfg (and tnrcfg)

Check number of configuration state functions in .c files (given in argument).
nrcfg allows several .c files as arguments.
nrcfg provides #CSF/block, tnrcfg provides the total #CSF.

### PLOT_conv_mchf

Read file containing stderr of mchf (ATSP2K) and generate pdf and eps of the convergence of
the energy and of the squared energy increment as a function of the iteration number.
Note: it would probably work if the stdout and stderr are saved in the same file but
it is not tested.
* argument 1: root file name (reads <root>.err)

### weights (ASTP2K)

Calculate configuration weights and cumulated weights using .l file
* argument 1: root name of the target
* argument 2: root name of the .c file containing the configuration to be condsidered

### W2C*

Weights to configuration list

##### W2C_ref (ATSP):
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs of those configurations for a specific LS
		* argument 1: <root>.weight file (e.g. std out of weights)
		* argument 2: number of lines (configurations) consider to form the list
		* argument 3: term as provided to lsgen

##### W2BPC_ref (ATSP):
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs of those configurations for a range of Js
in LS coupling
* argument 1: <root>.weight file (e.g. std out of weights)
* argument 2: number of lines (configurations) consider to form the list
* argument 3: J min
* argument 4: J max

##### W2RC_ref (GRASP):
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs of those configurations for a range of Js
in jj coupling
* argument 1: <root>.weight file (e.g. std out of weights)
* argument 2: number of lines (configurations) consider to form the list
* argument 3: J min
* argument 4: J max

##### W2BPC_SDred (ATSP): (similar to extend with Breit option)
Read a file containing a set of configurations line by line and form
the .c file containing all CSFs interacting with those configurations
for a range of Js in LS coupling
* argument 1: <root>.weight file (e.g. std out of weights)
* argument 2: number of lines (configurations) consider to form the list
* argument 3: J min
* argument 4: J max
* argument 5: n max
* argument 6: l max (integer)

## Examples and templates of useful scripts.

Most of the following scripts cannot be used as black boxes and usually necessitate
modifications for specific cases.

### Automatic_sub_Hydra/*

Automatically submit jobs executing various programs if the necessary input files are ok.
Requested ressources are set as linear functions of the total number of CSF in the .c list.
* argument 1: label for the calculation (also used for the WORK directory)
