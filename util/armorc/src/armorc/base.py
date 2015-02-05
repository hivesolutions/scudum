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

import socket

import armor

from . import actions

class ArmorClient(object):

    def __init__(self):
        self.api = None

    def run_boot(self):
        api = self.get_api()
        hostname, domain = self.get_domain()
        domains = api.list_domains(name = domain)
        if domains: self.handle_domain(domains[0])

    def handle_domain(self, domain):
        github_url = domain["github_url"]
        cifs_host = domain["cifs_host"]
        if github_url: actions.Actions.clone_github(github_url)
        if cifs_host:
            cifs_username = domain["cifs_username"]
            cifs_password = domain["cifs_password"]
            actions.Actions.mount_cifs(
                cifs_host,
                username = cifs_username,
                password = cifs_password
            )

    def get_domain(self):
        hostname = socket.gethostname()
        parts = hostname.rsplit(".")
        if len(parts) > 1: domain = parts[1]
        else: domain = "local"
        return hostname, domain

    def get_api(self):
        if self.api: return self.api
        self.api = armor.Api()
        return self.api
