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
# bridge-dial.sh conference-number callback-number
#


set -e

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIRECTORY/sip-cli-tools.functions

sip_cli_tool_checks

source ~/.bridge_dial

CONFERENCE_NUMBER=${1:-$CONFERENCE_NUMBER}
MY_EXTENSION=${2:-$MY_EXTENSION}

function pjsua_cli_commands() {
   sleep 5
   echo "DIALING INTO THE BRIDGE $BRIDGE_NUMBER" >&2
   echo m ; echo "sip:$BRIDGE_NUMBER@sip.redhat.com"
   sleep 10
   echo "ENTERING CONFERENCE NUMBER $CONFERENCE_NUMBER" >&2
   for key in $(echo $CONFERENCE_NUMBER | fold -w1); do
      echo "*";  echo $key
      sleep 0.4
   done
   echo "*"; echo "#"
   sleep 2 # leave some time to let it send all the DTMFs
           # before transfer
   echo "TRANSFERING BACK TO  $MY_EXTENSION" >&2
   echo "x";  echo "sip:$MY_EXTENSION@sip.redhat.com"
   sleep 10
   echo "DONE, CLOSING" >&2
   echo "q"
}

pjsua_cli_commands | pjsua_client
