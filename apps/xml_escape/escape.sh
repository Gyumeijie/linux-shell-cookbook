#! /bin/bash

if [ $# -lt 2 ];
then
   echo "Usage: ./escape input_file output_file"  
   exit 1
else
   input_file=$1
   output_file=$2
fi 

# preprocess
cat $input_file | \

### delete tab
tr -d '\t'  |  \

### squash blanks into one single blank
tr -s ' '     |  \

sed -f main.sed  | \
sed -f new_line_remove.sed > $output_file 

