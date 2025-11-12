return {
  setup = function()
    local utils = require("utils.snippets")
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local f = ls.function_node

    ls.add_snippets("all", {
      s("#!", {
        t('#!/usr/bin/env '),
      }),
      s("hri", {
        t("--------------------------------------------------------------------------------"),
      }),
      s("fname", {
        f(function()
          return utils.filename()
        end)
      }),
      s("fname:camelcase", {
        f(function()
          return utils.filename({case = 'camelcase'})
        end)
      }),
      s("fname:camelcase:noprefixnumbers", {
        f(function()
          return utils.filename({remove = '^%d*_', case = 'camelcase'})
        end)
      }),
    })
  end
}
