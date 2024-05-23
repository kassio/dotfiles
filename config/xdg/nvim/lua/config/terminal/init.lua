return {
  setup = function()
    local manager = require('config.terminal.manager')

    require('config.terminal.keymaps').setup(manager)
    require('config.terminal.commands').setup(manager)
    require('config.terminal.keymaps').setup(manager)
    require('config.terminal.autocmds').setup(manager)
  end,
}
