tell application "Ghostty"
      activate
    end tell
    tell application "System Events"
      tell process "Ghostty"
        keystroke "n" using command down
      end tell
    end tell
  end run