return {
  -- split/join code blocks
  {
    'AndrewRadev/splitjoin.vim',
  },

  -- text aligning
  {
    'junegunn/vim-easy-align',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { desc = 'aligner: start aligning' })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { desc = 'aligner: start aligning' })
    end,
  },

}
