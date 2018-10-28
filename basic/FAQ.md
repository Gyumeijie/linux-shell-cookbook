## [ vs [[

First in bash, `[` is a shell builtin, and `[[` is a shell keyword.
```bash
$ type [
[ is a shell builtin

$ type [[
[[ is a shell keyword
```

`[` and `test` evaluate ***conditional expressions***(`[ expr ]` or `test expr`).
> For `[` is just a regular command with a "weird name". All expansion will be performed on the words between the `[` and `]`.

Example of `word splitting` and `pathname expansion`, given there are two files-`file1` and `file2` in current directory:
```bash
$ if [ $(echo "string substring") * ]; then echo "yes"; fi
++ echo 'string substring'
+ '[' string substring file1 file2 ']'
bash: [: too many arguments
```



`[[ expression ]]` return a status of 0 or 1 depending on the evaluation of the ***conditional expression***`expression`.
> `Word splitting` and `pathname expansion` are not performed on the words between the `[[` and `]]`; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote removal are performed.

Example of `word splitting` and `pathname expansion`:
```bash
$ cat test.sh
#!/bin/bash

echo "$1" 
echo "$2"
$ ./test.sh $(echo "string substring")
++ echo 'string substring'
+ ./test.sh string substring
string
substring

$ if [[ string substring = * ]]; then echo "yes"; fi
bash: conditional binary operator expected
bash: syntax error near `substring'

$ ls *
...(lots of files)
```

Example of no `word splitting` and `pathname expansion` between the [[ and ]]: 
```bash
$ if [[ $(echo "string substring") = * ]]; then echo "yes"; fi
++ echo 'string substring'
+ [[ string substring = * ]]
+ echo yes
```
The `*` does not pathname expand to all files in current directory. And the result of `$(echo "string substring")` is not word split into two parts: `string` and `substring`.


## == vs =

The `=` operator is equivalent to `==`. But `==` is a bash extension.


## Pathname Expansion vs Pattern Matching

> `Pathname Expansion` = `set +f` + `Pattern Matching`

After word splitting, unless the ***−f*** option has been set, bash scans each word for the characters `*`, `?`, and `[`. If one of these characters appears, then the word is regarded as a pattern, and replaced with an alphabetically sorted list of `filenames` matching the `pattern`.

Example of no pathname expansion:
```bash
$ set -f
$ ls *
+ ls --color=auto '*'
ls: cannot access '*': No such file or directory


$ if [ "*" = * ]; then echo "yes"; fi
+ '[' '*' = '*' ']'
+ echo yes
yes


$ if [[ "string" = * ]]; then echo "yes"; fi
+ [[ string = * ]]
+ echo yes
yes
```

Example of pathname expansion:
```bash
$ ls
file1  file2  file3

$ set +f
$ ls *
+ ls --color=auto file1 file2 file3
file1  file2  file3 

$ ls file[12]
+ ls --color=auto file1 file2
file1  file2
```

