return {
  -- text aligning
  {
    'junegunn/vim-easy-align',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set(
        'x',
        'ga',
        '<Plug>(EasyAlign)',
        { desc = 'aligner: start aligning | tabularize' }
      )
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set(
        'n',
        'ga',
        '<Plug>(EasyAlign)',
        { desc = 'aligner: start aligning | tabularize' }
      )
    end,
  },
}
