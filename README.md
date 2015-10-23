# Yet Another T

A Fortran implementation of console-base Tic-Tac-Toe against a computer player.

## Installation / Setup

The repository can be cloned locally by running:

```bash
git clone https://github.com/JamesChristie/yet_another_t.git
```

The only development dependency of this application is the GNU Fortran compiler front-end for GCC: `gfortran` of version 4.9 or higher. (It might work with 4.8, but I have not tested with it.)

All tasks in the `Makefile` assume the `clean` task as a dependency, so it should not be possible to accidentally pollute your local builds. All tasks will remove the contents of the `build/` directory and start a new build from scratch.

### Running the Test Suite

The `make` task for compiling, linking, and executing the test runner program can be invoked via:

```bash
make test
```

### Building the Application

The `make` task for compiling and linking the application binary can be invoke via the default make task:

```bash
make
```

The binary will be linked and placed into the build/ directory within the local clone of the repository.
