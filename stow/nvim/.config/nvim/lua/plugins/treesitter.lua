local theme = vim.my.theme
local treesitter = require('nvim-treesitter.configs')
local spellsitter = require('spellsitter')
local gps = require('nvim-gps')

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

local go_package = function()
  if vim.bo.filetype ~= 'go' then
    return ''
  end

  for ln = 0, 300, 1 do
    local ok, line = pcall(vim.api.nvim_buf_get_lines, 0, ln, ln + 1, true)
    if not ok then
      return ''
    end

    line = line[1]
    if string.match(line, '^%s*package%.*') ~= nil then
      return string.format(' %s' .. theme.icons.separator, vim.split(line, ' ')[2])
    end

    ln = ln + 1
  end

  return ''
end

vim.my.treesitter = {
  gps = {
    location = function()
      if gps.is_available() then
        return go_package() .. gps.get_location()
      else
        return ''
      end
    end,
  },
}

vim.api.nvim_create_user_command('TSGPSLocation', function()
  print(vim.my.treesitter.gps.location())
end, {})
vim.api.nvim_create_user_command('TSGPSLocationCopy', function(cmd)
  vim.my.utils.to_clipboard(vim.my.treesitter.gps.location(), cmd.bang)
end, {})
