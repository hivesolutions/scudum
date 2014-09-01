#!/bin/bash
# -*- coding: utf-8 -*-

MESSAGE="usage: scudum <command>\n\
\n\
The most commonly used git commands are:\n\
   all       Rebuild the Scudum system from the beginning (takes some time)\n\
   cleanup   Cleans the current Scudum (/scudum) deployment, removing extra files\n\
   config    Reconfigures scudum according to local or global config files\n\
   deploy    Deploys the current Scudum instance to the remote repository\n\
   extras    Re-creates the extras (packages) in the current deployment\n\
   help      Prints this help message\n\
   install   Creates a new Scudum instance from the most up-to-date remote Scudum\n\
   make.iso  Builds an ISO image with the current configuration\n\
   pack      Packs the current Scudum deployment into tar.gz file (requires no configuration)\n"

echo -e "$MESSAGE"
