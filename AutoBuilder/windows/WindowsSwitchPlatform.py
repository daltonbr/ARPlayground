#!/usr/bin/env python3-64

# Windows 10
# You can associate this file in Windows in order to avoid calling the Python interpreter
# right click -> Open With -> Choose Another App, and then choose Python.

import sys
import os
import shutil
from pathlib import Path

def RemoveLibraryDirErrorHandler(func, path, exc_info):  
    print("❌[Error] Cannot find or remove Library folder")
    print(exc_info)
    exit()

def TryKillUnityHub():
    print("🪓 Trying to kill Unity Hub processes")
    killHubCmd = 'wmic process where name="Unity Hub.exe" call terminate'
    os.system(killHubCmd)

def find_unityprocesses():
    print("⏳ Trying to find Unity Processes")
    # Need improvements, any Process with the name 'Unity' will trigger this check
    # wmic is a cli for Windows 
    with os.popen('wmic process where "name like \'%Unity%\'" get name, processid /format:table') as textfile:
        contents = textfile.read()
        
        # when the (log) textfile above is 'empty' his length is 4
        if (len(contents) > 4):
            # processes found
            print (contents)
            return True
        else:
            return False
    return 0

sys.stdout.write("🐱‍👓--== Windows Unity Platform Switcher! ==--\n🐍 Powered by Python %s\n\n" % (sys.version))

platformToSwitch = ''

if (len(sys.argv) == 2):
    if (sys.argv[1] == 'ios'):        
        platformToSwitch = 'ios'
    elif (sys.argv[1] == 'android'):        
        platformToSwitch = 'android'
    else:
        print("❌[Error] Invalid argument.")
        print(" USAGE")
        print("$ WindowsSwitchPlatform.py <android>|<ios>")
        exit()
else :
    print("❌[Error] Wrong number of arguments.")
    print(" USAGE")
    print("$ WindowsSwitchPlatform.py <android>|<ios>")
    exit()

found = find_unityprocesses()

if found:    
    TryKillUnityHub()
    found = find_unityprocesses()
    if found:
        print("🤗 Please close Unity Processess manually and run it again.")
        exit()
else:
    print("✅ All Unity processes are closed")

# `path.parents[1]` is the same as `path.parent.parent`
# we start this script 2 levels bellow projectDir, we can improve this part
projectDir = Path(__file__).resolve().parents[2]
if os.path.isfile(os.path.join(projectDir, 'ProjectSettings/ProjectVersion.txt')):
    print("✅ Find project root directory ", projectDir)
else:
    print("❌[Error] Cannot find project root directory", projectDir)
    exit()

libraryDir = os.path.join(projectDir, 'Library')
platformDir = os.path.join(projectDir, platformToSwitch + 'Library')

if os.path.islink(libraryDir):
    print("✅ Old Library symlink found, deactivating it", libraryDir)
    os.unlink(libraryDir)
else:
    print("✅ Trying to remove Library folder")
    shutil.rmtree(libraryDir, onerror = RemoveLibraryDirErrorHandler)

if (os.path.isdir(platformDir)):
    print("✅ Find target platform library: ", platformDir)
else:
    print("✅ Creating target platform library: ", platformDir)
    os.mkdir(platformDir)

print("✅ Creating new Library symlink", platformDir)
os.symlink(platformDir, libraryDir, target_is_directory = True)    
print("🎉 Platform switched!")

# Force kill Unity Hub
# wmic process where name="Unity Hub.exe" call terminate
 
# find all processes with the name 'Unity' and export to a csv file
# wmic process where "name like '%Unity%'" get name, processid /format:csv > unity.txt

#wmic process where name='Unity.exe' call terminate
#wmic process where name='Unity Hub.exe' call terminate