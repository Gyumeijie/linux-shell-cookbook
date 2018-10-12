# Introduction

This directory is used to record some basic but important concepts of bash.

# Variables
## Scope
### Cross process

#### Environment 
When a program is invoked it is given an array of strings called the **environment**. This is a list of name−value pairs, of the form name=value.
#### Manipulate the environment
- add
```bash
export variable[=value]
declare −x variable[=value]
typeset -x variable[=value]
```
- remove
```bash
unset variable
```

### In process
- global variables (process scope)
```bash
variable=value
typeset -g variable[=value]
declare -g variable[=value]
```

- local variables (function scope)
```bash
local variable[=value]
typeset variable[=value]
declare variable[=value]
```

## Type
There are only types supported in bash: integer and string. The default type is string, but we can explicitly declare it as an integer through ```decalre -i variable[=value]``` or ```typeset -i variable[=value]```.

```bash
declare string
string=1+1
echo $string # 1+1
```

```bash
declare -i integer
integer=1+1
echo $integer # 2
```

## Arithmetic evaluation
The shell allows arithmetic expressions to be evaluated, under certain circumstances:
- let  builtin command
```bash
x=1

let y=$x+1
z=$x+1

echo $y # 2
echo $z # 1+1
```

- declare  builtin command
```bash
declare -i integer
integer=1+1
echo $integer # 2
```

- Arithmetic Expansion 

> Syntax: $((expression))

```bash
x=1
y=9
echo $(( (x+1)*(y+1) )) # 20
```
> In `$(( ))` we don't need to use `$id`, using `id` alone is allowed.


# Parameters
## Positional Parameters
A ***positional parameter*** is a parameter denoted by one or more digits, other than the single digit 0.

Positional parameters are assigned from the shell's arguments when it is invoked, and may be reassigned using
the **set** builtin command.

```
#! /bin/bash

set "new value"
echo "$1" 
# result: "new value"
```

Note that positional parameters may not be assigned to with `assignment statements`:
```bash
#! /bin/bash

1="new value"
# result: "Error: 1=new value: command not found"
```
since **identifier** is a word consisting only of alphanumeric characters and underscores, and beginning with an alphabetic
character or an underscore. The `1` alone can not be a valid identifier.

The positional parameter can be also used in some forms of ***parameter expansion***:
```bash
#! /bin/bash

# given $1 is '/home/tmp'
echo ${1%/*} 
# result: "/home"

# given no parameters provided
echo "${1:?The '$1' is unset}" 
# result: "The $1 is unset"

# given $1 is "$1 is a string"
echo "${#1}"
# result: "14"
```

For we cann't assign the positional parameter, the following expansion is not allowed:
```bash
#! /bin/bash

echo ${1:="assin default values"}
# result: "Error:  cannot assign in this way"
```

