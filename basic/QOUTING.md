# Preface
**Quoting** is used to ***remove the special meaning*** of certain characters or words to the shell. 

There are three quoting mechanisms: the ***escape character***, ***single quotes***, and ***double quotes***.

## Escape character
> A non-quoted backslash(\\) is the ***escape character***.

It preserves the literal value of the **next character** that follows.

## Single quotes

Enclosing characters in single qoutes('') preserves the literal value of **each character within the qoutes**.


## Double quotes

Enclosing characters in double qoutes("") preserves the literal value of **all characters within the qoutes**, with the exception of **$**, **`**, **\\**, and, when history expansion is enabled, **!**.
