#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Armor Daemon
# Copyright (c) 2008-2012 Hive Solutions Lda.
#
# This file is part of Hive Armor Daemon.
#
# Hive Armor Daemon is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Hive Armor Daemon is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Hive Armor Daemon. If not, see <http://www.gnu.org/licenses/>.

__author__ = "João Magalhães <joamag@hive.pt>"
""" The author(s) of the module """

__version__ = "1.0.0"
""" The version of the module """

__revision__ = "$LastChangedRevision$"
""" The revision number of the module """

__date__ = "$LastChangedDate$"
""" The last change date of the module """

__copyright__ = "Copyright (c) 2008-2012 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "GNU General Public License (GPL), Version 3"
""" The license for the module """

import flask

import quorum

class Base(quorum.Model):

    id = dict(
        type = int,
        index = True,
        increment = True,
    )

    enabled = dict(
        type = bool,
        index = True
    )

    instance_id = dict(
        index = True
    )

    @classmethod
    def get_i(cls, *args, **kwargs):
        instance_id = flask.session["instance_id"]
        return cls.get(
            enabled = True,
            instance_id = instance_id,
            *args,
            **kwargs
        )

    @classmethod
    def find_i(cls, *args, **kwargs):
        instance_id = flask.session["instance_id"]
        return cls.find(
            enabled = True,
            instance_id = instance_id,
            *args,
            **kwargs
        )

    def pre_create(self):
        self.enabled = True

        if not self.val("instance_id"):
            self.instance_id = flask.session.get("instance_id", None)

    def enable(self):
        store = self._get_store()
        store.update(
            {"_id" : self._id},
            {"$set" : {"enabled" : True}}
        )

    def disable(self):
        store = self._get_store()
        store.update(
            {"_id" : self._id},
            {"$set" : {"enabled" : False}}
        )
