------------------------------------------------------------
-- Operation pending maps need to be passed as string
-- expressions to vim, hence the double quote
--
-- select current line (inner)
vim.keymap.set('x', 'il', ':<c-u>normal! g_v_<cr>')
vim.keymap.set('o', 'il', '":normal vil<cr>"', { expr = true })

-- select current line (outer)
vim.keymap.set('x', 'al', ':<c-u>normal! g_v0<cr>')
vim.keymap.set('o', 'al', '":normal val<cr>"', { expr = true })

-- select all lines
vim.keymap.set('x', 'aF', ':<c-u>keepjumps normal! GVgg0<cr>')
vim.keymap.set('o', 'aF', '":normal vaF<cr>"', { expr = true })
------------------------------------------------------------

-- disable ex mode
vim.keymap.set('n', [[Q]], [[<nop>]])

-- allow gf to open non-existing files
vim.keymap.set('n', 'gf', ':e <cfile><cr>')

-- use gj/gk by default to better navigation on wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- faster esc
vim.keymap.set('i', '<esc>', '<c-c>')

-- undo breakpoints
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')

-- keep the cursor centered while moving
vim.keymap.set('n', 'n,', 'nzzzv')
vim.keymap.set('n', 'N,', 'Nzzzv')
vim.keymap.set('n', 'J,', 'mzJ`z')

vim.keymap.set('n', ']c', ']czz')
vim.keymap.set('n', '[c', '[czz')
vim.keymap.set('n', ']d', ']dzz')
vim.keymap.set('n', '[d', '[dzz')

-- escape from terminal mode with double <esc>
vim.keymap.set('t', [[<esc><esc>]], [[<c-\><c-n>]])

-- move to the last tab
vim.keymap.set('n', '9gt', '<cmd>tablast<cr>')

-- paste without replacing the " register
vim.keymap.set('v', '<leader>p', '"_dP')

-- search current word
vim.keymap.set('n', '!', '"vyiw/\\V<c-r>v<cr>N')
-- search current selection
vim.keymap.set('x', '!', '"vy/\\V<c-r>v<cr>N')

-- search current word case insensitive
vim.keymap.set('n', '<leader>!', '"vyiw/\\V\\c<c-r>v<cr>N')
-- search current selection case insensitive
vim.keymap.set('x', '<leader>!', '"vy/\\V\\c<c-r>v<cr>N')

-- search current word exclusive
vim.keymap.set('n', 'g!', '"vyiw/\\V\\<<c-r>v\\><cr>N')
-- search current selection exclusive
vim.keymap.set('x', 'g!', '"vy/\\V\\<<c-r>v\\><cr>N')

-- search current word case insensitive exclusive
vim.keymap.set('n', '<leader>g!', '"vyiw/\\V\\c\\<<c-r>v\\><cr>N')
-- search current selection case insensitive exclusive
vim.keymap.set('x', '<leader>g!', '"vy/\\V\\c\\<<c-r>v\\><cr>N')

-- delete current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bw!<cr>')
-- delete all buffers
vim.keymap.set('n', '<leader>da', '<cmd>bufdo bw!<cr>')

-- indent current buffer
vim.keymap.set('n', '<leader>ff', function()
  require('my.utils.buffers').preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
end)

-- delete all buffers except current
vim.keymap.set('n', '<leader>bo', function() -- delete all buffers but current
  local current = vim.api.nvim_win_get_buf(0)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end)

-- delete all hidden buffers
vim.keymap.set('n', '<leader>dh', function() -- delete all hidden buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.tbl_isempty(vim.fn.win_findbuf(buf)) and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end)

-- close floating windows
vim.keymap.set('n', '<leader>wa', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, config = pcall(vim.api.nvim_win_get_config, win)

    if ok and config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
    end
  end
end)

-- open the url under the cursorra
vim.keymap.set('n', 'gx', function()
  vim.fn.jobstart('open ' .. vim.fn.expand('<cfile>'))
end, { silent = true })
