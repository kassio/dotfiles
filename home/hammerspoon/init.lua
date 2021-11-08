local function reloadConfig()
  hs.reload()
  hs.alert.show('Config reloaded')
end

hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/',  reloadConfig):start()
hs.urlevent.bind('RELOAD', function()
  reloadConfig()
end)

hs.loadSpoon('FnMate')
