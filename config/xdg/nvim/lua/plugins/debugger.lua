return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
  },
  keys = {
    {
      '<F4>',
      function()
        require('dap').step_back()
      end,
      desc = 'dap: step back',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'dap: continue',
    },
    {
      '<F6>',
      function()
        require('dap').step_over()
      end,
      desc = 'dap: step over',
    },
    {
      '<F7>',
      function()
        require('dap').step_into()
      end,
      desc = 'dap: step into',
    },
    {
      '<F8>',
      function()
        require('dap').step_out()
      end,
      desc = 'dap: step out',
    },
    {
      '<F9>',
      function()
        require('dap').close()
      end,
      desc = 'dap: close',
    },
    {
      '<leader>dk',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'dap: hover',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'dap: repl',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'dap: run last',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'dap: toggle breakpoint',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'dap: toggle ui',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'dap: set breakpoint (conditionally)',
    },
    {
      '<leader>dp',
      function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end,
      desc = 'dap: set breakpoint (with log message)',
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('nvim-dap-virtual-text').setup()

    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
