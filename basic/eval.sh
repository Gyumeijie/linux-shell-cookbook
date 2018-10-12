#!/bin/bash

start=0; end=10

# only output {0..10}, not evaluate further
# range={$start..$end}

# use eval to make this work
# + eval echo '{0..10}'
# ++ echo 0 1 2 3 4 5 6 7 8 9 10
# 0 1 2 3 4 5 6 7 8 9 10
range=`eval echo {$start..$end}`

echo $range
