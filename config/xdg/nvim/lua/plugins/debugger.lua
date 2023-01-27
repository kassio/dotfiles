return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
  },
  keys = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local widgets = require('dap.ui.widgets')

    return {
      { '<F4>', dap.step_back, desc = 'dap: step back' },
      { '<F5>', dap.continue, desc = 'dap: continue' },
      { '<F6>', dap.step_over, desc = 'dap: step over' },
      { '<F7>', dap.step_into, desc = 'dap: step into' },
      { '<F8>', dap.step_out, desc = 'dap: step out' },
      { '<F9>', dap.close, desc = 'dap: close' },
      { '<leader>dk', widgets.hover, desc = 'dap: hover' },
      { '<leader>dr', dap.repl.open, desc = 'dap: repl' },
      { '<leader>dl', dap.run_last, desc = 'dap: run last' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'dap: toggle breakpoint' },
      { '<leader>du', dapui.toggle, desc = 'dap: toggle ui' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'dap: set breakpoint (conditionally)',
      },
      {
        '<leader>dp',
        function()
          dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end,
        desc = 'dap: set breakpoint (with log message)',
      },
    }
  end,
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local hl = require('utils.highlights')

    require('nvim-dap-virtual-text').setup()

    -- Debugger
    hl.sign('DapBreakpoint', '●')
    hl.sign('DapBreakpointCondition', '◆')
    hl.sign('DapLogPoint', 'Ξ')
    hl.sign('DapStopped', '▶')
    hl.sign('DapBreakpointRejected', '◎')

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
