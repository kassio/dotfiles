local lualine = require('lualine')
local theme = vim.my.theme

local utils = require('plugins.statusline.utils')

local sections = {
  lualine_a = { utils.mode() },
  lualine_b = { vim.my.treesitter.gps.location },
  lualine_c = {},
  lualine_x = {
    {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = {
        error = theme.signs.error,
        warn = theme.signs.warn,
        hint = theme.signs.hint,
        info = theme.signs.info,
      },
    },
  },
  lualine_y = { 'diff', 'branch' },
  lualine_z = { '[[%3l:%-3c %3p%%]]' },
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
    theme = theme.colorscheme,
    icons_enabled = true,
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    always_divide_middle = false,
  },
  sections = sections,
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 2,
        max_length = vim.o.columns,
      },
    },
  },
})
