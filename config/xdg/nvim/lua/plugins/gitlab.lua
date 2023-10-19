return {
  {
    url = 'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    branch = 'main',
    lazy = false,
    config = function()
      require('gitlab').setup({
        minimal_message_level = vim.lsp.log_levels.WARN,
        statusline = {
          enabled = false,
        },
      })
    end,
  },
}
