local lualine = require('lualine')
local theme = require('plugins.highlight.theme')
local myutils = require('my.utils')
local utils = require('plugins.statusline.utils')

local sections = {
  lualine_a = { utils.mode() },
  lualine_b = { 'branch' },
  lualine_c = {
    {
      myutils.treesitter.location,
      on_click = function()
        vim.cmd('TSGPSLocationCopy')
      end,
    },
  },
  lualine_x = {
    {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = {
        error = theme.icons.error,
        warn = theme.icons.warn,
        hint = theme.icons.hint,
        info = theme.icons.info,
      },
    },
  },
  lualine_y = { 'diff' },
  lualine_z = { '%3l:%-3c %3p%%' },
}

lualine.setup({
  extensions = {
    {
      sections = vim.tbl_extend('force', sections, { lualine_b = { utils.filetree_current_file } }),
      filetypes = { 'NvimTree' },
    },
    {
      sections = vim.tbl_extend('force', sections, { lualine_b = { utils.neoterm_id } }),
      filetypes = { 'neoterm' },
    },
  },
  options = {
    theme = 'auto',
    icons_enabled = true,
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    always_divide_middle = false,
  },
  sections = sections,
})
