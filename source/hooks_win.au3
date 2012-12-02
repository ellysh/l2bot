; Global hooks
HotKeySet("!{F5}" ,"_Exit")
HotKeySet("!{F6}" ,"_GrabWindow")
HotKeySet("!{F7}" ,"_Start")

global $gIsStart = false
global $gIsGrab = false

func _Exit()
    exit
endfunc

func _GrabWindow()
    $gIsGrab = true
endfunc

func _Start()
    $gIsStart = true
endfunc