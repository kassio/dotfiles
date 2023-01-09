return {
  render = function(bufnr)
    local fullname = vim.api.nvim_buf_get_name(bufnr)

    if #fullname == 0 then
      return '[No name]'
    else
      local name = vim.fn.fnamemodify(fullname, ':.')

      if #name > 70 then
        local parts = vim.split(name, '/')
        return '.../' .. table.concat(parts, '/', 2, #parts)
      end

      return name
    end
  end,
}
