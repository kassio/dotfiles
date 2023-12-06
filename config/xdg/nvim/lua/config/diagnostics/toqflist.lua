local symbols = require('utils/symbols')

-- couldn't find a better way to format diagnostic messages on the qflist
-- copied from https://github.com/neovim/neovim/blob/v0.9.4/runtime/lua/vim/diagnostic.lua
return function(diagnostics)
      vim.validate({
        diagnostics = {
          diagnostics,
          vim.tbl_islist,
          'a list of diagnostics',
        },
      })


      local list = {}
      for _, v in ipairs(diagnostics) do
        local message = v.message
        if v.code ~= nil then
          message = string.format('[%s] %s', v.code, message)
        end

        local item = {
          bufnr = v.bufnr,
          lnum = v.lnum + 1,
          col = v.col and (v.col + 1) or nil,
          end_lnum = v.end_lnum and (v.end_lnum + 1) or nil,
          end_col = v.end_col and (v.end_col + 1) or nil,
          text = message,
          type = symbols.diagnostics[v.severity] or symbols.diagnostics.error,
        }
        table.insert(list, item)
      end
      table.sort(list, function(a, b)
        if a.bufnr == b.bufnr then
          if a.lnum == b.lnum then
            return a.col < b.col
          else
            return a.lnum < b.lnum
          end
        else
          return a.bufnr < b.bufnr
        end
      end)
      return list
    end

