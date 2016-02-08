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

from . import base

class Domain(base.ArmorBase):

    name = appier.field(
        index = True,
        default = True
    )

    private_key = appier.field(
        meta = "longtext"
    )

    public_key = appier.field(
        meta = "longtext"
    )

    authorized_keys = appier.field(
        meta = "longtext"
    )

    cifs_path = appier.field(
        index = True
    )

    cifs_username = appier.field()

    cifs_password = appier.field(
        meta = "secret"
    )

    git_url = appier.field(
        index = True
    )

    @classmethod
    def validate(cls):
        return super(Domain, cls).validate() + [
            appier.not_null("name"),
            appier.not_empty("name"),
            appier.not_duplicate("name", cls._name())
        ]

    @classmethod
    def list_names(cls):
        return ["name", "description"]
