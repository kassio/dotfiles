local theme = require('plugins.highlight.theme')
local treesitter = require('nvim-treesitter.configs')
local spellsitter = require('spellsitter')
local utils = require('my.utils')
local gps = require('nvim-gps')
local hl = utils.highlights
local colors = theme.colors

-- Treesitter globals
hl.extend('TSTypeBuiltin', 'Type')
hl.extend('TSVariable', 'Normal')
hl.extend('TSParameter', 'Normal')
hl.extend('TSFuncBuiltin', 'Identifier')
hl.extend('TSStringEscape', 'String', { bold = true })
hl.extend('TSStringSpecial', 'String', { bold = true })

-- refactoring
hl.def('TSDefinitionUsage', { background = colors.light_warn, foreground = colors.shadow })
hl.def('TSDefinition', { background = colors.light_warn })

-- Ruby with Treesitter
hl.extend('rubyTSType', 'Type')
hl.extend('rubyTSLabel', 'Identifier')
hl.extend('rubyTSSymbol', 'Identifier')
hl.extend('rubyTSVariableBuiltin', 'Constant')

-- Go with Treesitter
hl.extend('goTSnamespace', 'Normal', { bold = true })
hl.extend('goTSvariable', 'Normal')
hl.extend('goTSfunction_name', 'Function')
hl.extend('goTSproperty', 'Function')

-- vim-matchup plugin, uses treesitter
-- Do not show the not visible matching context on statusline
vim.g.matchup_matchparen_offscreen = {}

treesitter.setup({
  ensure_installed = 'all',
  ignore_install = {
    'kotlin',
    'latex',
    'norg',
    'r',
    'vala',
    'ocaml',
    'php',
    'phpdoc',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { 'ruby' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = 'gnn',
      node_decremental = 'gnm',
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    pairs = {
      enable = true,
    },
    select = {
      enable = true,
      keymaps = {
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['am'] = '@function.outer',
        ['im'] = '@function.inner',
        ['aM'] = '@class.outer',
        ['iM'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    navigation = { enable = true },
    smart_rename = { enable = true },
  },
  matchup = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
})

spellsitter.setup({
  hl = 'SpellBad',
  captures = { 'comment', 'string' },
})

gps.setup({
  separator = theme.icons.separator,
  icons = {
    ['class-name'] = ' ',
    ['container-name'] = ' ',
    ['function-name'] = ' ',
    ['method-name'] = ' ',
    ['tag-name'] = ' ',
  },
  languages = {
    ruby = {
      icons = {
        ['class-name'] = '::',
        ['container-name'] = '::',
        ['function-name'] = '.',
        ['method-name'] = '#',
        ['tag-name'] = '',
      },
      separator = '',
    },
  },
})

vim.api.nvim_create_user_command('TSGPSLocation', function()
  print(utils.treesitter.location())
end, {})

vim.api.nvim_create_user_command('TSGPSLocationCopy', function(cmd)
  utils.to_clipboard(utils.treesitter.location(), cmd.bang)
end, {})
