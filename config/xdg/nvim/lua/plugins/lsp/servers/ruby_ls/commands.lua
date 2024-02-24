local NAME = 'ruby_ls'
local logger = require('utils').logger(NAME)

local function request(method, cb)
  local client = vim.lsp.get_clients({ name = NAME })[1]
  local params = vim.lsp.util.make_text_document_params(0)
  if client == nil then
    logger.error(NAME .. ' client not found')
    return
  end

  client.request(method, params, function(error, response)
    if error ~= nil then
      logger.error(string.format('%s\n%s', error.message, error.data.backtrace))
    end

    cb(response, error, client)
  end, 0)
end

return {
  setup = function()
    local INCLUDE_INDIRECT_OPTION = 'include_indirect'
    vim.api.nvim_create_user_command('LspRubyShowDependencies', function(opts)
      request('rubyLsp/workspace/dependencies', function(response)
        local include_indirect = opts.args == INCLUDE_INDIRECT_OPTION
        local dependencies = vim.fn.reduce(response, function(result, item)
          if not include_indirect and not item.dependency then
            return result
          end

          local label = string.format('%s (%s)', item.name, item.version.version)
          if not item.dependency then
            label = '[indirect] ' .. label
          end

          table.insert(result, { text = label, filename = item.path })

          return result
        end, {})

        vim.fn.setqflist(dependencies)
        vim.cmd.copen()
      end)
    end, {
      nargs = '?',
      complete = function()
        return { INCLUDE_INDIRECT_OPTION }
      end,
      desc = 'lsp: show ruby dependencies',
    })
  end,
}
