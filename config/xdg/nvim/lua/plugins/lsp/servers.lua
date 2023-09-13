local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

local function config(server, defaults)
  local ok, cfg = pcall(require, 'plugins.lsp.servers.' .. server)

  if not ok then
    return defaults
  end

  return vim.tbl_deep_extend('force', defaults, cfg)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  bashls = {
    install = 'brew install bash-language-server',
    description = 'bash',
  },
  cssls = {
    install = 'brew install vscode-langservers-extracted',
    description = 'css',
  },
  gopls = {
    install = 'go install golang.org/x/tools/gopls@latest',
    description = 'go',
  },
  jsonls = {
    install = 'brew install vscode-langservers-extracted',
    description = 'json',
  },
  jsonnet_ls = {
    install = 'go install github.com/grafana/jsonnet-language-server@latest',
    description = 'jsonnet',
  },
  jqls = {
    install = 'go install github.com/wader/jq-lsp@master',
    description = 'jq',
  },
  lua_ls = {
    install = 'brew instal lua-language-server',
    description = 'lua',
  },
  solargraph = {
    install = 'brew install solargraph',
    description = 'ruby',
  },
  sqlls = {
    install = 'brew install sql-language-server',
    description = 'sql',
  },
  yamlls = {
    install = 'brew install yaml-language-server',
    description = 'yaml',
  },
}

return {
  setup = function()
    vim.api.nvim_create_user_command('LspInstall', function()
      require('plugins.lsp.servers').install()
    end, {})

    for server, _ in pairs(servers) do
      local cfgs = config(server, {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(cfgs)
    end
  end,
  install = function()
    local utils = require('utils')
    local log = utils.logger('lsp')

    for server, cmd in pairs(servers) do
      log.info(cmd.install, 'installing ' .. server)

      vim.system(utils.string.split(cmd.install, ' '), { text = true }, function(obj)
        local code = obj.code or 0
        local sign = obj.sign or 0
        local msg = function(head)
          return table.concat(
            utils.table.compact_list({
              head,
              obj.stdout,
              obj.stderr,
            }),
            '\n'
          )
        end

        if code == 0 and sign == 0 then
          log.info(msg('Installed'), server)
        else
          log.error(msg('Failed'), server)
        end
      end)
    end
  end,
}
