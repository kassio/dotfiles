return {
  setup = function(manager)
    vim.keymap.set(
      't',
      [[<esc><esc>]],
      [[<c-\><c-n>]],
      { desc = 'escape from terminal mode with double <esc>' }
    )

    -- Set terminal as only buffer
    vim.keymap.set('n', '<leader>to', function()
      manager.nvim_cmd('only')
    end)

    vim.keymap.set('n', '<leader>tg', function()
      manager.nvim_cmd('normal gg')
    end)

    vim.keymap.set('n', '<leader>tG', function()
      manager.nvim_cmd('normal G')
    end)

    vim.keymap.set('n', '<leader>tm', '<cmd>Tmapexec<cr>')

    vim.keymap.set('n', '<leader>tt', manager.toggle)

    vim.keymap.set('n', '<leader>th', function()
      manager.toggle({ position = 'horizontal' })
    end)

    vim.keymap.set('n', '<leader>tv', function()
      manager.toggle({ position = 'vertical' })
    end)

    -- send ctrl+c (kill)
    vim.keymap.set('n', '<leader>tk', function()
      manager.send(vim.keycode('<c-c>'), { breakline = false })
    end)

    vim.keymap.set('n', '<leader>te', function()
      manager.send('exit', { include_prefix = false, include_suffix = false })
    end)

    vim.keymap.set('n', '<leader>tl', function()
      manager.send('clear', { include_prefix = false, include_suffix = false })
    end)

    vim.keymap.set('n', '<leader>tL', function()
      manager.send('clear-screen', { include_prefix = false, include_suffix = false })
      manager.send('clear', { include_prefix = false, include_suffix = false })

      -- redraw current window to avoid any weird state
      vim.cmd.mode()

      pcall(function()
        local original = vim.bo[manager.active.bufnr].scrollback
        vim.bo[manager.active.bufnr].scrollback = 1
        vim.bo[manager.active.bufnr].scrollback = original
      end)
    end)
  end,
}
