#!/bin/bash
mxmlc src/Program.as -o output.swf
if [ "0" = $? ]
then
  open output.swf
  tail -f "/Users/towski/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"
fi
