# Integration of Nix with python (setuptools)

This works best if you also have [direnv](https://direnv.net/) and [lorri](https://github.com/target/lorri) installed, all you need to do is just cd to the directory and you'll have all tooling available necessary for application developement (specified in `shell.nix`) (if you don't use direnv then just type `nix-shell` to enter something similar to virtualenv).

In that mode the application is also installed  e.g. you will have `hello` command available that will call `main()` in `hello.py` if you make changes to the file nothing needs to be built, it immediately takes effect  as if the package was installed with `pip -e`.

If you use direnv + lorri you just need to enter directory (if not just type `nix-shell`) and suddenly you have everything you need and the application is installed (try executing "hello" which will execute the python code, if you modify hello.py it immediately takes effect as if you were using `pip -e`)

If you call `nix build` you'll get a result directory with `result/bin/hello` that just works as if it was a binary program (nix will make sure that all depended packages are available)

# Using setup.cfg

The configuration can be specified in a declarative way using `setup.cfg` you can get list of available options [here](https://setuptools.readthedocs.io/en/latest/setuptools.html#configuring-setup-using-setup-cfg-files). In projects where you have a directory (with `__init__.py` file aka a package) you should replace `py_modules = hello` with `packages = find:` the `find:` takes care automatically including all directories that contain `__init__.py`, you can also specify them manually.

```ini
[options.entry_points]
console_scripts=
	hello = hello:main
```
Creates `hello` command that will invoke `main()` function in `hello` module.

`install_requires` are *immediate* dependencies used by your application, you should only specify what application is using `pip-compile` will figure out their dependencies.

Providing versions is optional, but a good practice you can get more information about it [here](https://setuptools.readthedocs.io/en/latest/setuptools.html#declaring-dependencies). You might not be familiar with `~=` for example: `psycopg2 ~= 2.8.5` this basically translates to `psycopg2 >= 2.8.5,< 2.9.0` basically it fixes package to specific version but allow updating the last number (in semantic versioning that's patch level so it would only allow bugfixes). NOTE: If you ever work with time and depend on `pytz`, you generally don't want to fix version on that package. `pytz` contains timze zones information which change all the time, so having the latest version of `pytz` ensures your calculations are correct.

# Updating python packages

```shell-script
$ pip-compile -Uv  # generates requirements.txt from setup.cfg
$ pip2nix generate # generates nix/python-packages.nix from requirements.txt
```

# Updating nix packages

```shell-script
$ niv update # updates nix/sources.json
```

# Using packages with C library dependencies

Since setuptools doesn't store any information about C library dependencies, if you use libraries that depend on them e.g. psycopg2, you need to provide them manually. You can see an example of [adding postgres 12 dependency to psycopg2](https://github.com/takeda/example_python_project/blob/master/nix/python-packages-overrides.nix).
The great thing about it is that you achive 100% reproducible build that encompasses not only the python package dependencies, but also ensures that exact same python binary is used with exactly the same C libraries.
