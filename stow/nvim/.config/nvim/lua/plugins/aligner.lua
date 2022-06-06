local keymap = vim.keymap.set

-- Start interactive EasyAlign in visual mode (e.g. vipga)
keymap('x', 'ga', '<Plug>(EasyAlign)')

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keymap('n', 'ga', '<Plug>(EasyAlign)')
