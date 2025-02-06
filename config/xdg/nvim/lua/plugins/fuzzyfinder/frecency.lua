return {
  setup = function(telescope)
    require('frecency.config').setup({
      auto_validate = true,
      ignore_patterns = { '*/.git', '*/.git/*', '*/.DS_Store' },
    })
  end,
}
