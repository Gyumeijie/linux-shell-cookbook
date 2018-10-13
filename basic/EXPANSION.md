# EXPANSION

**Expansion** is performed on the command line after it has been split into words. There are seven kinds of
expansion performed: `brace expansion`, `tilde expansion`, `parameter and variable expansion`, `command substitution`, `arithmetic expansion`, `word splitting`, and `pathname expansion`.

The **order** of expansions is: brace expansion; tilde expansion, parameter and variable expansion, arithmetic
expansion, and command substitution (done in a left-to-right fashion); word splitting; and pathname expansion

Only `brace expansion`, `word splitting`, and `pathname expansion` can ***change the number of words of the
expansion***; other expansions expand a single word to a single word. The only exceptions to this are the
expansions of "$@" and "${name[@]}".

### Brace Expansion

***Brace expansion*** is a mechanism by which arbitrary strings may be generated. Patterns to be brace expanded take the form of an optional ***preamble***, followed by either a series of `comma-seperated strings` or a `sequence expression` between a pair of braces, followed by an optional ***postscript***.
> Note: there should be no spaces around comma.

- A comma-seperated strings
Brace expansions may be ***nested***. The results of each expanded string are not sorted; left to right order is preserved. For example, a{d,c,{b,e}}f expands into 'adf acf abf aef'.

- A sequece expression
A sequece expression takes the form of **{x..y[..incr]}**, where ***x*** and ***y*** are either integers or single characters, and ***incr***, an optional increment, is an integer.

Brace expansion is performed before any other expansions, and any characters special to other expansions are preserved in the result.

### Tilde Expansion

If a word begins with an unquoted tilde character('~'), all of the characters preceding the first unquoted slash(or all characters, if there is no unquoted slash) are considered a ***tilde-prefix***.

1. If the tilde-prefix is a '~', the tilde is replaced with the value of the shell parameter **HOME**.
2. If the tilde-prefix is a '~+', the value of the shell variable **PWD** replaces the tilde-prefix.
3. If the tilde-prefix is a '~-', the value of the shell variable OLDPWD, if it is set, is substituted.
4. If the characters following the tilde in the tilde-prefix consist of a number ***N***, optionally prefixed by a '+' or a '−', the tilde-prefix is replaced with the corresponding element from the ***directory stack***, suppose we have now the following list of currently remembered directories:

```/tmp/dir1 /tmp/dir2 /tmp/dir3/ /tmp/dir4```

now the `~0` refers to the 0th entry counting from the left of the above list, that is `/tmp/dir1`; The `~0` is the same as `~+0`, a '+' or '-' prefixed represents the direction: '+' and '-' means ***ltr***(left to right) and ***rtl***(right to left) respectively. So the `~-0` refers to `/tmp/dir4`, the 0th entry counting from right to left.


### Parameter Expansion

The '$' character introduces parameter expansion, command substitution or arithmetic expansion. The parameter name or symbol to be expanded may be enclosed in braces, which are optional but serve to protect the variable to be expaned from characters immediately following it which could be interpreted as part of the name.


### Command Substitution

***Command substitution*** allows the output of a command to replace the command name. The are two forms:

     $(command)
   
or 

    `command`

**Bash** performs the expansion by executing ***command*** and replacing the command substitutio with teh stadard ouput of the command, with any trailing newlines deleted.
> Embeded newlines are not deleted until now, but the may be removed during world splitting.

Especially, the command subsittution `$(cat file)` can be replaced by the equivalent but faster `$(<file)`.


### Arithmetic Expansion

Arithmetic expansion allows the evaluation of an arithmetic expression and the substitution of the result. The format for arithmetic expansion is:

     $((expression))


### Word Splitting

The shell scans the results of parameter expansion, command substitution, and arithmetic expansion that did not occur within
double quotes for ***word splitting***.

The shell treats each character of **IFS** as a delimiter, and splits the results of the other expansions into words
using these characters as field terminators.

### Pathname Expansion

After word splitting, unless the -f option has been set to disable pathname expansion, bash scans each word for the characters `*`, `?` and `[`. If one of these characters appears, then the word is regard as a ***pattern***, and replaced with an alphabetically sorted list ***filenames*** matching the pattern.

#### Glob Options
##### nullglob
If no matching filenames are found, and the shell option `nullglob` is not enabled, the word is left unchanged. If the `nullglob` option is set and no matchers are found, the word is removed.

##### failglob
If the `failglob` shell option is set, and no matches are found, an error message is printed and the command is not executed.

##### nocaseglob
If the shell option `nocaseglob` is enabled, the match is performed without regard to the case of the alphabetic characters.

##### extglob
See below.


#### Pattern Matching
Any character that appears in a pattern, other than the special **pattern characters** described below, matches
itself. The speical pattern characters have the following meanings:
- \*     
Matches any ***string***, including the null string.
- ?       
Matches any single ***character***.
- [...]      
Matches any one the enclosed ***characters***. A pair of characters separated by a hyphen(-) denotes a ***range expression***; any character that falls between those two characters, inclusive, is matched. If the first character following the `[` is a `!` or a `^` then any character not encolsed is matched.

Within `[` and `]`, ***character classes*** can be specified using the syntax `[:class:]`, where class is one the following classes defined in the **POSIX standard**:

**alnum   alpha   ascii   blank   cntrl   digit   graph   lower   print   punct   space   upper   word   xdigit**

> Note that although `?` and `*` are quantifiers in regular expression, this isn't the case in shell globbing. 

If the ***extglob*** shell option is enabled using the ***shopt*** builtin, several extended pattern matching operators are recognized. In the following description, a `pattern-list` is a list of one or more patterns separated by a **|**. Composite patterns may be formed using one or more of the following sub-patterns:

- ?(pattern-list)    Matches zero or one occurrence of the given patterns.
- *(pattern-list)    Matches zero or more occurrences of the given patterns.
- +(pattern-list)    Matches one or more occurrences of the given patterns.
- @(pattern-list)    Matches one of the given patterns.
- !(pattern-list)    Matches anything except one of the given patterns.
