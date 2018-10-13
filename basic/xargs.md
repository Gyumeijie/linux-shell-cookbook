# Why xargs

We use pipes to redirect `stdout`(standard output) of a command to `stdin`(standard input) of another command. For example:

```bash
   cat foo.txt | grep "test"
```

Some of the commands accept data as **command-line arguments** rather than a data stream through **stdin**(standard input). In that case, we cannot use pipes to supply data through command-line arguments. :star: :star: 

Take the `ls` as an example:
```bash
echo "filename" | ls -l  # not work

echo "filename" | xargs ls -l # works
```

**xargs** is a very useful command in handling `standard input data` to the `command-line argument` **conversions** :star:. 

Also, xargs can convert any one-line or multiple-line text inputs into other formats, such as multiple lines(specified number of columns) or a single line and vice versa.

- Converting multiple lines of input to a single-line output

```bash
$ cat example.txt  # Example file
1 2 3 4 5 6
7 8 9 10
11 12


$ cat example.txt | xargs
1 2 3 4 5 6 7 8 9 10 11 12
```

- Converting single-line into multiple-line output

```bash
$ cat example.txt | xargs -n 3
1 2 3 
4 5 6
7 8 9
10 11 12
```

In default, ***xargs*** takes the **IFS**(internal field separator) as the ***input delimiter***, we can use `-d` option to specify a custom input delimiter:
```bash
$ echo "splitXsplitXSplitXsplitX" | xargs -d X
split split split split
```

### Passing formatted arguments to a command
```bash
$ cat args.txt | xargs -n 1 command
```

In the exmpale above, we execute the `command` multiple times with one argument per execution. In some complex case, we need to construct command with argument passed by xargs more flexibly, including the ***position*** and the ***times*** it appears in a command. In that case, we can resort to using **-I** to specify a replacement string that will be replaced while `xargs expands`.

```bash
$ cat args.txt | xargs -I {} mv {} {}.bak 
+ xargs -I '{}' mv '{}' '{}.bak'
+ cat args.txt
```

Note that the `xargs expansion` is very different from the shell's, there are no so called seven steps of expansion. Therefore we cannot use shell expansions such as parameter expansion.

```
$ cat filenames.txt | xargs -I fn mv fn '${fn%.*}' 
+ xargs -I fn mv fn '${fn%.*}'
+ cat filenames.txt
```

After execution, all filenames in `filenames.txt` are all rename to `${filename%.*}`, where filename is one specific entry in `filenames.txt`. But removing the suffix of all files is our destination, the problem is in the `xargs expansion`, which does nothing but replace replacement string specified by -I, so every `${fn%.*}` is ***xargs expanded to*** `${filename%.*}` instead of the known ***parameter expansion***. 

To solve the problem above, we can introduce a script file `remove_suffix.sh`:
```bash
#! /bin/bash
mv $1 ${1%.*}
```
Correspondingly, The old command becomes:
```bash
$ cat filenames.txt | xargs -I fn ./remove_suffix.sh fn 
```

### Using xargs with find

xargs and find are best friends, They can be combined to perform tasks easily. Usually, people combine them in the wrong way.
For example: 

```bash
$ find . -type f -name "*.txt" -print | xargs rm -f 
```
This is dangerous. It may sometimes cause removal of unnecessary files. Often, we cannot predict the delimiting character, whether it is `\n` or `' '` for the output of the find command. Many filenames may contain a space and hence, xargs may misinterpret it as a delimiter(for example, "hello world.txt" will be misinterpreted by xargs as "hello" and "world.txt").

Hence, we should use `-print0` along with find to explicitly produce an output with a sequence filenames delimited by character null('\0') **whenever** we use the `find` output as the xargs input. :star: :star:

```bash
$ find . -type f -name "*.txt" -print0 | xargs -0 rm -f
```
### Caveats

##### #1 `-n` vs `-I {}`

`-I {}` specifies the replacement string. For each of the arguments supplied for the
command, the `{}` string will be replaced with arguments read through stdin.

The default command is `echo` if no command specified, and argument(s) provided to the command is determined by `-n`:
```bash
echo -e "1\n2\n3\n4\n5" | xargs -tpr -n 2 

+ xargs -tpr -n 2
+ echo -e '1\n2\n3\n4\n5'
echo 1 2 ?...
echo 3 4 ?...
echo 5 ?...
```

Explicitly provide a command instead of the default command `echo`, and argument(s) provided to the command is still determined by `-n`:
```bash
$ echo -e "1\n2\n3\n4\n5" | xargs -tpr -n 2 ls

+ xargs -tpr -n 2 ls
+ echo -e '1\n2\n3\n4\n5'
ls 1 2 ?...
ls 3 4 ?...
ls 5 ?...
```

Explicitly provide a command and the argument(denoted by repalcement string {}), so the `-n` will be "overridden":

```bash
echo -e "1\n2\n3\n4\n5" | xargs -tpr -n 2 -I {} ls {}

+ xargs -tpr -n 2 -I '{}' ls '{}'
+ echo -e '1\n2\n3\n4\n5'
ls 1 ?...
ls 2 ?...
ls 3 ?...
ls 4 ?...
ls 5 ?...
```
> So the `-n` should not use with the `-I {}`.

Another difference between `-n` and `-I{}` is the "default delimiter" applied to split arguments.

```bash
$ echo -e "1 2\n3\n4 5" | xargs -tpr -n 2
+ xargs -tpr -n 2
+ echo -e '1 2\n3\n4 5'
echo 1 2 ?...
echo 3 4 ?...
echo 5 ?...
```
The default delimiter for `-n` includes space(' ') and newline('\n').

```bash
$ echo -e "1 2\n3\n4 5" | xargs -tpr -I{} ls {}
+ xargs -tpr '-I{}' ls '{}'
+ echo -e '1 2\n3\n4 5'
ls 1 2 ?...
ls 3 ?...
ls 4 5 ?...

$ echo -e "1 2\n3\n4 5" | xargs -tpr -n 3 -I{} ls {}
+ xargs -tpr -n 3 '-I{}' ls '{}'
+ echo -e '1 2\n3\n4 5'
ls 1 2 ?...
ls 3 ?...
ls 4 5 ?...
```
The default delimiter for `-I{}` olny includes the newline('\n').
