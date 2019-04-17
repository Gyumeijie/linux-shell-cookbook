# Environment
When a program is invoked it is given an array of strings called the ***environment***. This is a list of `name-value` pairs, of the form of **name=value**.

## Put an entry into the environment
The following snippet is an **C** program, which calls the `getenv` to get an environment entry whose name is ***author***, and then print it out if exists, in other words being put into the environment by the **bash**.
```c
#include<stdio.h>
#include<stdlib.h>

int main(int argc, char* argv[], char* envp[]) {
    char* val = getenv("author");
    if (val != NULL) {
        printf("%s\n", val);
     }
}

```
```bash
$ gcc -o main main.c
```
Parameter assignments which preced the command name will be placed in the **environment** by shell, otherwise not. 
```bash
$ author=Gyumeijie ./main 
Gyumeijie
```
```bash
$ ./main  author=Gyumeijie 
```

If the **−k** option is set, then all `parameter assignments` are placed in the **environment** for a command, not just those that precede the command name.
```bash
$ bash -k << EOF
heredoc> ./main author=Gyumeijie
heredoc> EOF
Gyumeijie
```
