return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ffinder = require("fzf-lua")
    ffinder.setup()

    require('plugins.fuzzyfinder.keymaps').setup(ffinder)
  end
}
