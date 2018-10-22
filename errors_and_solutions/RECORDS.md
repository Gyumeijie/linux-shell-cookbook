# Introduction

This directory is used to record some commonly occuring errors and their solutions.

## Don't quote regexp in =~
```bash
$ string="example.jpg"
$ re=".*\.jpg"

$ if [[ $string =~ $re ]]; then echo "yes"; else echo "no"; fi
+ [[ example.jpg =~ .*\.jpg ]]
yes


if [[ $string =~ "$re" ]]; then echo "yes"; else echo "no"; fi
+ [[ example.jpg =~ \.\*\\\.jpg ]]
no
```
