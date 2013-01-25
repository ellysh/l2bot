; Global hooks
HotKeySet("!{F1}", "_Exit")
HotKeySet("!{F2}", "_GrabWindow")

global $gIsGrab = false

func _Exit()
    exit
endfunc

func _GrabWindow()
    $gIsGrab = true
endfunc