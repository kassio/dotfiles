local utils = require('my.utils')
local devicons = require('nvim-web-devicons')
local icons = devicons.get_icons()
local extended_icon_highlight = {}

local ext = function(source, target)
  vim.tbl_extend('force', icons[source], { name = target })
end

icons['rb'] = {
  icon = '',
  color = '#701516',
  cterm_color = '52',
  name = 'rb',
}

icons['Brewfile'] = ext('rb', 'Brewfile')
icons['Gemfile$'] = ext('rb', 'gemspec')
icons['config.ru'] = ext('rb', 'gemspec')
icons.bash = icons['bash']
icons.gemspec = ext('rb', 'gemspec')
icons.go = icons['go']
icons.irbrc = ext('rb', 'irbrc')
icons.pryrc = ext('rb', 'pryrc')
icons.rake = ext('rb', 'rake')
icons.rakefile = ext('rb', 'rakefile')
icons.rb = icons['rb']
icons.ruby = ext('rb', 'ruby')
icons.sh = icons['sh']
icons.zsh = icons['zsh']

devicons.setup({ override = icons })

devicons.fileicon = function(filetype, filename)
  local extension = vim.fn.fnamemodify(filename, ':e') or filetype

  return devicons.get_icon(filename, extension, { default = true })
end

devicons.fileicon_color = function(filetype, filename)
  local extension = vim.fn.fnamemodify(filename, ':e') or filetype

  return devicons.get_icon_color(filename, extension, { default = true })
end

devicons.fileicon_name = function(filetype)
  return devicons.get_icon_name_by_filetype(filetype) or 'Default'
end

devicons.fileicon_extend_hl = function(filetype, filename, hl)
  local icon, icon_color = devicons.fileicon_color(filetype, filename)
  local icon_name = devicons.fileicon_name(filetype)
  local ext = { foreground = icon_color }
  local name = hl .. string.camelcase(icon_name) .. 'Icon'

  if extended_icon_highlight[name] == nil then
    utils.highlights.extend(name, hl, ext)
    extended_icon_highlight[name] = { hl = hl, ext = ext }
  end

  return icon, name
end

devicons.reload_fileicon_extends = function()
  for name, tbl in pairs(extended_icon_highlight) do
    utils.highlights.extend(name, tbl.hl, tbl.ext)
  end
end

devicons.buffers = {}

devicons.buffers.fileicon = function(bufnr)
  local filename, filetype = utils.buffers.name_and_type(bufnr)

  return devicons.fileicon(filetype, filename)
end

devicons.buffers.fileicon_extend_hl = function(bufnr, hl)
  local filename, filetype = utils.buffers.name_and_type(bufnr)

  return devicons.fileicon_extend_hl(filetype, filename, hl)
end

return devicons
