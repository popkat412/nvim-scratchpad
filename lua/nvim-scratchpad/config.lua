local M = {}

--- Default options for nvim-scratchpads plugin
M.options = {
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

--- Sets options, using defaults if necessary
--- @param opts table
M.set_options = function (opts)
    opts = opts or {}
    for opt, _ in pairs(M.options) do
        if opts[opt] ~= nil then
            M.options[opt] = opts[opt]
        end
    end
end

return M

