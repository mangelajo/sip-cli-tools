#!/bin/sh
#
# This code is licensed under the GPLv2 LICENSE
#
# Author: Miguel Angel Ajo <majopela@redhat.com>
# Thanks to Russel Bryant for pointing me to a decent SIP cli client
# which allowed call transfers
#
# bridge-dial.sh
#
# this is a tool to dial a bridge conference, and then transfer
# the call to your desktop phone automatically.
#
# It's just a quick & dirty test which could be evolved into
# something more reasonable, like a python script using the
# pjsua scripting capabilities.
#
#
# Usage:
#
# make sure to have your settings at ~/.bridge_dial
#
# bridge-dial.sh conference-number
#
# or, if you wanted to callback into a different place:
#
# dial.sh phone-number [callback-number]
#

set -e

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIRECTORY/sip-cli-tools.functions

sip_cli_tool_checks

source ~/.bridge_dial


PHONE_NUMBER=$1
MY_EXTENSION=${2:-$MY_EXTENSION}

if [ "$PHONE_NUMBERx"=="x" ]; then
   echo "Usage:"
   echo ""
   echo "   dial.sh phone-number [callback-number]"
   echo ""
fi

function pjsua_cli_commands() {
   sleep 5
   echo "\nDIALING INTO THE NUMBER $PHONE_NUMBER" >&2
   echo m ; echo "sip:$PHONE_NUMBER@sip.redhat.com"
   sleep 5
   echo "\nTRANSFERING BACK TO  $MY_EXTENSION" >&2
   echo "x";  echo "sip:$MY_EXTENSION@sip.redhat.com"
   sleep 10
   echo "\nDONE, CLOSING" >&2
   echo "q"
}

pjsua_cli_commands | pjsua_client



