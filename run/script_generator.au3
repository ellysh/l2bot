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

func _CustomExit()
	WriteFooter()
	exit
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), "_KeyLogger")
	next
	
	HotKeySet("!{F1}", "_CustomExit")
endfunc

func WriteHeader()
	FileWrite($kScriptFile, "func CustomScript()" & chr(10))
endfunc

func WriteFooter()
	FileWrite($kScriptFile, chr(10) & "endfunc")
endfunc

FileDelete($kScriptFile)

InitKeyHooks()

WriteHeader()

; Main Loop
while true
	Sleep(10)
wend
