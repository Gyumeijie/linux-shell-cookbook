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
## Quote rules

```bash
$ var="data"

$ echo "^'$var'$"
+ echo '^'\''data'\''$'
^'data'$

$ echo '"$var"'
+ echo '"$var"'
"$var"
```
`echo '^'\''data'\''$'`: `'^'` + `\'` + `'data'` + `\'` + `'$'`.
> '^' for; ^ \' for '; 'data' for data; '$' for $.

When we mixed need `''` and `""`, we have two patterns to choice: `"''"` or `'""'`.

For example, if we want `str` be `local data=$(sed 's/\-\{1,2\}\w\+//g' <<<"$@")`, we need assign it in this way:
`str="local data=\$(sed 's/\-\{1,2\}\w\+//g' <<<"'"$@")'`: `"local data=\$(sed 's/\-\{1,2\}\w\+//g' <<<"` + `'"$@")'`
The first part is the `"''"` pattern, and the second part is the `'""'`. 
> When use `"''"` pattern, we should escape special characters like `$` to prevent varibale expansion.

Another example, if we want `str` be `''`, we can't assign it with:
```bash
$ str='\'\''
```
`'\'\''` **!=** `'` + `\'` + `\'` + '. It should be interpreted as: `'\'` + `\'` + `'`, where the single `'` need one more `'` to terminate.

The right and simple way is to use the `"''"`: `str="''"`.
