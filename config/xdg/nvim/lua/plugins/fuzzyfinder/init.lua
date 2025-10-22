return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ffinder = require("fzf-lua")
    ffinder.setup({
      keymap = {
        builtin = {
          ["<c-;>"] = "toggle-preview",
        },
      },
      actions = {
        files = {
          ["ctrl-q"] = ffinder.actions.file_sel_to_qf,
          ["ctrl-x"] = ffinder.actions.file_split
        }
      },
      lsp = {
        jump1 = false,
        async_or_timeout = 100000,
        code_actions = {
          winopts = {
            preview = { hidden = true },
            height = 0.40,
            width = 0.30,
            row = 0.35,
            col = 0.50,
          },
        },
      },
    })

    require('plugins.fuzzyfinder.keymaps').setup(ffinder)
  end
}
