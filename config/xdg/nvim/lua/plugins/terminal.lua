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
      local neoterm_server_addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'neoterm_server.pipe')

      local keymap = function(desc, key, command)
        vim.keymap.set('n', key, command, { desc = 'neoterm: ' .. desc })
      end

      local neoterm_fn = function(fn, opts)
        if vim.g.neoterm_server == true or vim.fn.filereadable(neoterm_server_addr) == 0 then
          vim.fn['neoterm#' .. fn](opts)
        else
          local args = ''
          if opts ~= nil then
            args = vim.json.encode(opts)
          end

          vim.system({
            'nvim',
            '--server',
            neoterm_server_addr,
            '--remote-send',
            string.format([[<C-\><C-N>:call neoterm#%s(%s)<CR>]], fn, args),
          })
        end
      end

      local neoterm_cmd = function(opts)
        neoterm_fn('do', {
          cmd = opts.args,
          target = opts.count or 0,
          mod = opts.mods or '',
        })
      end

      vim.api.nvim_create_user_command('T', function(opts)
        neoterm_cmd(opts)
      end, { nargs = '+' })

      vim.api.nvim_create_user_command('Tcd', function(opts)
        local pwd = vim.fn.getcwd()
        if #opts.args > 0 then
          pwd = opts.args
        end

        neoterm_cmd({ args = 'cd ' .. pwd })
      end, { nargs = '?' })

      vim.api.nvim_create_user_command('NeotermServerStart', function()
        vim.fn.serverstart(neoterm_server_addr)
        vim.cmd.Tnew()
        vim.cmd.bwipeout()
        vim.g.neoterm_server = true
      end, {})

      keymap('horizontal toggle', '<leader>th', '<cmd>botright Ttoggle<cr>')
      keymap('toggle', '<leader>tt', '<cmd>Ttoggle<cr>')
      keymap('vertical toggle', '<leader>tv', '<cmd>botright vertical Ttoggle<cr>')

      keymap('exit', '<leader>te', function()
        neoterm_cmd({ args = 'exit' })
      end)
      keymap('redo', '<leader>tg', function()
        neoterm_fn('redo', { count = 0 })
      end)
      keymap('kill (send ctrl_c)', '<leader>tk', function()
        neoterm_fn('kill', { count = 0 })
      end)
      keymap('clear', '<leader>tl', function()
        neoterm_fn('clear', { force_clear = 0 })
      end)
      keymap('erase buffer', '<leader>tL', function()
        neoterm_fn('clear', { force_clear = 1 })
      end)
      keymap('run command saved with Tmap', '<leader>tm', function()
        neoterm_cmd({ args = vim.tbl_get(vim.g, 'neoterm', 'map_options', 'cmd') })
      end)

      g.neoterm_default_mod = 'botright'
      g.neoterm_automap_keys = ''
      g.neoterm_use_relative_path = 1
      g.neoterm_autoscroll = 1
      g.neoterm_callbacks = {
        before_exec = function()
          vim.cmd.wall()
        end,
        before_create_window = function(instance)
          if string.match(instance.mod, 'vert') == nil then
            local height = vim.fn.winheight(0)
            g.neoterm_size = math.floor(height / 3)
          else
            local width = vim.fn.winwidth(0)
            g.neoterm_size = math.floor(width / 2)
          end

          return instance
        end,
      }
    end,
  },
}
