#include "../source/hooks.au3"

; This is needed for Windows Vista and above
#requireadmin

HotKeySet("!{F4}", "_GetCursorPos")

func _GetCursorPos()
	$coord = MouseGetPos()
	$color = PixelGetColor($coord[0], $coord[1])
	MsgBox(0, "Pixel info", "x = " & $coord[0] & " y = " & $coord[1] & " color = " & Hex($color, 6))
endfunc

; Main Loop
while true
	Sleep(1)
wend
