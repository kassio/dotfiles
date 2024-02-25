return {
  setup = function(telescope)
    telescope.load_extension('refactoring')
    telescope.load_extension('fzf')
    telescope.load_extension('notify')
    telescope.load_extension('ext')
    telescope.load_extension('rails')
  end,
}
