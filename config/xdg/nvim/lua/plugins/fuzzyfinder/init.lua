return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ffinder = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    ffinder.setup({
      { "fzf-native", "hide" },
      keymap = {
        builtin = {
          ["<c-l>"] = "toggle-preview",
        }
      },
      actions = {
        files = {
          ["default"] = actions.file_edit,
          ["ctrl-x"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["ctrl-q"] = actions.file_sel_to_qf,
        },
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
