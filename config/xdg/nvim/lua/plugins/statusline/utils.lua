local fn = vim.fn
local filetree = require('nvim-tree.lib')
local M = {}

M.filetree_current_file = function()
  local path = filetree.get_node_at_cursor().absolute_path

  if path then
    return './' .. fn.fnamemodify(path, ':.')
  else
    return fn.expand('%:~:h')
  end
end

M.neoterm_id = function()
  return 'neoterm-' .. vim.b.neoterm_id
end

M.mode = function()
  local mode_map = {
    ['n'] = 'N',
    ['no'] = 'O',
    ['nov'] = 'O',
    ['noV'] = 'O',
    ['no'] = 'O',
    ['niI'] = 'N',
    ['niR'] = 'N',
    ['niV'] = 'N',
    ['v'] = 'V',
    ['V'] = 'V',
    [''] = 'V',
    ['s'] = 'S',
    ['S'] = 'S',
    [''] = 'S',
    ['i'] = 'I',
    ['ic'] = 'I',
    ['ix'] = 'I',
    ['R'] = 'R',
    ['Rc'] = 'R',
    ['Rv'] = 'R',
    ['Rx'] = 'R',
    ['c'] = 'C',
    ['cv'] = 'E',
    ['ce'] = 'E',
    ['r'] = 'R',
    ['rm'] = 'M',
    ['r?'] = '?',
    ['!'] = '!',
    ['t'] = 'T',
  }
  local function get_mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if mode_map[mode_code] == nil then
      return mode_code
    end
    return mode_map[mode_code]
  end

  return {
    get_mode,
  }
end

return M