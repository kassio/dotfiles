function connectToVPN()
  hs.applescript([[
    ignoring application responses
      tell application "System Events" to tell process "GlobalProtect"
        click menu bar item 1 of menu bar 2
      end tell
    end ignoring

    tell application "System Events" to tell process "GlobalProtect"
      tell menu bar item 1 of menu bar 2
        if exists menu item "Connect to" of menu 1
          tell menu item "Connect to" of menu 1
            click
            click menu item "EMEA" of menu 1
          end tell
        end if
      end tell
    end tell
  ]])
end

function caffeinateCallback(e)
  if e == hs.caffeinate.watcher.screensDidUnlock then
    connectToVPN()
  end
end
