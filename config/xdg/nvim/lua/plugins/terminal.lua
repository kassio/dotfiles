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
      local utils = require('utils')
      local log = utils.logger('neoterm')
      local neoterm_server_addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'neoterm_server.pipe')

      local keymap = function(key, command, desc)
        vim.keymap.set('n', key, command, { desc = 'neoterm: ' .. desc })
      end

      keymap('<leader>te', '<cmd>T exit<cr>', 'exit')
      keymap('<leader>tg', '<cmd>Tredo<cr>', 'redo')
      keymap('<leader>th', '<cmd>botright Ttoggle<cr>', 'horizontal toggle')
      keymap('<leader>tk', '<cmd>Tkill<cr>', 'kill (send ctrl_c)')
      keymap('<leader>tl', '<cmd>T clear<cr>', 'clear')
      keymap('<leader>tm', vim.fn['neoterm#map_do'], 'run command saved with Tmap')
      keymap('<leader>tt', '<cmd>Ttoggle<cr>', 'toggle')
      keymap('<leader>tv', '<cmd>botright vertical Ttoggle<cr>', 'vertical toggle')

      vim.api.nvim_create_user_command('T', function(opts)
        if vim.g.neoterm_server == true or vim.fn.filereadable(neoterm_server_addr) == 0 then
          vim.fn['neoterm#do']({ cmd = opts.args })
        else
          local cmd = {
            'nvim',
            '--server',
            neoterm_server_addr,
            '--remote-send',
            string.format([[<C-\><C-N>:T %s<CR>]], opts.args),
          }

          vim.system(cmd, { text = true }):wait()
        end
      end, { nargs = '+' })

      vim.api.nvim_create_user_command('NeotermServerStart', function()
        vim.fn.serverstart(neoterm_server_addr)
        vim.cmd.Tnew()
        vim.cmd.bwipeout()
        vim.g.neoterm_server = true
      end, {})

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
