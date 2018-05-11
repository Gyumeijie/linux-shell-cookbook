#!/bin/bash

#string-length operator
string="0123456789"
echo "${#string}" #output: 10

#substring operator
#syntax {variable_name:start_position:length}
string="tonight"
echo "${string:0:2}" #output "to"

#replace some text from variable
#syntax {variable_name/pattern/replaced_string}
string="this is a line of text"
echo "${string/line/replaced}"
echo "${string/l*e /replaced }" #output: this is a replaced string


#string pattern matching, remove the matching pattern from original string
#syntax ${varname op pattern}
SOURCEFILE=/usr/local/src/helloworld.c

#removes minimal matching prefixes
echo ${SOURCEFILE#/*/} #output: local/src/helloworld.c

#removes maximal matching prefixes
echo ${SOURCEFILE##/*/} #output: helloworld.c


#removes minimal matching postfixes
echo ${SOURCEFILE%/*} #output: /usr/local/src/

#removes maximal matching postfixes
echo ${SOURCEFILE%%/*} #output: null  
