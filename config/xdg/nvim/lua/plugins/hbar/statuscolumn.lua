return {
  render = function()
    local winnr = vim.api.nvim_get_current_win()

    if not vim.wo[winnr].number then
      return ''
    end

    local fold = '%C'
    local sign = '%s'
    local lnum = '%=%l'

    if vim.v.relnum == 0 then
      lnum = '%l%='
    end

    if vim.wo[winnr].relativenumber then
      lnum = '%=%r'
    end

    return table.concat({
      fold,
      sign,
      lnum,
      '│',
    })
  end,
}
