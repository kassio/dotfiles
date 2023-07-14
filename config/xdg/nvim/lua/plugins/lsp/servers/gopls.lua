return {
  settings = {
    gopls = {
      experimentalPostfixCompletions = true, -- experimental
      gofumpt = false,
      usePlaceholders = true,
      staticcheck = true, -- experimental
      codelenses = {
        generate = true,
        gc_details = true,
        tide = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
