local opts = require("nvim-scratchpad.config").options
local type_assert = require("nvim-scratchpad.helpers").type_assert

local M = {}

M.setup = function (custom_opts)
    require("nvim-scratchpad.config").set_options(custom_opts)
end

M.scratchpad = function (ext)
    local dir
    if type(opts.scratchpad_dir) == "function" then
        dir = opts.scratchpad_dir()
        type_assert(dir, "string", "scratchpad_dir() doesn't return a string")
    elseif type(opts.scratchpad_dir) == "string" then
        dir = opts.scratchpad_dir
    else
        error("scratchpad_dir is not a function or a string")
    end

    type_assert(opts.filename_generator, "function", "filename_generator is not a function")
    local filename = opts.filename_generator(ext)
    type_assert(filename, "string", "filename_generator did not return string")
    local filepath = dir .. "/" .. filename

    -- Make that file, clearing it if it already exists
    local file = io.open(filepath, "w")
    io.input(file)
    io.write("")
    io.close(file)

    -- Open it in vim
    vim.cmd("edit " .. filepath)

    -- Buffer close hook
    vim.api.nvim_exec([[
    augroup NvimScratchpadLeave
        autocmd! * <buffer>
        autocmd BufWinLeave <buffer> :lua require("nvim-scratchpad").cleanup(vim.fn.expand("<afile>"))
    augroup END
    ]], true);
end

--- @param filepath string The path to the file
M.cleanup = function (filepath)
    type_assert(opts.cleanup_fn, "function", "cleanup_fn is not a function")
    opts.cleanup_fn(filepath)
end

return M
