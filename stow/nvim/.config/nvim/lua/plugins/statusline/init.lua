local lualine = require('lualine')
local theme = vim.my.theme

local utils = require('plugins.statusline.utils')

local sections = {
  lualine_a = { utils.mode() },
  lualine_b = {
    {
      'filetype',
      colored = true,
      icon_only = true,
      padding = { left = 1, right = 0 },
    },
    utils.spacer,
    {
      'filename',
      file_status = true,
      path = 1,
      shorting_target = 30,
      symbols = { modified = ' ', readonly = ' ', unnamed = ' [No Name] ' },
      padding = 0,
    },
    utils.spacer,
  },
  lualine_c = {
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
  lualine_x = {},
  lualine_y = { 'diff', 'branch' },
  lualine_z = { '[[%3l:%-3c %3p%%]]' },
}

local filetree_sections = vim.tbl_extend('force', sections, {
  lualine_a = {},
  lualine_b = { utils.filetree_current_file },
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
})
local neoterm_sections = vim.tbl_extend('force', sections, {
  lualine_a = {},
  lualine_b = { utils.neoterm_id },
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
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
