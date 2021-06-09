local M = {}

--- Generates a random string using alphanumeric characters
--- @param length string The length of the string to generate
--- @return string
M.random_string = function (length)
    if length <= 0 then return "" end

    local s = ""
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    math.randomseed(os.time())
    for i = 1, length do
        local rand = math.random(1, #charset)
        local new_char = charset:sub(rand, rand)
        s = s .. new_char
    end

    return s
end

--- Asserts the type of a variable
--- @param var any
--- @param target_type type| "nil"| "number"| "string"| "boolean"| "table"| "function"| "thread"| "userdata"
--- @param error_msg string
--- @return nil
M.type_assert = function (var, target_type, error_msg)
    if type(var) ~= target_type then
        error(error_msg)
    end
end

return M

