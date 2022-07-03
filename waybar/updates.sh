#!/bin/bash
CHK=$(checkupdates | wc -l)
CHKAUR=$(yay -Qu | wc -l)

echo $(($CHK + $CHKAUR))
