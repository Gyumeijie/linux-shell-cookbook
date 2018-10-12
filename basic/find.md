# Find files and execute a comman on each file
```bash
find . -name "filename" -exec ls -l {} \;
```
> The semicolon ';' is the commands separator, we should escape it by `\` or `';'` or `";"` before pass it to the `find` command.

# Rename files which match some pattern in batch 
Given the following files, then we need to rename them by removing the suffix of "?14145143".

```
./codegenSM.js?14145143
./events.js?14145143
./offline.js?14145143
./lib.js?14145143
./tabs.js?14145143
./codegenlib.js?14145143
./payment.js?14145143
./loadsave.js?14145143
./selectfuncs.js?14145143
./history.js?14145143
./css/bootstrap.min.css?14145143
./css/sh_typical.min.css?14145143
./actions.js?14145143
./main.js?14145143
./codegenPR.js?14145143
./props.js?14145143
./dragfuncs.js?14145143
./toolbars.js?14145143
./js/bootstrap-filestyle.js?14145143
./js/sh_main.min.js?14145143
./js/jquery.min.js?14145143
./js/diacritic2ascii.js?14145143
./js/filesaver.js?14145143
./js/raphael-min.js?14145143
./js/sh_cpp.min.js?14145143
./js/jquery.ui.min.js?14145143
./js/jszip.min.js?14145143
./js/jquery.slimscroll.js?14145143
./shortcuts.js?14145143
```
We can solve this problem by running the following command:
```bash
find ./ \( -name "*.js*" -o -name "*.css*" \) -exec ./exec.sh {} \;
```
> There must be a space after the `\(` and before `\)`

And following is the content of the exec.sh file:

```bash
#!/bin/bash
mv $1 ${1%\?*}
```

We can deal with more complicated situations by using ```sed``` or similar tools which can leverage regular expression, 
and in this example we can also use the following snippet:
```bash
mv $file $(echo $file | sed 's/\(?.*\)//')
```

Note that the `{}` will not be expanded to speicified filename when used in subshell, for example when we use the command
below, it is identical to running the ``` find ./  \( -name "*.js*" -o -name "*.css*" \) -exec mv {} {} \;```, which takes
no effect on removing the suffix.

```bash
find ./  \( -name "*.js*" -o -name "*.css*" \) -exec mv {} $(echo {} | sed 's/\(?.*\)//') \;

++ echo '{}'
++ sed 's/\(?.*\)//'
+ find ./ '(' -name '*.js*' -o -name '*.css*' ')' -exec mv '{}' '{}' ';'
```
