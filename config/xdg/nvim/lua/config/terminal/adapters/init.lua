--- Each adapter must have the following functions:
--- * toggle(opts) - open/hide the terminal
--- * only() - makes the terminal window the only one in the tab
--- * send(str) - send the given string to the terminal with a "\n" at the end
--- * keycode(str) - send the given keycode to the terminal, like "<c-c>" to kill a process
return {
  remote = require('config.terminal.adapters.remote'),
  native = require('config.terminal.adapters.native')
}
