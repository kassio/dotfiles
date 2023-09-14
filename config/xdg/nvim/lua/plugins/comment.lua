return {
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  {
    'folke/todo-comments.nvim',
    config = function()
      -- HACK: #104 Invalid in command-line window
      local hl = require('todo-comments.highlight')
      local highlight_win = hl.highlight_win
      hl.highlight_win = function(win, force)
        pcall(highlight_win, win, force)
      end

      local todo = require('todo-comments')

      todo.setup({
        keywords = {
          DEPRECATED = { icon = '', color = 'warning', alt = { 'WARN' } },
        },
      })

      vim.keymap.set('n', ']t', function()
        todo.jump_next()
      end, { desc = 'Next todo comment' })

      vim.keymap.set('n', '[t', function()
        todo.jump_prev()
      end, { desc = 'Previous todo comment' })
    end,
  },
}
