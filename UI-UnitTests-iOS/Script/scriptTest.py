#! /usr/bin/python

# __author__ = "Abderrahim BENMAKHLOUF"
# __date__ = "21/01/2018"
# __copyright__ = "Copyright 2018, Abderrahim BENMAKHLOUF"
# __version__ = "1.0.0"

#! /usr/bin/python
import sys
import os
from xml.etree import ElementTree as ET
from enum import Enum

fullPath = os.getcwd()
paths = fullPath.split('/')
n=len(paths)
targetName = paths[n-1]

def contains(subText, fullText):
    if subText in fullText: return True
    else: return False

storyboardIdentifier = ""
customClass = ""

# Need to Update the current enum to add your viewControllers to be mocked and launch `updateStoryboardForModule`
class ModulesNames(Enum):
    Dashboard = ["DashboardViewController", "Login"]
    Login = ["LoginViewController"]
    SignUp = ["SignUpViewController"]

    def getKey(self):
        return self.name

def getPathOf(fileName):
    for r,d,f in os.walk(fullPath):
        for files in f:
            if files == fileName:
                return os.path.join(r,files)

def updateStoryboardForModule(module):
    print "moduleName = "+module.getKey()
    moduleName = module.getKey()
    sourcePath = getPathOf(moduleName+".storyboard")
    destinationPath = getPathOf(moduleName+"Mock.storyboard")
    print "sourcePath = "+sourcePath
    print "destinationPath = "+destinationPath
    print "\n\n --------------------------- \n\n"
    print "targetName = "+targetName
    clearedLine = ""
    with open(sourcePath, "rw") as infile2:
        for line in infile2:
            appendLine = True
            for storyboardIdentifier in module.value:
                storyboardIdentifierStrict = "\""+storyboardIdentifier+"\""
                if contains("storyboardName", line) and contains(storyboardIdentifierStrict, line):
                    appendLine = False
                    clearedLine += line.replace(storyboardIdentifier, storyboardIdentifier+"Mock")
                else:
                    if contains(storyboardIdentifierStrict, line) and (contains("storyboardIdentifier", line) or contains("customClass", line)):
                        appendLine = False
                        clearedLine += line.replace(storyboardIdentifier, storyboardIdentifier+"Mock").replace("customModule=\""+targetName+"\"", "customModule=\""+targetName+"Tests\"")
            if appendLine:
                clearedLine += line
    open(destinationPath, 'w').close()
    with open(destinationPath, "a") as f:
        f.write(clearedLine)
    print "Refreshing "+moduleName+" completed!"

print "Dashboard module refreshing..."
updateStoryboardForModule(ModulesNames.Dashboard)

print "Login module refreshing..."
updateStoryboardForModule(ModulesNames.Login)

print "SignUp module refreshing..."
updateStoryboardForModule(ModulesNames.SignUp)

