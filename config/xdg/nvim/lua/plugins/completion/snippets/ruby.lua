return {
  setup = function()
    local utils = require("utils.ruby")
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local f = ls.function_node

    ls.add_snippets("ruby", {
      s("#f", {
        t('# frozen_string_literal: true'),
      }),
      s("class", {
        f(function()
          return utils.file_namespace('class')
        end)
      }),
      s("module", {
        f(function()
          return utils.file_namespace('module')
        end)
      }),
    })
  end
}
