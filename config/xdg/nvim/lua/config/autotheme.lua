local function check_appearance()
  local cmd = vim.system({ 'macos-appearance' }, { text = true }):wait()
  local appearance = vim.trim(cmd.stdout) or 'light'

  if vim.o.background ~= appearance then
    vim.o.background = appearance
  end
end

return {
  setup = function()
    local timer = vim.uv.new_timer()

    timer:start(0, 1000, vim.schedule_wrap(check_appearance))
  end,
}
