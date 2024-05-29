function overridable(tbl)
  return setmetatable(tbl, {
    __call = function(t, opts)
      opts = opts or {}
      local result = {}

      for k, v in pairs(t) do
        result[k] = opts[k] or v
      end

      for k, v in pairs(opts) do
        result[k] = opts[k] or v
      end

      return result
    end,
  })
end

return {
  size = 16,
  main = overridable({
    family = 'JetBrains Mono',
    weight = 'DemiBold',
    harfbuzz_features = {
      'calt=0', -- disable all ligatures by default
      'zero', -- slashed zero 0
    },
  }),

  emoji = overridable({
    family = 'Apple Color Emoji',
    assume_emoji_presentation = true,
  }),
}
