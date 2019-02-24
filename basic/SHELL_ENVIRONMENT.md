# Preface
Commands can be read and executed in either ***current shell*** or ***subshell*** environment and thus affect the corresponding shell’s environment. There are ways in Bash to make commands to be executed in current shell and otherwise, we will disscuss them below.

## Executions in current shell environment

- . filename [arguments]

- source filename [arguments]

- { list; }
> **{** and **}** are ***reserved words*** and must occur where a reserved word is permitted to be recognized.
> Since they do not cause a word break, ther must be separated from ***list*** by whitespace or another shell metacharacter( **|** **&** **;** **(** **)** **<** **>** **space tab**, they are metacharacter, which **separates words** when unquoted.) :star: :star:

The ***list*** must be terminated with a **newline** or **semicolon**.

## Executions in subshell environment
> Changes made to the subshell environment cannot affect the current shell's execution environment.

- (list)

- /path/to/shell script
> A file containing shell commands, and a subshell is spawned to execute it.

- command_1 | command_2 | .... | command_n
> Commands that are invoked as a part of a pipeline are alse executed in a subshell environment.

