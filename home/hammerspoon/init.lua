local function reloadConfig()
  hs.reload()
  hs.alert.show('Config reloaded')
end

hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/',  reloadConfig):start()
hs.urlevent.bind('RELOAD', function()
  reloadConfig()
end)

vim_keys = require('spoons.fn-arrows')

-- hs.hotkey.bind({ 'fn' }, 'W', function()
--   hs.alert.show('Hello World!')
-- end)
