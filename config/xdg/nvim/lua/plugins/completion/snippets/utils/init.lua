local camelcase = require('utils.string').camelcase

local M = {}

---Returns the current buffer file name
---@param opts table
---  - remove: regex to remove patters from the filename
---  - case: if "camelcase" is passed, the filename is converted to PascalCase
---@return string
function M.filename(opts)
  opts = opts or {}

  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.fnamemodify(filename, ':t:r')

  if opts.remove ~= nil then
    filename = string.gsub(filename, opts.remove, '')
  end

  if opts.case == 'camelcase' then
    filename = camelcase(filename)
  end

  return filename
end

function M.expand(fmt, default)
  local path = vim.fn.expand(fmt)

  if path == '.' then
    return default or path
  else
    return path
  end
end

setmetatable(M, {
  __index = function(utils, key)
    local ok, module = pcall(require, 'plugins.completion.snippets.utils.' .. key)

    if ok then
      utils[key] = module
      return module
    end

    return nil
  end,
})

return M
