local keymap = vim.keymap.set

------------------------------------------------------------
-- Operation pending maps need to be passed as string
-- expressions to vim, hence the double quote
--
-- select current line (inner)
keymap('x', 'il', ':<c-u>normal! g_v_<cr>')
keymap('o', 'il', '":normal vil<cr>"', { expr = true })

-- select current line (outer)
keymap('x', 'al', ':<c-u>normal! g_v0<cr>')
keymap('o', 'al', '":normal val<cr>"', { expr = true })

-- select all lines
keymap('x', 'aF', ':<c-u>keepjumps normal! GVgg0<cr>')
keymap('o', 'aF', '":normal vaF<cr>"', { expr = true })
------------------------------------------------------------

-- disable ex mode
keymap('n', [[Q]], [[<nop>]])

-- allow gf to open non-existing files
keymap('n', 'gf', ':e <cfile><cr>')

-- use gj/gk by default to better navigation on wrapped lines
keymap('n', 'j', 'gj')
keymap('n', 'k', 'gk')

-- faster esc
keymap('i', '<esc>', '<c-c>')

-- undo breakpoints
keymap('i', ',', ',<c-g>u')
keymap('i', '.', '.<c-g>u')
keymap('i', '!', '!<c-g>u')
keymap('i', '?', '?<c-g>u')
keymap('i', '(', '(<c-g>u')
keymap('i', ')', ')<c-g>u')
keymap('i', '}', '}<c-g>u')
keymap('i', '{', '{<c-g>u')
keymap('i', '[', '[<c-g>u')
keymap('i', ']', ']<c-g>u')
keymap('i', '_', '_<c-g>u')
keymap('i', '-', '-<c-g>u')
keymap('i', '#', '#<c-g>u')

-- keep the cursor centered while moving
keymap('n', 'n,', 'nzzzv')
keymap('n', 'N,', 'Nzzzv')
keymap('n', 'J,', 'mzJ`z')

keymap('n', ']c', ']czz')
keymap('n', '[c', '[czz')
keymap('n', ']d', ']dzz')
keymap('n', '[d', '[dzz')

-- escape from terminal mode with double <esc>
keymap('t', [[<esc><esc>]], [[<c-\><c-n>]])

-- move to the last tab
keymap('n', '9gt', '<cmd>tablast<cr>')

-- paste without replacing the " register
keymap('v', '<leader>p', '"_dP')

-- search current word
keymap('n', '!', '"vyiw/\\V<c-r>v<cr>N')
-- search current selection
keymap('x', '!', '"vy/\\V<c-r>v<cr>N')

-- search current word case insensitive
keymap('n', '<leader>!', '"vyiw/\\V\\c<c-r>v<cr>N')
-- search current selection case insensitive
keymap('x', '<leader>!', '"vy/\\V\\c<c-r>v<cr>N')

-- search current word exclusive
keymap('n', 'g!', '"vyiw/\\V\\<<c-r>v\\><cr>N')
-- search current selection exclusive
keymap('x', 'g!', '"vy/\\V\\<<c-r>v\\><cr>N')

-- search current word case insensitive exclusive
keymap('n', '<leader>g!', '"vyiw/\\V\\c\\<<c-r>v\\><cr>N')
-- search current selection case insensitive exclusive
keymap('x', '<leader>g!', '"vy/\\V\\c\\<<c-r>v\\><cr>N')

-- indent current buffer
keymap('n', '<leader>ff', vim.my.buffers.indent)

-- delete all buffers except current
keymap('n', '<leader>bo', vim.my.buffers.only)
-- delete all hidden buffers
keymap('n', '<leader>dh', vim.my.buffers.delete_hidden)
-- delete current buffer
keymap('n', '<leader>bd', '<cmd>bw!<cr>')
-- delete all buffers
keymap('n', '<leader>da', '<cmd>bufdo bw!<cr>')

-- close floating windows
keymap('n', '<leader>wa', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, config = pcall(vim.api.nvim_win_get_config, win)

    if ok and config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
    end
  end
end)