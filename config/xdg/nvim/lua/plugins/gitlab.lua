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
      minimal_message_level = vim.lsp.log_levels.ERROR,
      statusline = {
        enabled = false,
      },
      code_suggestions = {
        -- Required in order to avoid "multiple different client offset_encodings
        -- detected for buffer, this is not supported yet" warning due to other LSP
        -- clients using UTF-16
        offset_encoding = 'utf-16',
      },
    },
  },
}
