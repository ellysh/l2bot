; Global hooks
HotKeySet("!{F1}" ,"_Exit")
HotKeySet("!{F5}" ,"_Start")

global $gIsStart = false

func _Exit()
    exit
endfunc

func _Start()
    $gIsStart = true
endfunc