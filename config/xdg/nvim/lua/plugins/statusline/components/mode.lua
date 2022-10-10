local theme = require('plugins.highlight.theme')
local hls = require('my.utils.highlights')
local stl_hl = require('plugins.statusline.utils').highlight

hls.extend('Statusline.Mode.Normal', 'Theme.Blue.Background', {
  foreground = theme.colors.mantle,
  bold = true,
})
hls.extend('Statusline.Mode.Cmd', 'Statusline.Mode.Normal', { background = '#00ff00' })
hls.extend('Statusline.Mode.Insert', 'Statusline.Mode.Normal', { background = '#0fa000' })
hls.extend('Statusline.Mode.Replace', 'Statusline.Mode.Normal', { background = '#ff55dd' })
hls.extend('Statusline.Mode.Search', 'Statusline.Mode.Normal', { background = '#ff55dd' })
hls.extend('Statusline.Mode.Select', 'Statusline.Mode.Normal', { background = '#ff55dd' })
hls.extend('Statusline.Mode.Terminal', 'Statusline.Mode.Normal', { background = '#005000' })
hls.extend('Statusline.Mode.Visual', 'Statusline.Mode.Normal', { background = '#ff55dd' })

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

    return string.format('%s %s %%*', stl_hl('Mode', mode_highlights[mode]), mode)
  end,
}
