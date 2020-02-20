#!/usr/bin/env bash

valid_parameters=""
android=false
ios=false
dev=false
prod=false
increment_build=true

function show_help
{
    echo "      usage: .autobuilder.sh [-android | -ios] [-dev | -prod] [-noincrement] [-all]"
    echo "          -all                is equivalent of -android -ios -dev -prod"
    echo "          -noincrement        turn-off build version auto-increment"
    echo "      example:"
    echo "          $ .autobuider.sh -android -dev -prod"
    echo "          $ .autobuider.sh -ios -dev"
    echo "          $ .autobuider.sh -all"
}

function handle_switch_platform_exit_codes
{
    # just propagating the exit code
    case $1 in
        196|197|198|199)        
        exit $1
        ;;
    esac
}

# Show help information when no no parameters (or -h) are inputed
if [[ $# = 0 || $1 = "-h" ]] ; then    
    show_help
    exit
fi

# "parse" the arguments
for var in "$@"
do
    ### -all is equivalent to -ios -android -dev -prod
    if [ "$var" = "-all" ] ; then
        valid_parameters=$valid_parameters"-dev -prod "
        dev=true
        prod=true
        android=true
        ios=true
        break
    elif [ "$var" = "-dev" ] ; then
        valid_parameters=$valid_parameters"-dev "
        dev=true
    elif [ "$var" = "-prod" ] ; then
        valid_parameters=$valid_parameters"-prod "    
        prod=true
    elif [ "$var" = "-android" ] ; then
        android=true
    elif [ "$var" = "-ios" ] ; then
        ios=true    
    elif [ "$var" = "-noincrement" ] ; then
        increment_build=false
    fi
done

# Check for -android or -ios tags
if [[ $ios = false && $android = false ]] ; then
    echo "Invalid command: you need to supply at least one build platform: [-android] or [-ios]"
    show_help
    exit 1
fi

# Check for -dev or -prod tags
if [[ $dev = false && $prod = false ]] ; then
    echo "Invalid command: you need to supply at least: [-dev] or [-prod]"
    show_help
    exit 1
fi

# Android build
if [ "$android" = true ] ; then
    echo "[$(date '+%H:%M:%S')] Switching Build for Android"
    ./osxswitchplatform.sh android
    handle_switch_platform_exit_codes $?
    # increment build check
    increment_build_parameter=""
    if [ "$increment_build" = true ] ; then
        echo "Incrementing build on Android"    
        increment_build=false # this is to avoid to increment the build number twice
        increment_build_parameter=" -increment_build"
    fi    
    ./autobuilder_dispatcher.sh "$valid_parameters $increment_build_parameter -android" "Android"
fi

# iOS buid
if [ "$ios" = true ] ; then
    echo "[$(date '+%H:%M:%S')] Switching Build for iOS"
    ./osxswitchplatform.sh ios    
    handle_switch_platform_exit_codes $? 
    # increment build check
    increment_build_parameter=""
    if [ "$increment_build" = true ] ; then
        echo "Incrementing build on iOS"
        increment_build=false # this is to avoid to increment the build number twice
        increment_build_parameter=" -increment_build"
    fi    
    ./autobuilder_dispatcher.sh "$valid_parameters $increment_build_parameter -ios" "iOS"
fi
