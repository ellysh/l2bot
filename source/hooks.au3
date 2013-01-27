; Global hooks
HotKeySet("!{F1}", "_Exit")
HotKeySet("!{F2}", "_GrabWindow")
HotKeySet("{PAUSE}", "_TogglePause")

global $gIsGrab = false
Global $gIsPaused = false

func _Exit()
    exit
endfunc

func _GrabWindow()
    $gIsGrab = true
endfunc

func _TogglePause()
    $gIsPaused = not $gIsPaused
    while $gIsPaused
        sleep(10)
    wEnd
endfunc
