return {
  setup = function(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspRubyShowDependencies', function()
      local method = 'rubyLsp/workspace/dependencies'
      local client = vim.lsp.get_clients({ name = 'ruby_ls' })[1]

      local params = vim.lsp.util.make_text_document_params(bufnr)
      client.request(method, params, function(error, dependencies_list)
        if error ~= nil then
          vim.notify(
            'Error loading dependencies: ' .. error,
            vim.log.levels.ERROR,
            { title = 'Ruby LSP' }
          )
        end

        local dependencies = vim.fn.reduce(dependencies_list, function(result, dependency)
          local label = string.format('%s (%s)', dependency.name, dependency.version.version)
          if not dependency.dependency then
            label = '[indirect] ' .. label
          end

          table.insert(result, { text = label, filename = dependency.path })

          return result
        end, {})

        vim.fn.setqflist(dependencies)
        vim.cmd.copen()
      end, bufnr)
    end, {})
  end,
}
