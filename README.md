# Integration of Nix with python (setuptools)

This works best if you also have [direnv](https://direnv.net/) and [lorri](https://github.com/target/lorri) installed, all you need to do is just cd to the directory and you'll have all tooling available necessary for application developement (specified in `shell.nix`) (if you don't use direnv then just type `nix-shell` to enter something similar to virtualenv).

In that mode the application is also installed  e.g. you will have `hello` command available that will call `main()` in `hello.py` if you make changes to the file nothing needs to be built, it immediately takes effect  as if the package was installed with `pip -e`.

If you use direnv + lorri you just need to enter directory (if not just type `nix-shell`) and suddenly you have everything you need and the application is installed (try executing "hello" which will execute the python code, if you modify hello.py it immediately takes effect as if you were using `pip -e`)

If you call `nix build` you'll get a result directory with `result/bin/hello` that just works as if it was a binary program (nix will make sure that all depended packages are available)

# Updating python packages

```shell-script
$ pip-compile -Uv  # generates requirements.txt from setup.cfg
$ pip2nix generate # generates nix/python-packages.nix from requirements.txt
```

# Updating nix packages

```shell-script
$ niv update # updates nix/sources.json
```
