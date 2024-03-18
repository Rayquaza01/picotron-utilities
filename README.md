# picotron-utilities

A collection of useful commandline utilities for picotron

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

To add these commands to picotron, add the lua files to `/appdata/system/util`
