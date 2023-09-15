local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

local function config(server, defaults)
  local ok, cfg = pcall(require, 'plugins.lsp.servers.' .. server)

  if not ok then
    return defaults
  end

  return vim.tbl_deep_extend('force', defaults, cfg)
end

local servers = {
  bashls = {
    install = 'brew install bash-language-server',
  },
  cssls = {
    install = 'brew install vscode-langservers-extracted',
  },
  gopls = {
    install = 'go install golang.org/x/tools/gopls@latest',
  },
  jsonls = {
    install = 'brew install vscode-langservers-extracted',
  },
  jsonnet_ls = {
    install = 'go install github.com/grafana/jsonnet-language-server@latest',
  },
  jqls = {
    install = 'go install github.com/wader/jq-lsp@master',
  },
  lua_ls = {
    install = 'brew instal lua-language-server',
    config = require('plugins.lsp.servers.lua_ls'),
  },
  solargraph = {
    install = 'brew install solargraph',
    config = require('plugins.lsp.servers.solargraph'),
  },
  sqlls = {
    install = 'brew install sql-language-server',
  },
  yamlls = {
    install = 'brew install yaml-language-server',
  },
}

return {
  setup = function()
    vim.api.nvim_create_user_command('LspInstall', function()
      require('plugins.lsp.servers').install()
    end, {})

    for server, opts in pairs(servers) do
      local cfgs = config(server, {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(vim.tbl_deep_extend('force', cfgs, opts.config or {}))
    end
  end,

  install = function()
    local utils = require('utils')
    local log = utils.logger('lsp')
    local commands = vim.tbl_deep_extend('keep', servers, {
      ['shell linter'] = {
        install = 'brew install shellcheck',
      },
      ['shell formatter'] = {
        install = 'brew install shfmt',
      },
      ['html formatter'] = {
        install = ' brew install tidy-html5',
      },
    })

    for title, cmd in pairs(commands) do
      log.info(cmd.install, 'installing ' .. title)

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
          log.info(msg('Installed'), title)
        else
          log.error(msg('Failed'), title)
        end
      end):wait()
    end
  end,
}
