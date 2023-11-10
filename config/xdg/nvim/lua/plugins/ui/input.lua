return {
  'stevearc/dressing.nvim',
  config = function()
    require('dressing').setup({
      input = {
        enabled = true,
        title_pos = 'center',
        relative = 'editor',
      },
      select = {
        enabled = true,
        title_pos = 'center',
        relative = 'editor',
      },
    })
  end,
}
