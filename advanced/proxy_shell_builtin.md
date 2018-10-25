# Interception or proxy shell builtin
```bash
$ type cd dirs popd pushd
cd is a shell builtin
dirs is a shell builtin
popd is a shell builtin
pushd is a shell builtin
```

The way to intercept shell builtin is **alias**.
```bash
function cd_interceptor() {
  // your code here
  cd $@
  // your code here
}
alias cd="cd_interceptor"

function dirs_interceptor() {
  // your code here
  dirs $@
  // your code here
}
alias dirs="dirs_interceptor"

function pushd_interceptor() {
  // your code here
  pushd $@
  // your code here
}
alias pushd="pushd_interceptor"

function popd_interceptor() {
  // your code here
  # Just pass in the first argument, in 
  # order to avoid `too many arguments` Error
  popd $1
  // your code here
}
alias popd="popd_interceptor"
```
Then add them to the `~/.bashrc` and update it.

Given our `cd_interceptor` is like this:

```bash
function cd_interceptor() {
  echo "before call cd"
  cd $@
  echo "after call cd"
}
```
Now, running `cd` command, we will get this:
```bash
$ cd /home/nick/linux-shell-cookbook
before call cd
after call cd
```
