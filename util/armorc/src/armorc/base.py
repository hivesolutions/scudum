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

import os
import shutil
import socket
import tempfile
import subprocess

import armor

class ArmorClient(object):

    def __init__(self, data_path = "/data"):
        self.data_path = data_path
        self.api = None
        self.hostname = None
        self.domain = None

    def run_boot(self):
        api = self.get_api()
        self.hostname, self.domain = self.get_domain()
        domains = api.list_domains(name = self.domain)
        if not domains: return
        self.domain_info = domains[0]
        self.temp_path = tempfile.mkdtemp()
        print("Changing directory into '%s'..." % self.temp_path)
        try:
            os.chdir(self.temp_path)
            self.handle_domain()
        finally:
            shutil.rmtree(self.temp_path)

    def handle_domain(self):
        self.deploy_ssh()
        self.mount_cifs()
        self.clone_github()

    def deploy_ssh(self):
        print("Deploying SSH credentials ...")
        private_key = self.domain_info["private_key"]
        public_key = self.domain_info["public_key"]
        authorized_keys = self.domain_info["authorized_keys"]
        if private_key:
            self.write_file("/root/.ssh/id_rsa", private_key, mode = 0o600)
        if public_key:
            self.write_file("/root/.ssh/id_rsa.pub", public_key, mode = 0o644)
        if authorized_keys:
            self.write_file("/root/.ssh/authorized_keys", authorized_keys, mode = 0o600)

    def mount_cifs(self):
        cifs_path = self.domain_info["cifs_path"]
        cifs_username = self.domain_info["cifs_username"]
        cifs_password = self.domain_info["cifs_password"]
        if not cifs_path: return
        if not cifs_username: return
        if not cifs_password: return
        print("Mounting CIFS share from '%s' into '%s'" % (cifs_path, self.data))
        if not os.path.exists(self.data_path): os.makedirs(self.data_path)
        pipe = subprocess.Popen(
            [
                "mount", "-t", "cifs", "-o",
                "username=" + cifs_username + ",password=" + cifs_password,
                cifs_path, self.data_path
            ]
        )
        pipe.wait()

    def clone_github(self):
        git_url = self.domain_info["git_url"]
        if not git_url: return
        print("Cloning git repository '%s'" % git_url)
        self.write_file(
            "ssh",
            "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $*",
            mode = 0o700
        )
        os.environ["GIT_SSH"] = "./ssh"
        pipe = subprocess.Popen(
            ["git", "clone", "--depth", "1", git_url, "git"]
        )
        pipe.wait()
        git_path = os.path.join(self.temp_path, "git")
        host_path = os.path.join(git_path, self.hostname)
        if not os.path.exists(host_path): return
        system_path = os.path.join(host_path, "system")
        system_exits = os.path.exists(system_path)
        if system_exits: self.copy_tree(system_path, "/")

    def write_file(self, path, data, mode = None):
        dir_path = os.path.dirname(path)
        dir_exists = dir_path == "" or os.path.exists(dir_path)
        if not dir_exists: os.makedirs(dir_path)
        file = open(path, "wb")
        try: file.write(data)
        finally: file.close()
        if not mode: return
        os.chmod(path, mode)

    def copy_tree(self, source, destiny):
        for source_dir, _dirs, files in os.walk(source):
            destiny_dir = source_dir.replace(source, destiny)
            if not os.path.exists(destiny_dir): os.mkdir(destiny_dir)
            for _file in files:
                source_file = os.path.join(source_dir, _file)
                destiny_file = os.path.join(destiny_dir, _file)
                if os.path.exists(destiny_file): os.remove(destiny_file)
                shutil.copy2(source_file, destiny_dir)

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
