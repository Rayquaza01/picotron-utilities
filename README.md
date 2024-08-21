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
* As a yotta utility
* As a bundle command
* Manually

### Yotta Utility

To install Picotron Utilities as a yotta utility, run `yotta util install #picotron_utilities`. This requires [yotta](https://www.lexaloffle.com/bbs/?tid=140833).

### Bundle Command

To install Picotron Utilities as a bundle command, save the cartridge to your utility path (`/appdata/system/util`).

```
load #picotron_utilities
save /appdata/system/util/busybox
```

Once installed, you can run a bundled command by passing that command as an argument, like `busybox tree`.

### Manual Install

To add these commands to Picotron manually, add the lua files found in [src/exports/appdata/system/util](https://github.com/Rayquaza01/picotron-utilities/tree/main/src/exports/appdata/system/util) to `/appdata/system/util`

`rsync -av src/exports ~/.lexaloffle/Picotron/drive`

### Stow

Using stow, symlinks for the scripts will be created in the Picotron drive. To install the commands using stow, run `stow -d src/ --adopt -t ~/.lexaloffle/Picotron/drive/ -Sv exports`.

`install.sh` and `uninstall.sh` will do this automatically. 
