# -*- coding: utf8 -*-

#!/usr/bin/env python
#
import sys
from ObjectStorages.softlayer import *
from configobj import ConfigObj
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--container', help='Container for upload')
parser.add_argument('--path', help='Path to file or dir for upload')
parser.add_argument('--config', help='Path to config file')
container = parser.parse_args().container
path = parser.parse_args().path
configFile = parser.parse_args().config

config = ConfigObj(configFile)
url = config['upload_url']
user = config['upload_user']
key = config['upload_key']

storage = slObjectStorage(url, user, key)
storage.upload(container, path)
