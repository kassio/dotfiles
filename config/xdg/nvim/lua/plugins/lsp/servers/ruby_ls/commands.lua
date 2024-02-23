local INCLUDE_INDIRECT_OPTION = 'include_indirect'

return {
  setup = function(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspRubyShowDependencies', function(opts)
      local method = 'rubyLsp/workspace/dependencies'
      local client = vim.lsp.get_clients({ name = 'ruby_ls' })[1]
      local include_indirect = opts.args == INCLUDE_INDIRECT_OPTION

      local params = vim.lsp.util.make_text_document_params(bufnr)
      client.request(method, params, function(error, dependencies_list)
        if error ~= nil then
          vim.notify(
            'Error loading dependencies: ' .. error,
            vim.log.levels.ERROR,
            { title = 'Ruby LSP' }
          )
        end

        local dependencies = vim.fn.reduce(dependencies_list, function(result, item)
          local label = string.format('%s (%s)', item.name, item.version.version)
          if not include_indirect and not item.dependency then
            return result
          end

          if not item.dependency then
            label = '[indirect] ' .. label
          end

          table.insert(result, { text = label, filename = item.path })

          return result
        end, {})

        vim.fn.setqflist(dependencies)
        vim.cmd.copen()
      end, bufnr)
    end, {
      nargs = '?',
      complete = function()
        return { INCLUDE_INDIRECT_OPTION }
      end,
    })
  end,
}
