# picotron-utilities

A collection of useful commandline utilities for picotron

Includes

* `cat` - concatenates and prints files (including URLs!)
    * example: `cat file1.txt file2.txt`
* `touch` - creates new files, updates modification time (rewrites) files
    * example: `touch newfile.txt`
* `tree` - prints a tree view of a directory
    * example: `tree desktop`
* `download` - downloads a file
    * example: `download https://gutenberg.org/cache/epub/64317/pg64317.txt gatsby.txt`

## Usage

To add these commands to picotron, add the lua files to `/appdata/system/util`
