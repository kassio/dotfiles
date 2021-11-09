local function init()
  hs.urlevent.bind('hs-console-open', function()
    hs.console.hswindow():focus()
  end)
end

init()
