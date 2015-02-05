#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Armor
# Copyright (c) 2008-2015 Hive Solutions Lda.
#
# This file is part of Hive Armor.
#
# Hive Armor is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Hive Armor is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Hive Armor. If not, see <http://www.gnu.org/licenses/>.

__author__ = "João Magalhães <joamag@hive.pt>"
""" The author(s) of the module """

__version__ = "1.0.0"
""" The version of the module """

__revision__ = "$LastChangedRevision$"
""" The revision number of the module """

__date__ = "$LastChangedDate$"
""" The last change date of the module """

__copyright__ = "Copyright (c) 2008-2015 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "GNU General Public License (GPL), Version 3"
""" The license for the module """

import sys

import armorc

def main():
    # validates that the provided number of arguments
    # is the expected one, in case it's not raises a
    # runtime error indicating the problem
    if len(sys.argv) < 2: raise RuntimeError("Invalid number of arguments")

    # unpacks the second argument as the name of the script
    # that is meant to be run for armor
    command_name = sys.argv[1]

    # retrieves the set of extra arguments to be sent to the
    # command to be executed, (this may be dangerous)
    args = sys.argv[2:]

    # creates the new client object that will be used to perform
    # the requested command, this is considered a temporary object
    client = armorc.ArmorClient()

    # validates if the command name is valid for the current
    # armor context, raising an exception in case it's not
    if not hasattr(client, "run_" + command_name):
        raise RuntimeError("Invalid number of arguments")

    # retrieves the reference to the command function from the
    # current context and then calls it with the arguments
    command = getattr(client, "run_" + command_name)
    command(*args)

if __name__ == "__main__":
    main()
