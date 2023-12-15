return {
  {
    url = 'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    ft = {
      'go',
      'javascript',
      'python',
      'ruby',
    },
    cond = function()
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
    end,
    opts = {
      minimal_message_level = vim.lsp.log_levels.WARN,
      statusline = {
        enabled = false,
      },
    },
  },
}
