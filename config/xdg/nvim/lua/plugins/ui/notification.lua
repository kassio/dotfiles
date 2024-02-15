return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')

    notify.setup({
      timeout = 1250,
      top_down = false,
    })

    vim.notify = notify
  end,
}
