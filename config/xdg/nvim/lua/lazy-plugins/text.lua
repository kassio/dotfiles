return {
  -- text aligning
  {
    'junegunn/vim-easy-align',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')

      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
    end,
  },

  -- list continuation
  {
    'gaoDean/autolist.nvim',
    ft = {
      'markdown',
      'text',
      'tex',
      'plaintex',
    },
    config = function()
      local autolist = require('autolist')
      autolist.setup()
      autolist.create_mapping_hook('i', '<CR>', autolist.new)
      autolist.create_mapping_hook('i', '<Tab>', autolist.indent)
      autolist.create_mapping_hook('i', '<S-Tab>', autolist.indent, '<C-D>')
      autolist.create_mapping_hook('n', 'o', autolist.new)
      autolist.create_mapping_hook('n', 'O', autolist.new_before)
      autolist.create_mapping_hook('n', '>>', autolist.indent)
      autolist.create_mapping_hook('n', '<<', autolist.indent)
      autolist.create_mapping_hook('n', '<C-r>', autolist.force_recalculate)
      autolist.create_mapping_hook('n', '<leader>x', autolist.invert_entry, '')
      vim.api.nvim_create_autocmd('TextChanged', {
        pattern = '*',
        callback = function()
          vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
        end,
      })
    end,
  },
}
