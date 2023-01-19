return {
  render = function()
    local winnr = vim.api.nvim_get_current_win()

    if not vim.wo[winnr].number then
      return table.concat({
        '%s',
        '│',
      })
    end

    local relativenumber = '%l'
    if vim.wo[winnr].relativenumber then
      relativenumber = '%r'
    end

    if vim.v.relnum == 0 then
      return table.concat({
        '%s',
        '%l',
        '%=',
        '│',
      })
    else
      return table.concat({
        '%s',
        '%=',
        relativenumber,
        '│',
      })
    end
  end,
}
