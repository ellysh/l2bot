; Global hooks
HotKeySet("!{F1}" ,"_Exit")
HotKeySet("!{F2}" ,"_GrabWindow")
HotKeySet("!{F5}" ,"_Start")

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