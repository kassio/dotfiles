local lualine = require('lualine')
local theme = vim.my.theme

local utils = require('plugins.statusline.utils')

local sections = {
  lualine_a = { utils.mode() },
  lualine_b = { 'branch', 'diff' },
  lualine_c = { utils.go_package, vim.my.treesitter.gps.location },
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
  lualine_y = {},
  lualine_z = {},
}

local filetree_sections = vim.tbl_extend('force', sections, {
  lualine_b = { utils.filetree_current_file },
})
local neoterm_sections = vim.tbl_extend('force', sections, {
  lualine_b = { utils.neoterm_id },
})

lualine.setup({
  extensions = {
    { sections = filetree_sections, filetypes = { 'NvimTree' } },
    { sections = neoterm_sections, filetypes = { 'neoterm' } },
  },
  options = {
    theme = theme.statusline,
    icons_enabled = true,
    section_separators = '',
    component_separators = '',
    globalstatus = true,
  },
  sections = sections,
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 2,
        max_length = vim.o.columns,
        always_divide_middle = false,
      },
    },
  },
})
