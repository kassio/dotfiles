local function render(path)
  local ok, lib = pcall(require, path)

  if ok and lib ~= nil then
    return lib.statusline(50), true
  end

  return '', false
end

return {
  render = function()
    local filetype = vim.bo.filetype or ''

    if filetype ~= '' then
      local value, ok = render('config.status.modules.treesitter_context.' .. filetype)
      if ok then
        return value
      end
    end

    return render('nvim-treesitter.statusline')
  end,
}
