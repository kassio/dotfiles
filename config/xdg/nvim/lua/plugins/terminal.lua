return {
  -- Fix terminal colors
  {
    'norcalli/nvim-terminal.lua',
    config = true,
  },

  {
    'kassio/neoterm',
    config = function()
      local g = vim.g
      local keymap = vim.keymap.set
      local utils = require('utils')

      local numbered_cmd = function(cmd)
        local number = vim.v.count
        if number == 0 then
          number = vim.b.neoterm_target or ''
        end

        vim.cmd(string.gsub(cmd, '{{target}}', number))
      end

      local count_nkeymap = function(key, command, desc)
        keymap('n', key, function()
          numbered_cmd(command)
        end, { desc = 'neoterm: ' .. desc })
      end

      keymap('n', '<leader>tg', ':Tredo<cr>', { desc = 'neoterm: redo' })

      count_nkeymap('<leader>tt', '{{target}}Ttoggle', 'toggle')
      count_nkeymap('<leader>vt', 'botright vertical {{target}} Ttoggle', 'vertical toggle')
      count_nkeymap('<leader>ht', 'botright {{target}} Ttoggle', 'horizontal toggle')
      count_nkeymap('<leader>te', '{{target}}T exit', 'exit')
      count_nkeymap('<leader>tl', '{{target}}Tclear', 'clear')
      count_nkeymap('<leader>tL', '{{target}}Tclear!', 'erase buffer')
      count_nkeymap('<leader>tk', '{{target}}Tkill', 'kill (send ctrl_c)')

      g.neoterm_default_mod = 'botright'
      g.neoterm_automap_keys = '<leader>tm'
      g.neoterm_use_relative_path = 1
      g.neoterm_autoscroll = 1
      g.neoterm_callbacks = {
        before_exec = function()
          pcall(vim.cmd, 'wall')
        end,
        before_create_window = function(instance)
          if string.match(instance.mod, 'vert') == nil then
            local height = vim.fn.winheight('.')
            g.neoterm_size = math.floor(height / 3)
          else
            local width = vim.fn.winwidth('.')
            g.neoterm_size = math.floor(width / 2)
          end

          return instance
        end,
      }

      utils.augroup('user:terminal', {
        {
          events = { 'TermOpen' },
          pattern = '*',
          command = 'setlocal ' .. table.concat({
            'nonumber',
            'scrolloff=0',
            'nospell',
            'norelativenumber',
            'nocursorline',
            'bufhidden=hide',
          }, ' '),
        },
      })
    end,
  },
}
