return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local utils = require('utils')
    local dap = require('dap')
    local widgets = require('dap.ui.widgets')
    local dapui = require('dapui')
    local hl = require('utils.highlights')

    -- Debugger
    hl.sign('DapBreakpoint', '●')
    hl.def('DapBreakpoint', { foreground = Theme.colors.error })

    hl.sign('DapBreakpointCondition', '◆')
    hl.extend('DapBreakpointCondition', 'Number')

    hl.sign('DapLogPoint', 'Ξ')
    hl.def('DapLogPoint', { foreground = Theme.colors.info })

    hl.sign('DapStopped', '▶')
    hl.def('DapStopped', { foreground = Theme.colors.hint })

    hl.sign('DapBreakpointRejected', '◎')
    hl.def('DapBreakpointRejected', { foreground = Theme.colors.warn })

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

    utils.keycmds({
      prefix = 'DAP',
      list = {
        { cmd = 'StepBack', key = '<F4>', fn = dap.step_back },
        { cmd = 'Continue', key = '<F5>', fn = dap.continue },
        { cmd = 'StepOver', key = '<F6>', fn = dap.step_over },
        { cmd = 'StepInto', key = '<F7>', fn = dap.step_into },
        { cmd = 'StepOut', key = '<F8>', fn = dap.step_out },
        { cmd = 'Close', key = '<F9>', fn = dap.close },
        { cmd = 'Hover', key = '<leader>dk', fn = widgets.hover },
        { cmd = 'REPL', key = '<leader>dr', fn = dap.repl.open },
        { cmd = 'RunLast', key = '<leader>dl', fn = dap.run_last },
        { cmd = 'ToggleBreakpoint', key = '<leader>db', fn = dap.toggle_breakpoint },
        { cmd = 'ToggleUI', key = '<leader>du', fn = dapui.toggle },
        {
          cmd = 'SetBreakpointCondition',
          key = '<leader>dB',
          fn = function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
          end,
        },
        {
          cmd = 'SetBreakpointLog',
          key = '<leader>dp',
          fn = function()
            dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
          end,
        },
      },
    })
  end,
}
