local theme = require('plugins.highlight.theme')
local hls = require('my.utils.highlights')
local stl_hl = require('plugins.statusline.utils').highlight

hls.def('StatuslineModeNormal', {
  background = theme.colors.blue,
  foreground = theme.colors.mantle,
  bold = true,
})
hls.extend('StatuslineModeCmd', 'StatuslineModeNormal', { background = '#00ff00' })
hls.extend('StatuslineModeInsert', 'StatuslineModeNormal', { background = '#0fa000' })
hls.extend('StatuslineModeReplace', 'StatuslineModeNormal', { background = '#ff55dd' })
hls.extend('StatuslineModeSearch', 'StatuslineModeNormal', { background = '#ff55dd' })
hls.extend('StatuslineModeSelect', 'StatuslineModeNormal', { background = '#ff55dd' })
hls.extend('StatuslineModeTerminal', 'StatuslineModeNormal', { background = '#005000' })
hls.extend('StatuslineModeVisual', 'StatuslineModeNormal', { background = '#ff55dd' })

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
  ['!'] = 'StatuslineModeNormal',
  ['?'] = 'StatuslineModeSearch',
  ['C'] = 'StatuslineModeCmd',
  ['E'] = 'StatuslineModeCmd',
  ['I'] = 'StatuslineModeInsert',
  ['M'] = 'StatuslineModeNormal',
  ['N'] = 'StatuslineModeNormal',
  ['O'] = 'StatuslineModeNormal',
  ['R'] = 'StatuslineModeReplace',
  ['S'] = 'StatuslineModeSelect',
  ['T'] = 'StatuslineModeTerminal',
  ['V'] = 'StatuslineModeVisual',
}

return {
  render = function()
    local mode_code = vim.api.nvim_get_mode().mode

    if mode_map[mode_code] == nil then
      return mode_code
    end

    local mode = mode_map[mode_code]

    return string.format('%s %s %%*', stl_hl(mode_highlights[mode]), mode)
  end,
}
