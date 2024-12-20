local utils = require('utils')

local function S(pattern, replace)
  return function(opts)
    vim.cmd(
      string.format(
        'keeppatterns silent! %s,%s s/%s/%s/ge',
        opts.line1,
        opts.line2,
        pattern,
        replace
      )
    )
  end
end

local function builder(cmd)
  vim.api.nvim_create_user_command('Ruby' .. cmd.name, function(opts)
    utils.buffers.preserve(function()
      cmd.callback(opts)
    end)
  end, vim.tbl_deep_extend('force', cmd.opts, { desc = 'ruby: ' .. cmd.desc }))
end

local commands = {
  {
    name = 'ModernizeHashSymbolKey',
    callback = S([[:\(\w\+\)\s*=>\s*\ze]], [[\1:\ ]]),
    desc = '{ :a => 1 } to { a: 1}',
    opts = { range = true },
  },
  {
    name = 'SymbolifyHashStringKeys',
    callback = S([[\(['"]\)\([^\1]\{-\}\)\1\s*\(=>\|:\)]], [[\2:]]),
    desc = '{ "a" => 1 } to { a: 1 }',
    opts = { range = true },
  },
  {
    name = 'StringifyHashSymbolKeys',
    callback = S([[\(\w\+\)\%(:\|\s*=>\)]], [['\1' =>]]),
    desc = '{ a: 1 } to { "a" => 1 }',
    opts = { range = true },
  },
  {
    name = 'LetToVar',
    callback = S([[\<let\%(!\|\w\+\)\?(:\(\w\+\))\s*{\s*\(.\{-\}\)\s*}]], [[\1 = \2]]),
    desc = 'let(:foo) { value } to foo = value',
    opts = { range = true },
  },
  {
    name = 'VarToLet',
    callback = S([[@\?\(\w\+\)\s*=\s*\(.*\)]], [[let(:\1) { \2 }]]),
    desc = 'foo = value to let(:foo) { value }',
    opts = { range = true },
  },
  {
    name = 'UseBlockChange',
    callback = S([[change(\([^,]\+\), :\([^)]\+\))]], [[change { \1.\2 }]]),
    desc = 'change(Foo, :bar) to change { Foo.bar }',
    opts = { range = true },
  },
  {
    name = 'MatchTap',
    callback = function()
      vim.fn.setreg('/', [[.tap\s*{[^}]*}]])
      vim.api.nvim_feedkeys('nN', 'n', false)
    end,
    desc = 'match .tap { .* }',
    opts = { range = true },
  },
  {
    name = 'CopyNamespace',
    callback = function(opts)
      local namespace = utils.ruby.treesitter_namespace()
      if namespace ~= '' then
        utils.to_clipboard(namespace, opts.bang)
      else
        vim.notify("Can't find current namespace", vim.log.levels.WARN, { title = 'ruby' })
      end
    end,
    desc = 'copy namespace based on the file path',
    opts = { bang = true },
  },
}

for _, cmd in ipairs(commands) do
  builder(cmd)
end
