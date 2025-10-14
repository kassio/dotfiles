return {
  cmd = {
    "npx",
    "--registry=https://gitlab.com/api/v4/packages/npm/",
    "@gitlab-org/gitlab-lsp",
    "--stdio",
  },
  filetypes = { "ruby", "go", "javascript", "typescript", "rust", "lua" },
  root_markers = { ".git" },
  settings = {
    baseUrl = "https://gitlab.com",
    token = vim.env.GITLAB_TOKEN,
    featureFlags = {
      streamCodeGenerations= false,
    },
  },
}
