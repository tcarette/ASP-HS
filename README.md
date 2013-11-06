ASP-HS
======

Atomic structure packages (ATSP2K, GRASP2K) helper scripts


anaATSP2K_func.sh
-----------------
Short functions that return various floats from output assuming standard
file names (<root>.<std extension>).

* default usage:
    * argument 1: file root name.
    * argument 2 (for hfs and bpci): J1 value in format Int or Int/2.
    * argument 3 (for hfs): J2 value in format Int or Int/2 (for hfsA and hfsB)
* functions beginning with D: functions that compute differential effects (first - second)
    * argument 1: first state file root name.
    * argument 2: J value for first state (in format Int or Int/2.)
    * argument 3: second state file root name.
    * argument 4: J value for second state (in format Int or Int/2.)
