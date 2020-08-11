#!/bin/bash
#
# Open new Terminal tabs from the command line
#
# Author: Justin Hileman (http://justinhileman.com)
#
# Installation:
#     Add the following function to your `.bashrc` or `.bash_profile`,
#     or save it somewhere (e.g. `~/.tab.bash`) and source it in `.bashrc`
#
# Usage:
#     itermTab                   Opens the current directory in a new tab
#     itermTab [PATH]            Open PATH in a new tab
#     itermTab [CMD]             Open a new tab and execute CMD
#     itermTab [PATH] [CMD] ...  You can prob'ly guess

# Only for the Mac users
[ `uname -s` != "Darwin" ] && return

function itermTab () {
    local cmd=""
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm"
            activate
            tell current window to set tb to create tab with default profile
            tell current session of current window to write text  "cd \"$cdto\"$cmd"
        end tell
EOF
}
