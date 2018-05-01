#!/bin/bash

origin=({0..10})

# syntax: `array[@]:s:l`
# array[@] returns the contents of the array, 
# :s:l takes a slice of length `l`, starting at index `s`.

left=${origin[@]:0:3}
right=${origin[@]:5:2}

# concatenate
new=(${left[@]} ${right[@]})

# output 0 1 2 5 6
echo ${new[@]}
