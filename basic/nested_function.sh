#!/bin/bash

function countdown(){
   typeset count=$1

   while [ $count -gt 0 ];
   do 
      print_msg $count
      let count=count-1
   done
  
   function print_msg(){
      local count=$1
      echo "test nested function...... $count"
   }
}
