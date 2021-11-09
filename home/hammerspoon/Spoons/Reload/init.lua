local function init()
  local function reloadConfig()
    hs.reload()
    hs.console.clearConsole()
  end

  hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/',  reloadConfig):start()

  hs.urlevent.bind('hs-reload', function()
    reloadConfig()
  end)
end

init()
