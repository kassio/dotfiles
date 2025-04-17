local M = { finders_list = {} }
local default_find_command = {
  'fd',
  '--type',
  'file',
  '--type',
  'symlink',
  '--hidden',
  '--no-ignore-vcs',
  '--color',
  'never',
  '--exclude',
  '.git',
  '--exclude',
  '.DS_Store',
  '--exclude',
  '*.png',
  '--exclude',
  '*.jpeg',
  '--exclude',
  '*.gif',
}

local function tiebreak_lnum(entry1, entry2, _prompt)
  if not entry1 then
    return false
  end

  if not entry2 then
    return false
  end

  return entry1.lnum <= entry2.lnum
end

local function find_command(extra)
  return vim.fn.reduce(extra, function(result, ext)
    table.insert(result, '--extension')
    table.insert(result, ext)
    return result
  end, default_find_command)
end

function M.find_files(opts)
  opts = opts or {}

  local extensions = vim.iter({ opts.extensions }):flatten():totable()
  opts.extensions = nil

  local title = 'find files'
  if #extensions == 1 then
    title = string.format('find *.%s', extensions[1])
  elseif #extensions > 1 then
    title = string.format('find [%s]', table.concat(extensions, ', '))
  end

  local search_dirs = vim.iter({ opts.search_dirs }):flatten():totable()
  if #search_dirs > 0 then
    title = string.format('%s in (%s)', title, table.concat(search_dirs, ', '))
  end

  local new_opts = vim.tbl_deep_extend('keep', opts or {}, {
    find_command = find_command(extensions),
    search_dirs = search_dirs,
    prompt_title = title,
  })

  return require('telescope.builtin').find_files(new_opts)
end

function M.find_tabs()
  local tab_pages = vim.api.nvim_list_tabpages()

  if #tab_pages <= 1 then
    vim.notify('No tabs to select', vim.log.levels.INFO, { title = 'fuzzyfinder: tab finder' })
    return
  end

  vim.ui.select(tab_pages, {
    prompt = 'Select your tab',
    format_item = function(item)
      local winnr = vim.api.nvim_tabpage_get_win(item)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local name = vim.api.nvim_buf_get_name(bufnr)

      return vim.fn.fnamemodify(name, ':.')
    end,
  }, function(choice)
    if choice ~= nil then
      vim.cmd.tabnext(vim.api.nvim_tabpage_get_number(choice))
    end
  end)
end

function M.finders()
  if #M.finders_list == 0 then
    local builtin_pickers = require('telescope.builtin')
    local extensions_pickers = require('telescope._extensions')
    local list = vim
      .iter({
        vim.tbl_keys(builtin_pickers),
        vim.tbl_keys(extensions_pickers.manager),
      })
      :flatten()
      :totable()
    vim.fn.uniq(list)
    M.finders_list = list
  end

  table.sort(M.finders_list)

  vim.ui.select(M.finders_list, {
    prompt = 'Finders',
  }, function(choice)
    if choice ~= nil then
      vim.cmd('Telescope ' .. choice)
    end
  end)
end

function M.find_by_ext()
  vim.ui.input({ prompt = 'What extensions? (separated by space)' }, function(values)
    if values ~= nil and #values > 0 then
      local extensions = vim.tbl_map(function(value)
        local formatted, _ = string.gsub(value, '^%.', '')
        return formatted
      end, vim.split(values, ' ', { plain = true, trimempty = true }))

      M.find_files({ extensions = extensions })
    end
  end)
end

function M.current_buffer_fuzzy_find(opts)
  return require('telescope.builtin').current_buffer_fuzzy_find(
    vim.tbl_deep_extend('keep', opts or {}, {
      tiebreak = tiebreak_lnum,
    })
  )
end

function M.oldfiles(opts)
  require('telescope').extensions.recent_files.pick(opts)
end

function M.grep(opts)
  opts = opts or {}
  opts['prompt_title'] = opts['prompt_title'] or 'grep'
  require('telescope').extensions.live_grep_args.live_grep_args(opts)
end

return setmetatable(M, {
  __index = function(_table, key)
    return function(opts)
      require('telescope.builtin')[key](opts)
    end
  end,
})
