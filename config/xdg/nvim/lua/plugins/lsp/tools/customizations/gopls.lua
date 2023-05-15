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
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
