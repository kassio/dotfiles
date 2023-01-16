local utils = require('my.utils')

local default_opts = {
  fnamemodifier = ':.',
}

return {
  on_click = function(msg, opts)
    utils.to_clipboard(msg, opts.mouse_btn ~= 'l')
  end,
  render = function(opts)
    opts = vim.tbl_deep_extend('keep', opts or {}, default_opts)

    local fullname = vim.api.nvim_buf_get_name(opts.bufnr)

    if #fullname == 0 then
      return '[No name]'
    else
      local name = vim.fn.fnamemodify(fullname, opts.fnamemodifier)

      if #name > 70 then
        local parts = vim.split(name, '/')
        return '.../' .. table.concat(parts, '/', 2, #parts)
      end

      return name
    end
  end,
}
