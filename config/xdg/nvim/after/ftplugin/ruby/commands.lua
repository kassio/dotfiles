local utils = require('utils')

local function S(pattern, replace)
  return string.format('s/%s/%s/e', pattern, replace)
end

local function builder(cmd)
  vim.api.nvim_create_user_command('Ruby' .. cmd.name, function(opts)
    utils.buffers.preserve(function()
      vim.cmd(string.format('keeppatterns silent! %s,%s %s', opts.line1, opts.line2, cmd.cmd))
    end)
  end, { range = true, desc = 'ruby: ' .. cmd.desc })
end

local commands = {
  {
    name = 'ModernizeHashSymbolKey',
    cmd = S([[:\(\w\+\)\s*=>\s*\ze]], [[\1:\ ]]),
    desc = '{ :a => 1 } to { a: 1}',
  },
  {
    name = 'SymbolifyHashStringKeys',
    cmd = S([[\(['"]\)\([^\1]\{-\}\)\1\s*\(=>\|:\)]], [[\2:]]),
    desc = '{ "a" => 1 } to { a: 1 }',
  },
  {
    name = 'StringifyHashSymbolKeys',
    cmd = S([[\(\w\+\)\%(:\|\s*=>\)]], [['\1' =>]]),
    desc = '{ a: 1 } to { "a" => 1 }',
  },
  {
    name = 'LetToVar',
    cmd = S([[\<let\%(!\|\w\+\)\?(:\(\w\+\))\s*{\s*\(.\{-\}\)\s*}]], [[\1 = \2]]),
    desc = 'let(:foo) { value } to foo = value',
  },
  {
    name = 'VarToLet',
    cmd = S([[@\?\(\w\+\)\s*=\s*\(.*\)]], [[let(:\1) { \2 }]]),
    desc = 'foo = value to let(:foo) { value }',
  },
}

for _, cmd in ipairs(commands) do
  builder(cmd)
end
