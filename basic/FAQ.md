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
