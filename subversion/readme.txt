===============================================================================
Information about bin/subversion.
===============================================================================
This directory contains the Subversion .dll files used by the IDE's Subversion
integration.  These files can be upgraded by going to www.collab.net and
downloading the subversion client and extracting it to this location.  Other
subversion installations will not be used be default.  The IDE only looks in
this location, this behavior can be changed by setting the registry string
SvnDllDir under the Subversion key to the location of your Subversion
installation.  This will not work with all Subversion installation because not
all installation use the same .dll names.
