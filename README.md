sip-cli-tools
=============

Tools for call &amp; transfer to deskphone and/or conferencing &amp; transfer over SIP

* dial.sh will dial into a phone number, and transfer that to your desktop phone

Usage:
     dial.sh phone-number [callback-phone-number]


* bridge-dial.sh will dial into a conference server, dial a conference number,
                 and then transfer it back to your desktop phone.

Usage:
     bridge-dial.sh conference-number [callback-phone-number]



prepend DEBUG=1 to dial.sh o bridge-dial.sh if you want debug information
on SIP signaling, etc...
