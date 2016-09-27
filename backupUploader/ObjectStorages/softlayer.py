# -*- coding: utf8 -*-

#!/usr/bin/env python
#
import requests, os
class slObjectStorage(object):
    def __init__(self, url, user, key):
        self.url = url
        self.user = user
        self.key = key
        self.authResponse()

    def authResponse(self):
        response = requests.get(self.url, headers={"X-Auth-Key": self.key, "X-Auth-User": self.user})
        self.authToken = response.headers['x-auth-token']
        self.storageToken = response.headers['x-storage-token']
        self.storageUrl = response.headers['x-storage-url']

    def checkContainer(self, container):
        container = self.extractContainerName(container)
        response = requests.head("%s/%s" % (self.storageUrl, container), headers={"X-Auth-Token": self.authToken})
        return response.ok

    def createContainer(self, container):
        container = self.extractContainerName(container)
        response = requests.put("%s/%s" % (self.storageUrl, container), headers={"X-Auth-Token": self.authToken})
        return response.status_code


    def deleteContainer(self, container):
        response = requests.delete("%s/%s" % (self.storageUrl, container), headers={"X-Auth-Token": self.authToken})
        return response.status_code


    def uploadFile(self, container, filePath):
        filename = os.path.basename(filePath)
        with open(filePath,'rb') as rawdata:
            response = requests.put("%s/%s/%s" % (self.storageUrl, container, filename), data=rawdata, headers={"X-Auth-Token": self.authToken, "X-Detect-Content-Type": True})
            result = "BackupUploader: Upload %s to %s with status %s (%s)" %(filePath, self.url, response.status_code, response.reason)
            return result

    def upload(self, container, path):
        if not self.checkContainer(container):
            self.createContainer(container)
        if os.path.isdir(path):
            files = self.listdir_fullpath(path)
        else:
            files = [path]
        for file in files:
            print(self.uploadFile(container, file))

    def listdir_fullpath(self, dir):
        return [os.path.join(dir, file) for file in os.listdir(dir) if os.path.isfile(os.path.join(dir, file))]

    def extractContainerName(self, container):
        result = container.split("/")
        return result[0]


