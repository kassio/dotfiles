local keymap = vim.keymap
local fn = vim.fn
local utils = require('utils')

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

keymap.set({ 'n', 'x' }, '!', function()
  local cword = utils.cword()
  vim.fn.setreg('/', cword)
  vim.api.nvim_feedkeys('nN', 'n', false)
end, { desc = 'search current word' })

keymap.set({ 'n', 'x' }, '<leader>!', function()
  local cword = utils.cword()
  vim.fn.setreg('/', '\\c' .. cword)
  vim.api.nvim_feedkeys('nN', 'n', false)
end, { desc = 'search current word case insensitive' })

keymap.set({ 'n', 'x' }, 'g!', function()
  local cword = utils.cword()
  vim.fn.setreg('/', '\\<' .. cword .. '\\>')
  vim.api.nvim_feedkeys('nN', 'n', false)
end, { desc = 'search current word exclusive' })

keymap.set('n', '<leader>bd', '<cmd>bw!<cr>', { desc = 'delete current buffer' })
keymap.set('n', '<leader>da', '<cmd>bufdo bw!<cr>', { desc = 'delete all buffers' })

-- can be overwritten by lsp
keymap.set('n', '<leader>f=', function()
  utils.buffers.preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
end, { desc = 'format (sync)' })

keymap.set('n', '<leader>bo', function() -- delete all buffers but current
  local current = vim.api.nvim_win_get_buf(0)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = 'delete all buffers except current' })

keymap.set('n', '<leader>ch', function() -- delete all hidden buffers
  local deleted = 0
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if
      not vim.bo[bufnr].buflisted
      or vim.bo[bufnr].bufhidden == 'hide'
      or vim.bo[bufnr].buftype == 'nofile'
      or vim.tbl_isempty(fn.win_findbuf(bufnr))
    then
      deleted = deleted + 1
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end

  vim.notify(deleted .. ' unlisted buffers closed')
end, { desc = 'close: hidden and unlisted buffers' })

keymap.set('n', '<leader>cf', function()
  local deleted = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, config = pcall(vim.api.nvim_win_get_config, win)

    if ok and config.relative ~= '' then
      deleted = deleted + 1
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.notify(deleted .. ' floating windows closed')
end, { desc = 'close: floating windows' })

keymap.set('n', '<leader>fs', function()
  local tab_pages = vim.api.nvim_list_tabpages()

  vim.ui.select(tab_pages, {
    prompt = 'Select your tab',
    format_item = function(item)
      local winnr = vim.api.nvim_tabpage_get_win(item)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local name = vim.api.nvim_buf_get_name(bufnr)

      return vim.fn.fnamemodify(name, ':.')
    end,
  }, function(choice)
    vim.cmd.tabnext(vim.api.nvim_tabpage_get_number(choice))
  end)
end, { silent = true, desc = 'fuzzy: tab selector' })
