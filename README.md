# picotron-utilities

A collection of useful commandline utilities for Picotron

Includes

* `cat` - concatenates and prints files (including URLs!)
    * example: `cat file1.txt file2.txt`
* `touch` - creates new files, updates modification time (rewrites) files
    * example: `touch newfile.txt`
* `tree` - prints a tree view of a directory
    * example: `tree desktop`
* `wget` - downloads a file
    * example: `wget https://gutenberg.org/cache/epub/64317/pg64317.txt gatsby.txt`
* `grep` - search within a file or folder
    * pattern is a lua pattern. See [Programming in Lua 20.2 - Patterns](https://www.lua.org/pil/20.2.html)
    * examples:
        * `grep _init` (searches for `_init` recursively through pwd)
        * `grep test file1.txt` (searches for `test` in `file1.txt`)
        * `grep hello desktop` (searches for `hello` recursively through `desktop/`)
* `frange` - print a file range with line numbers
    * examples:
        * `frange file.txt` (prints `file.txt` with line numbers)
        * `frange file.txt 1 10` (prints first 10 lines)
        * `frange file.txt 20` (prints starting from line 20 to the end of the file)
        * `frange file.txt 20 10` (prints 10 lines starting from line 20)
        * `frange file.txt -10` (prints last 10 lines)
        * `frange file.txt -20 10` (prints 10 lines starting from 20 lines before end)
* `pwd` - print working directory (UNIX-style shortcut for print(pwd()))
    * example: `pwd`

## Usage

Picotron Utilities can be used in 3 ways:
* As a bundle command
* As a yotta utility
* Manually

### Bundle Command

To install Picotron Utilities as a bundle command, save the cartridge to your utility path (`/appdata/system/util`).

Example: `save /appdata/system/util/busybox` installs Picotron Utilities with the commandname `busybox`. (You can set this to anything you like).

Then, to run a command, pass the command as an argument to the bundle command, like `busybox tree` or `busybox grep function main.lua`

You **cannot** run this cart with Ctrl+R. (Since the commands require arguments, it wouldn't do anything anyway.)


### Yotta Utility

To install Picotron Utilities as a yotta utility, run `yotta install #picotron_utilities`. This requires [yotta](https://www.lexaloffle.com/bbs/?tid=140833).

### Manual Install

To add these commands to Picotron manually, add the lua files found in [src/exports/appdata/system/util](https://github.com/Rayquaza01/picotron-utilities/tree/main/src/exports/appdata/system/util) to `/appdata/system/util`
