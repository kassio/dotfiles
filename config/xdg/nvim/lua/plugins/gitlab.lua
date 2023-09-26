return {
  {
    url = 'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    lazy = false,
    config = function()
      require('gitlab').setup({
        statusline = {
          enabled = false,
        },
      })
    end,
  },
}
