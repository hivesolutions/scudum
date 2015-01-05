#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Armor Daemon
# Copyright (c) 2008-2015 Hive Solutions Lda.
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

__copyright__ = "Copyright (c) 2008-2015 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "GNU General Public License (GPL), Version 3"
""" The license for the module """

import time

from armord import models

from armord.main import app
from armord.main import flask
from armord.main import quorum

BASE_URL = "http://hq.hive.pt:9999/repos/scu"
""" The base url to be used in the construction
of the repository targeted urls """

@app.route("/api/signin.json", methods = ("GET", "POST"), json = True)
def login_api():
    # retrieves the login related fields and runs the
    # login method on the user model using them
    username = quorum.get_field("username")
    password = quorum.get_field("password")
    account = models.Account.login(username, password)

    # updates the current user (name) in session with
    # the username that has just be accepted in the login
    flask.session["username"] = account.username
    flask.session["tokens"] = account.tokens
    flask.session["instance_id"] = account.instance_id

    # makes the current session permanent this will allow
    # the session to persist along multiple browser initialization
    flask.session.permanent = True

    # tries to retrieve the session identifier from the current
    # session but only in case it exists
    sid = hasattr(flask.session, "sid") and flask.session.sid or None

    return dict(
        sid = sid,
        session_id = sid,
        username = username
    )

@app.route("/api/info.json", methods = ("GET",), json = True)
@quorum.ensure("info", json = True)
def info_api():
    configuration = {
        "last_login" : time.time(),
        "resources" : [{
            "name" : "viriatum",
            "version" : "1.0.2b",
            "url" : "%s/viriatum_1.0.0-1_amd64.scu" % BASE_URL
        }]
    }

    return configuration
