return {
  setup = function()
    vim.uv.new_timer():start(
      0,
      1000,
      vim.schedule_wrap(function()
        local subscribers = vim.api.nvim_get_autocmds({ event = { 'User' }, pattern = { 'Tick' } })
        for _, subscriber in ipairs(subscribers) do
          if type(subscriber.callback) == 'function' then
            subscriber.callback()
          elseif #subscriber.cmd > 0 then
            vim.cmd(subscriber.cmd)
          end
        end
      end)
    )
  end,
}
