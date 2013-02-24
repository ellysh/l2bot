global const $kScriptFile = "script.au3"

#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

func _KeyLogger()
	FileWrite($kScriptFile, @HotKeyPressed)
	HotKeySet(@HotKeyPressed)
	Send(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, "_KeyLogger")
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), "_KeyLogger")
	next
endfunc

FileDelete($kScriptFile)

InitKeyHooks()

; Main Loop
while true
	Sleep(10)
wend
