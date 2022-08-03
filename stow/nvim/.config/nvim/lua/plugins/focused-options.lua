local function set_relative_number(value)
  if vim.my.utils.plugin_filetype(vim.bo.filetype) then
    return
  end

  vim.opt_local.relativenumber = value
end

vim.my.utils.augroup('user:autocommands', {
  {
    events = {
      'WinLeave',
    },
    callback = function()
      set_relative_number(false)
    end,
  },
  {
    events = {
      'WinEnter',
    },
    callback = function()
      set_relative_number(true)
    end,
  },
})
