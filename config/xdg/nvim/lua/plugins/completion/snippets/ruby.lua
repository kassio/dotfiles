local utils = require('utils.ruby')
local ls = require('luasnip')
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

local function selected_text(_, p)
  return p.env.TM_SELECTED_TEXT
end

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('#f', { t('# frozen_string_literal: true') }),
      s('aa', { t('attr_accessor ') }),
      s('ar', { t('attr_reader ') }),
      s('aw', { t('attr_writer ') }),
      s('pry', { t('binding.pry') }),
      s('prys', { t('binding.pry_shell') }),
      --
      s('begin', fmt([[
          begin do
            {body}
          end
        ]], {
          body = f(selected_text)
        })),
      --
      s('def', fmt([[
          def {name}
            {body}
          end
        ]], {
          name = i(1),
          body = f(selected_text)
        })),
      --
      s('do', fmt([[
          do
            {body}
          end
        ]], {
          body = f(selected_text)
        })),
      --
      s('dop', fmt([[
          do |{args}|
            {body}
          end
        ]], {
          args = i(1),
          body = f(selected_text)
        })),
      s('class', fmt([[
          class {name} {inheritance}
            {body}
          end
        ]], {
          name = f(function() return utils.file_namespace('class') end),
          inheritance = i(1),
          body = f(selected_text)
        })),
      --
      s('module', fmt([[
          module {name}
            {body}
          end
        ]], {
          name = f(function() return utils.file_namespace('module') end),
          body = f(selected_text)
        })),
    })
  end
}
