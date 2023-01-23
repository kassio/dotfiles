local opt = vim.opt

-- Space as map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.autowriteall = true
opt.backup = false
opt.cindent = true
opt.cmdheight = 1
opt.colorcolumn = { 80, 100, 120 }
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
opt.fileencodings = { 'utf8', 'nobomb' }
opt.fileformats = { 'unix', 'mac' }
opt.foldcolumn = '1'
opt.foldenable = false
opt.foldmethod = 'manual'
opt.foldnestmax = 3
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
opt.secure = true
opt.sessionoptions = { 'winpos', 'tabpages', 'help' }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = 'filnxtToOFWIcC'
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
opt.splitright = true
opt.splitkeep = 'screen'
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

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
