return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = { enabled = 'terminal' },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    local opencode = require('opencode')

    vim.api.nvim_create_user_command('OCode', opencode.toggle, { desc = 'opencode: toggle' })
    vim.api.nvim_create_user_command('OCodeThis', function()
      return opencode.ask('@this: ', { submit = true })
    end, { desc = 'opencode: ask abou this' })
    vim.api.nvim_create_user_command('OCodeSelect', opencode.select, { desc = 'opencode: select' })

    vim.keymap.set({ 'n', 'x' }, 'goo', opencode.toggle, { desc = 'opencode: toggle' })
    vim.keymap.set({ 'n', 'x' }, 'gos', opencode.select, { desc = 'opencode: select' })
    vim.keymap.set({ 'n', 'x' }, 'got', function()
      return opencode.ask('@this: ', { submit = true })
    end, { desc = 'opencode: toggle' })

    vim.keymap.set({ 'n', 'x' }, 'goa', function()
      return opencode.operator('@this ') .. '_'
    end, { desc = 'opencode: add range', expr = true })
  end,
}
