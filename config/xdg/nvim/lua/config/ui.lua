return {
  setup = function()
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = { 'Tick' },
      group = vim.api.nvim_create_augroup('user:ui', { clear = false }),
      callback = function()
        local cmd = vim.system({ 'macos-appearance' }, { text = true }):wait()
        local appearance = vim.trim(cmd.stdout) or 'light'

        if vim.o.background ~= appearance then
          vim.o.background = appearance
        end
      end,
    })
  end,
}
