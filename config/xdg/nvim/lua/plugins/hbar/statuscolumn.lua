return {
  render = function()
    if not (vim.wo.number or vim.wo.relativenumber) then
      return ''
    end

    local fold = '%C'
    local sign = '%s'
    local lnum = '%=%l'

    if vim.wo.relativenumber then
      lnum = '%=%r'
    end

    if vim.v.relnum == 0 then
      lnum = '%l%='
    end

    return table.concat({
      fold,
      sign,
      lnum,
      '│',
    })
  end,
}
