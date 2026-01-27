return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    {
      'folke/snacks.nvim',
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },
  keys = {
    {
      'goo',
      function()
        require('opencode').toggle()
      end,
      mode = { 'n', 'x' },
      desc = 'opencode: toggle',
    },
    {
      'gos',
      function()
        require('opencode').select()
      end,
      mode = { 'n', 'x' },
      desc = 'opencode: select',
    },
    {
      'got',
      function()
        return require('opencode').ask('@this: ', { submit = true })
      end,
      mode = { 'n', 'x' },
      desc = 'opencode: ask about this',
    },
    {
      'goa',
      function()
        return require('opencode').operator('@this ') .. '_'
      end,
      mode = { 'n', 'x' },
      desc = 'opencode: add range',
      expr = true,
    },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = 'wezterm',
        direction = 'right',
        percent = 40,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    local opencode = require('opencode')

    vim.api.nvim_create_user_command('OCode', opencode.toggle, { desc = 'opencode: toggle' })
    vim.api.nvim_create_user_command('OCodeAsk', opencode.ask, { desc = 'opencode: ask' })
    vim.api.nvim_create_user_command('OCodeSelect', opencode.select, { desc = 'opencode: select' })
    vim.api.nvim_create_user_command('OCodeThis', function()
      return opencode.ask('@this: ', { submit = true })
    end, { desc = 'opencode: ask about @this' })
  end,
}
