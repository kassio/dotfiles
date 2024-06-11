local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim
    .system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      lazypath,
    })
    :wait()
  vim
    .system({
      'git',
      '-C',
      lazypath,
      'checkout',
      'tags/stable',
    })
    :wait() -- last stable release
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  lockfile = vim.fn.stdpath('cache') .. '/lazy-lock.json',
  spec = {
    { import = 'plugins' },
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
