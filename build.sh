#!/bin/bash
/usr/local/flex_sdk_4/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true Island.as -o output.swf
if [ "0" = $? ]
then
  open output.swf
  tail -f "/Users/towski/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"
fi
