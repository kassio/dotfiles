return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')

    notify.setup({
      fps = 1,
      timeout = 1500,
      top_down = false,
      render = function(_bufnr, notification, _highlights, _config)
        if (notification.title or '') ~= '' then
          return 'default'
        else
          return 'minimal'
        end
      end,
      stages = 'fade',
    })

    vim.notify = notify
  end,
}
