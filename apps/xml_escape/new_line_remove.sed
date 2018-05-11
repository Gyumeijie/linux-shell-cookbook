
/^[^<]*$/{
 # append  pattern space to hold space
 # H
 # copy from hold space
 # g 
 # remove new line
 # s/\n//
  :top
  N
  /^[^<]*$/{
    s/\n//
  }
  
  # just jump, not have any other action, for example
  # no print
  /^[^<]*$/b top   
 
  # when flow reach here default behavior print will
  # executed   
}
