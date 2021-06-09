# nvim-scratchpad

Basically a scratchpad where you can write random stuff.
(now i proceed to copy paste from the docs)

### Introduction

Why? Well, sometimes I just want to open nvim to quickly
test something out, which means I have to think of what to
name the file and also remember to delete it after I'm done,
which is very annoying. Hence, this plugin.

It automatically creates files with a specific extension
(for syntax highlighting, autocomplete, etc) in a directory
you specify, and it gets deleted after you close the buffer.

By default, files are created in a temp directory created with
`mktemp -p`, and filenames are 10 character long random strings
containing only alphanumeric characters.

### Usage

This plugin only has one command which takes in 1 argument,
the extension of the file. For example, this makes a new markdown
scratchpad.
```
:Scratchpad md
```
For convenience, there is a shorter alias :Scratch which
works exactly the same way.
```
:Scratch md
```

### Customization 

You can configure nvim-scratchpad by using
```lua
require("nvim-scratchpad").setup(options)
```
The default options are as follows 
```lua
{
    --- A string or function for the full path (without trailing slash) to directory where scratchpads are placed.
    --- Defaults to a random temp directory.
    --- The function should return a string, the full path.
    --- @type string | function -- btw the function is supposed to have signature fun(): string but lua-language-server doesn't seem to like that
    scratchpad_dir = function()
        return string.gsub(vim.fn.system("mktemp -d"), "\n", "")
    end,
    --- A function that returns a string, a (preferably unique) filename for the scratchpad, including the extension.
    --- If there is a duplicate filename, it will be overwritten
    --- @param ext string The file extension
    --- @return string
    filename_generator = function (ext)
        return require("nvim-scratchpad.helpers").random_string(10) .. "." .. ext
    end,
    --- This is called after the buffer is deleted
    --- and should be used to delete the file from the filesystem
    --- @param filepath string The full path to the file to cleanup
    --- @return nil
    cleanup_fn = function (filepath)
        vim.fn.system([[rm "]] .. filepath .. [["]])
    end
}
```

### Known bugs
    - Some default functions don't work on Windows because they make
      use of unix shell commands, e.g. `mktemp`.
      As a temporary workaround one can customize these functions
      to work on windows until I get around to fixing it.

### Changelog
v.0.1.0
    * Initial release
