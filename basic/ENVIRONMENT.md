# Environment
When a program is invoked it is given an array of strings called the ***environment***. This is a list of `name-value` pairs, of the form of **name=value**.

The following figure shows a typical organization of the user stack when a new program starts.
![](https://github.com/Gyumeijie/assets/blob/master/linux-shell-book/organization-of-user-stack.png)

Unix provides several functions for manipulating the environment array:

The **getenv** function searches the environment array for a string “name=value”. If found, it returns a pointer to value, otherwise it returns NULL.
```c
#include <stdlib.h>

char *getenv(const char *name);
```
If the environment array contains a string of the form “name=oldvalue”, then **unsetenv** deletes it and setenv replaces oldvalue with newvalue, but only if overwrite is nonzero. If name does not exist, then **setenv** adds “name=newvalue”
to the array.
```c
#include <stdlib.h>

int setenv(const char *name, const char *newvalue, int overwrite);

void unsetenv(const char *name);
```


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
