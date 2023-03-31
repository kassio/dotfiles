return {
  render = function()
    return string.format(
      ' %s ',
      table.concat({
        '%n',
        '%f',
        '%=',
        '%3l:%-3c %3p%%',
      }, ' ')
    )
  end,
}
