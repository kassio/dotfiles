local keymap = vim.keymap
------------------------------------------------------------
-- Operation pending maps need to be passed as string
-- expressions to vim, hence the double quote
--
-- select current line (inner)
keymap.set('x', 'il', ':<c-u>normal! g_v_<cr>')
keymap.set('o', 'il', '":normal vil<cr>"', { expr = true })

-- select current line (outer)
keymap.set('x', 'al', ':<c-u>normal! g_v0<cr>')
keymap.set('o', 'al', '":normal val<cr>"', { expr = true })

-- select all lines
keymap.set('x', 'aF', ':<c-u>keepjumps normal! GVgg0<cr>')
keymap.set('o', 'aF', '":normal vaF<cr>"', { expr = true })
------------------------------------------------------------

-- disable ex mode
keymap.set('n', [[Q]], [[<nop>]])

-- allow gf to open non-existing files
keymap.set('n', 'gf', ':e <cfile><cr>')

-- use gj/gk by default to better navigation on wrapped lines
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')

-- faster esc
keymap.set('i', '<esc>', '<c-c>')

-- undo breakpoints
keymap.set('i', ',', ',<c-g>u')
keymap.set('i', '.', '.<c-g>u')

-- keep the cursor centered while moving
keymap.set('n', 'n,', 'nzzzv')
keymap.set('n', 'N,', 'Nzzzv')
keymap.set('n', 'J,', 'mzJ`z')

keymap.set('n', ']c', ']czz')
keymap.set('n', '[c', '[czz')
keymap.set('n', ']d', ']dzz')
keymap.set('n', '[d', '[dzz')

-- escape from terminal mode with double <esc>
keymap.set('t', [[<esc><esc>]], [[<c-\><c-n>]])

-- move to the last tab
keymap.set('n', '9gt', '<cmd>tablast<cr>')

-- paste without replacing the " register
keymap.set('v', '<leader>p', '"_dP')

-- search current word
keymap.set('n', '!', '"vyiw/\\V<c-r>v<cr>N')
-- search current selection
keymap.set('x', '!', '"vy/\\V<c-r>v<cr>N')

-- search current word case insensitive
keymap.set('n', '<leader>!', '"vyiw/\\V\\c<c-r>v<cr>N')
-- search current selection case insensitive
keymap.set('x', '<leader>!', '"vy/\\V\\c<c-r>v<cr>N')

-- search current word exclusive
keymap.set('n', 'g!', '"vyiw/\\V\\<<c-r>v\\><cr>N')
-- search current selection exclusive
keymap.set('x', 'g!', '"vy/\\V\\<<c-r>v\\><cr>N')

-- search current word case insensitive exclusive
keymap.set('n', '<leader>g!', '"vyiw/\\V\\c\\<<c-r>v\\><cr>N')
-- search current selection case insensitive exclusive
keymap.set('x', '<leader>g!', '"vy/\\V\\c\\<<c-r>v\\><cr>N')

-- delete current buffer
keymap.set('n', '<leader>bd', '<cmd>bw!<cr>')
-- delete all buffers
keymap.set('n', '<leader>da', '<cmd>bufdo bw!<cr>')

-- indent current buffer
keymap.set('n', '<leader>ff', function()
  require('utils.buffers').preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
end)

-- delete all buffers except current
keymap.set('n', '<leader>bo', function() -- delete all buffers but current
  local current = vim.api.nvim_win_get_buf(0)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end)

-- delete all hidden buffers
keymap.set('n', '<leader>dh', function() -- delete all hidden buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.tbl_isempty(vim.fn.win_findbuf(buf)) and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end)

-- close floating windows
keymap.set('n', '<leader>wa', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, config = pcall(vim.api.nvim_win_get_config, win)

    if ok and config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
    end
  end
end)

-- open the url under the cursor
keymap.set('n', 'gx', function()
  vim.fn.jobstart('open ' .. vim.fn.expand('<cfile>'))
end, { silent = true })

-- open the url under the cursor
keymap.set('x', 'gx', function()
  vim.cmd('normal! "vy')
  local uri = vim.fn.getreg('v')
  vim.fn.jobstart('open ' .. string.gsub(uri, '%s', ''))
end, { silent = true })

-- paste " reg in snake_case
keymap.set('n', 'g<c-p>_', function()
  local value = vim.fn.getreg('"')

  vim.api.nvim_paste(string.snakecase(value), '', -1)
end, { silent = true })

-- paste " reg in CamelCase
keymap.set('n', 'g<c-p>c', function()
  local value = vim.fn.getreg('"')

  vim.api.nvim_paste(string.camelcase(value), '', -1)
end, { silent = true })
