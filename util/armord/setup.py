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

import os
import setuptools

setuptools.setup(
    name = "armord",
    version = "0.1.7",
    author = "Hive Solutions Lda.",
    author_email = "development@hive.pt",
    description = "Armor Daemon",
    license = "Apache License, Version 2.0",
    keywords = "armor daemon",
    url = "http://scudum.hive.pt",
    zip_safe = False,
    packages = [
        "armord",
        "armord.controllers",
        "armord.models"
    ],
    package_dir = {
        "" : os.path.normpath("src")
    },
    package_data = {
        "armord" : [
            "static/css/*",
            "static/fonts/*",
            "static/images/*.png",
            "static/images/*.ico",
            "static/js/*",
            "templates/*.tpl",
            "templates/partials/*.tpl"
        ]
    },
    install_requires = [
        "appier",
        "appier_extras",
        "jinja2",
        "pymongo"
    ],
    entry_points = {
        "console_scripts" : [
            "armord = armord.main:main"
        ]
    },
    classifiers = [
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2.6",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3.0",
        "Programming Language :: Python :: 3.1",
        "Programming Language :: Python :: 3.2",
        "Programming Language :: Python :: 3.3",
        "Programming Language :: Python :: 3.4"
    ]
)
