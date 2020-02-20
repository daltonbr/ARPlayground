#!/usr/bin/env bash

# osxbuild
# check the editor log for erros
# Mac OS X ~/Library/Logs/Unity/Editor.log
# Windows C:\Users\username\AppData\Local\Unity\Editor\Editor.log

custom_parameters=$1
build_platform=$2

dispatch_unity_exit_code()
{   
    ### 0> are for successful exit codes
    if [ $1 -eq 0 ] ; then
        echo "Unity closes without any extra information"
    elif [ $1 -eq 2 ] ; then
        echo "Android Development build is done"
    elif [ $1 -eq 4 ] ; then
        echo "Android Production build is done"
    elif [ $1 -eq 6 ] ; then
        echo "Android Development and Production builds are done"
    elif [ $1 -eq 8 ] ; then
        echo "XCode Project for Development is done"
    elif [ $1 -eq 16 ] ; then
        echo "XCode Project for Production is done"
    elif [ $1 -eq 24 ] ; then
        echo "XCode Project for Developement and Production are done"        
    ### >127 are reserverd for Errors (except 1)
    elif [ $1 -eq 1 ] ; then
        echo "[ERROR] Please check the Editor.log for more information"
    elif [ $1 -eq 127 ] ; then
        echo "[ERROR] Please check the Editor.log for more information"
    elif [ $1 -eq 253 ] ; then
        echo "[ERROR] autoBuilderSettings.asset not found in Unity"
        echo "please check the variable <autoBuilderSettingsPath> inside AutoBuilder class "        
    elif [ $1 -eq 254 ] ; then
        echo "[ERROR] Wrong Active Build. iOS Failed! (254)"        
    elif [ $1 -eq 255 ] ; then
        echo "[ERROR] Wrong Active Build. Android Failed (255)"        
    ### 199< is reserved for ./osxswitchplatform script
    elif [ $1 -eq 199 ] ; then    
        echo "[ERROR] Switching builds error"
    elif [ $1 -eq 198 ] ; then    
        echo "[ERROR] Switching builds error"
    elif [ $1 -eq 197 ] ; then    
        echo "[ERROR] Switching builds error"
    else
        echo "[ERROR] Unity Exit code not expected! ($1)"
    fi

    return $1
}

find_unity_version()
{
    #first_line=$(head -1 $HOME/Projects/SeeMore360/ProjectSettings/ProjectVersion.txt)
    #echo "$first_line"
    #unity_version=$(cut -d' ' -f2 $first_line)
    unity_version=$(head -1 $HOME/Projects/SeeMore360/ProjectSettings/ProjectVersion.txt | awk '{print $2}')
    if [ $? -eq 0 ] ; then    
        echo "Found Unity version $unity_version for this building process"
    else
        echo "Cannot find Unity [<ProjectRoot>/ProjectSettings/ProjectVersion.txt] file to grab the current Unity Version."
        echo "Please run this shell script from [<ProjectRoot>/AutoBuilder/]"
        exit 196
    fi
}

run_unity_command()
{
    # There is a small Unity bug when trying to override the Editor log,
    # Unity returns unexpected exit codes, so for now we are leaving the 
    # Editor.log as default
    
    #date=`date '+%Y-%m-%d_%H:%M:%S'`
    #editor_path="$projectpath/AutoBuilder/UnityEditorLog.log"    
    #$(Unity $custom_parameters -buildTarget $build_platform -quit -batchmode -serial $unity_serial -username $unity_username -password $unity_password -projectPath $projectpath -executeMethod $executemethod -logFile $editor_path)        
    $(Unity $custom_parameters -buildTarget $build_platform -quit -batchmode -serial $unity_serial -username $unity_username -password $unity_password -projectPath $projectpath -executeMethod $executemethod)    
}

echo " --== Starting Automated Build Process ==-- "

find_unity_version
export PATH="$PATH:/Applications/Unity/Hub/Editor/$unity_version/Unity.app/Contents/MacOS"

# Load Unity Login data
source ../.keys/unity_login_data.sh

# Load project settings
source ./autobuilder_settings.sh

run_unity_command
dispatch_unity_exit_code $?
unity_exit_code=$?

echo "unity_exit_code: $unity_exit_code"
exit $unity_exit_code
