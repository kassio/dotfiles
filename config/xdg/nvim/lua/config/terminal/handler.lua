local Handler = {}

local function scroll_after(termdata, callback)
  callback()
  vim.api.nvim_buf_call(termdata.window.bufnr, function()
    vim.cmd.normal('G')
  end)
end

function Handler.send(termdata, str)
  scroll_after(termdata, function()
    vim.api.nvim_chan_send(termdata.id, str .. '\n')
  end)
end

function Handler.keycode(termdata, str)
  scroll_after(termdata, function()
    vim.api.nvim_chan_send(termdata.id, vim.keycode(str))
  end)
end

return Handler
