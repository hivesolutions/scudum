#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Armor Daemon
# Copyright (c) 2008-2016 Hive Solutions Lda.
#
# This file is part of Hive Armor Daemon.
#
# Hive Armor Daemon is free software: you can redistribute it and/or modify
# it under the terms of the Apache License as published by the Apache
# Foundation, either version 2.0 of the License, or (at your option) any
# later version.
#
# Hive Armor Daemon is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# Apache License for more details.
#
# You should have received a copy of the Apache License along with
# Hive Armor Daemon. If not, see <http://www.apache.org/licenses/>.

__author__ = "João Magalhães <joamag@hive.pt>"
""" The author(s) of the module """

__version__ = "1.0.0"
""" The version of the module """

__revision__ = "$LastChangedRevision$"
""" The revision number of the module """

__date__ = "$LastChangedDate$"
""" The last change date of the module """

__copyright__ = "Copyright (c) 2008-2016 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "Apache License, Version 2.0"
""" The license for the module """

import appier
import appier_extras

class ArmordApp(appier.WebApp):

    def __init__(self):
        appier.WebApp.__init__(
            self,
            name = "armord",
            parts = (
                appier_extras.AdminPart,
            )
        )
        self.theme = "modern"
        self.style = "romantic"
        self.libs = "current"
        self.login_redirect = "base.index"

def main():
    app = ArmordApp()
    app.serve()

if __name__ == "__main__":
    app = ArmordApp()
    app.serve()
