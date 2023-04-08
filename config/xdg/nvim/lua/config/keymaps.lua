local keymap = vim.keymap
------------------------------------------------------------
-- Operation pending maps need to be passed as string
-- expressions to vim, hence the double quote
keymap.set('x', 'il', ':<c-u>normal! g_v_<cr>', { desc = 'select current line (inner)' })
keymap.set('o', 'il', '":normal vil<cr>"', { expr = true, desc = 'select current line (inner)' })

keymap.set('x', 'al', ':<c-u>normal! g_v0<cr>', { desc = 'select current line (outer)' })
keymap.set('o', 'al', '":normal val<cr>"', { expr = true, desc = 'select current line (outer)' })

keymap.set('x', 'aF', ':<c-u>keepjumps normal! GVgg0<cr>', { desc = 'select all lines' })
keymap.set('o', 'aF', '":normal vaF<cr>"', { expr = true, desc = 'select all lines' })
------------------------------------------------------------

keymap.set('n', 'Q', '<nop>', { desc = 'disable ex mode' })

-- remap jumps
keymap.set('n', '<leader>jn', '<c-i>', { desc = 'jump: newer cursor position' })
keymap.set('n', '<leader>jp', '<c-o>', { desc = 'jump: older cursor position' })

keymap.set('n', 'j', 'gj', { silent = true })
keymap.set('n', 'k', 'gk', { silent = true })

keymap.set('i', '<esc>', '<c-c>', { desc = 'faster esc' })

keymap.set('i', ',', ',<c-g>u', { desc = 'undo breakpoints' })
keymap.set('i', '.', '.<c-g>u')

keymap.set('n', 'n', 'nzzzv', { desc = 'keep the cursor centered while moving' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'keep the cursor centered while moving' })
keymap.set('n', 'J', 'mzJ`z', { desc = 'keep the cursor centered while moving' })
keymap.set('n', '}', '}zzzv', { desc = 'keep the cursor centered while moving' })
keymap.set('n', '{', '{zzzv', { desc = 'keep the cursor centered while moving' })

keymap.set(
  't',
  [[<esc><esc>]],
  [[<c-\><c-n>]],
  { desc = 'escape from terminal mode with double <esc>' }
)

keymap.set('n', '9gt', '<cmd>tablast<cr>', { desc = 'move to the last tab' })

keymap.set('v', '<leader>p', '"_dP', { desc = 'paste without replacing the " register' })

keymap.set('n', '!', '"vyiw/<c-r>v<cr>N', { desc = 'search current word' })
keymap.set('x', '!', '"vy/<c-r>v<cr>N', { desc = 'search current selection' })

keymap.set(
  'n',
  '<leader>!',
  '"vyiw/\\c<c-r>v<cr>N',
  { desc = 'search current word case insensitive' }
)
keymap.set(
  'x',
  '<leader>!',
  '"vy/\\c<c-r>v<cr>N',
  { desc = 'search current selection case insensitive' }
)

keymap.set('n', 'g!', '"vyiw/\\<<c-r>v\\><cr>N', { desc = 'search current word exclusive' })
keymap.set('x', 'g!', '"vy/\\<<c-r>v\\><cr>N', { desc = 'search current selection exclusive' })

keymap.set(
  'n',
  '<leader>g!',
  '"vyiw/\\c\\<<c-r>v\\><cr>N',
  { desc = 'search current word case insensitive exclusive' }
)
keymap.set(
  'x',
  '<leader>g!',
  '"vy/\\c\\<<c-r>v\\><cr>N',
  { desc = 'search current selection case insensitive exclusive' }
)

keymap.set('n', '<leader>bd', '<cmd>bw!<cr>', { desc = 'delete current buffer' })
keymap.set('n', '<leader>da', '<cmd>bufdo bw!<cr>', { desc = 'delete all buffers' })

keymap.set('n', '<leader>f=', function()
  require('utils.buffers').preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
end, { desc = 'indent current buffert text' })

keymap.set('n', '<leader>bo', function() -- delete all buffers but current
  local current = vim.api.nvim_win_get_buf(0)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = 'delete all buffers except current' })

keymap.set('n', '<leader>dh', function() -- delete all hidden buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.tbl_isempty(vim.fn.win_findbuf(buf)) and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = 'delete all hidden buffers' })

keymap.set('n', '<leader>wa', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, config = pcall(vim.api.nvim_win_get_config, win)

    if ok and config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { desc = 'close floating windows' })

keymap.set('n', 'gx', function()
  vim.fn.jobstart('open ' .. vim.fn.expand('<cfile>'))
end, { silent = true, desc = 'open the URL under the cursor' })

keymap.set('x', 'gx', function()
  vim.cmd('normal! "vy')
  local uri = vim.fn.getreg('v')
  vim.fn.jobstart('open ' .. string.gsub(uri, '%s', ''))
end, { silent = true, desc = 'open the URL under the cursor' })

keymap.set('n', 'g<c-p>_', function()
  local value = vim.fn.getreg('"')

  vim.api.nvim_paste(string.snakecase(value), '', -1)
end, { silent = true, desc = 'paste in snake_case' })

keymap.set('n', 'g<c-p>c', function()
  local value = vim.fn.getreg('"')

  vim.api.nvim_paste(string.camelcase(value), '', -1)
end, { silent = true, desc = 'paste in CamelCase' })
