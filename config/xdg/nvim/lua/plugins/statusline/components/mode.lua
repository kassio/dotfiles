local theme = require('plugins.highlight.theme')
local utils = require('my.utils')

local hl = utils.statusline.highlighter('Statusline', 'Mode')

local extend_mode_hls = function(target, origin, ext)
  return utils.highlights.extend('Statusline.Mode.' .. target, 'Statusline.Mode.' .. origin, ext)
end

utils.highlights.extend('Statusline.Mode.Normal', 'Theme.Blue.Background', {
  foreground = theme.colors.mantle,
  bold = true,
})
extend_mode_hls('Cmd', 'Normal', { background = '#00ff00' })
extend_mode_hls('Insert', 'Normal', { background = '#0fa000' })
extend_mode_hls('Replace', 'Normal', { background = '#ff55dd' })
extend_mode_hls('Search', 'Normal', { background = '#ff55dd' })
extend_mode_hls('Select', 'Normal', { background = '#ff55dd' })
extend_mode_hls('Terminal', 'Normal', { background = '#005000' })
extend_mode_hls('Visual', 'Normal', { background = '#ff55dd' })

local mode_map = {
  [''] = 'S',
  [''] = 'V',
  ['!'] = '!',
  ['R'] = 'R',
  ['Rc'] = 'R',
  ['Rv'] = 'R',
  ['Rx'] = 'R',
  ['S'] = 'S',
  ['V'] = 'V',
  ['c'] = 'C',
  ['ce'] = 'E',
  ['cv'] = 'E',
  ['i'] = 'I',
  ['ic'] = 'I',
  ['ix'] = 'I',
  ['n'] = 'N',
  ['niI'] = 'N',
  ['niR'] = 'N',
  ['niV'] = 'N',
  ['no'] = 'O',
  ['no'] = 'O',
  ['noV'] = 'O',
  ['nov'] = 'O',
  ['nt'] = 'N',
  ['r'] = 'R',
  ['r?'] = '?',
  ['rm'] = 'M',
  ['s'] = 'S',
  ['t'] = 'T',
  ['v'] = 'V',
}

local mode_highlights = {
  ['!'] = 'Normal',
  ['?'] = 'Search',
  ['C'] = 'Cmd',
  ['E'] = 'Cmd',
  ['I'] = 'Insert',
  ['M'] = 'Normal',
  ['N'] = 'Normal',
  ['O'] = 'Normal',
  ['R'] = 'Replace',
  ['S'] = 'Select',
  ['T'] = 'Terminal',
  ['V'] = 'Visual',
}

return {
  render = function()
    local mode_code = vim.api.nvim_get_mode().mode

    if mode_map[mode_code] == nil then
      return mode_code
    end

    local mode = mode_map[mode_code]

    return string.format('%s %s %%*', hl(mode_highlights[mode]), mode)
  end,
}
