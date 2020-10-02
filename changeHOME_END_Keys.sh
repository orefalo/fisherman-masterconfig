#!/bin/bash

mkdir -p ~/Library/KeyBindings

cat << EOF > ~/Library/KeyBindings/DefaultKeyBinding.dict
{
    "\UF729"  = moveToBeginningOfLine:; // home
    "\UF72B"  = moveToEndOfLine:; // end
    "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
}
EOF

