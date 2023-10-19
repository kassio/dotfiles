local g = vim.g
local opt = vim.opt

-- Space as map leader
g.mapleader = ' '
g.maplocalleader = ' '

-- fix markdown indentation settings
g.markdown_recommended_style = 0

-- don't use lastplace on:
g.lastplace_ignore = 'gitcommit,gitrebase'
g.lastplace_ignore_buftype = 'quickfix,nofile,help'

opt.autowriteall = true
opt.backup = false
opt.cindent = true
opt.cdhome = true
opt.cmdheight = 0
opt.colorcolumn = {
  80,
  100,
  120,
}
opt.complete:remove('t')
opt.completeopt = {
  'menu',
  'menuone',
  'preview',
  'noselect',
}
opt.confirm = true
opt.copyindent = true
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.dictionary = '/usr/share/dict/words'
opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'vertical',
}
opt.expandtab = true
opt.fileencodings = {
  'utf8',
  'nobomb',
}
opt.fileformats = {
  'unix',
  'mac',
}
opt.fillchars:append({
  eob = ' ',
})
opt.foldcolumn = '1'
opt.foldenable = false
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldmethod = 'expr'
opt.foldnestmax = 5
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.infercase = true
opt.jumpoptions = 'view'
opt.list = true
opt.listchars = {
  extends = '>',
  lead = '·',
  multispace = '++',
  nbsp = '·',
  precedes = '<',
  tab = '≫·',
  trail = '·',
}
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 5
opt.relativenumber = false
opt.scrolloff = 3
opt.secure = true
opt.sessionoptions = {
  'winpos',
  'tabpages',
  'help',
}
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = 'filnxtToOFWIcC'
opt.showcmdloc = 'statusline'
opt.showmatch = true
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.spell = true
opt.spelllang = 'en'
opt.splitbelow = true
opt.splitkeep = 'cursor'
opt.splitright = true
opt.swapfile = false
opt.switchbuf = { 'useopen', 'usetab', 'split' }
opt.tabstop = 2
opt.tags = ''
opt.termguicolors = true
opt.textwidth = 100
opt.title = false
opt.undofile = true
opt.undolevels = 10000
opt.undoreload = 10000
opt.virtualedit = 'block'
opt.wildignorecase = true
opt.wrap = false
opt.writebackup = false
