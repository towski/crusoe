#!/bin/bash
mxmlc GreenValley.as -o output.swf
if [ "0" = $? ]
then
  open output.swf
  tail -f "/Users/towski/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"
fi
