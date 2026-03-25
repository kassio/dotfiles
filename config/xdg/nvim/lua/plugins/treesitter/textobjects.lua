return {
  setup = function()
    local textobjects = {
      swap = require('nvim-treesitter-textobjects.swap'),
      select = require('nvim-treesitter-textobjects.select'),
      move = require('nvim-treesitter-textobjects.move'),
    }

    vim.keymap.set('n', '<leader>a', function()
      textobjects.swap.swap_next '@parameter.inner'
    end)
    vim.keymap.set('n', '<leader>A', function()
      textobjects.swap.swap_next '@parameter.outer'
    end)

    vim.keymap.set({ 'x', 'o' }, 'af', function()
      textobjects.select.select_textobject('@function.outer', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'if', function()
      textobjects.select.select_textobject('@function.inner', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'ac', function()
      textobjects.select.select_textobject('@class.outer', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'ic', function()
      textobjects.select.select_textobject('@class.inner', 'textobjects')
    end)
    -- You can also use captures from other query groups like `locals.scm`
    vim.keymap.set({ 'x', 'o' }, 'as', function()
      textobjects.select.select_textobject('@local.scope', 'locals')
    end)

    vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
      textobjects.move.goto_previous_start({
        '@function.outer',
        '@class.outer',
        '@conditional.outer',
        '@loop.outer',
      }, 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
      textobjects.move.goto_previous_start('@function.outer', 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
      textobjects.move.goto_previous_start('@class.outer', 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
      textobjects.move.goto_next_start({
        '@function.outer',
        '@class.outer',
        '@conditional.outer',
        '@loop.outer',
      }, 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
      textobjects.move.goto_next_start('@function.outer', 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
      textobjects.move.goto_next_start('@class.outer', 'textobjects')
    end)
  end,
}
