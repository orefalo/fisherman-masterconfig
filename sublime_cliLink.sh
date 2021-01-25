#!/bin/sh

# Setup the subl alias to SublimeText
if not test -L /usr/local/bin/subl
   and test -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
  rm -f /usr/local/bin/subl
  ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
end
