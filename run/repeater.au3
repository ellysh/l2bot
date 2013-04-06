#include <WinAPI.au3>

#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kIsMultiWindow = true

func _KeyLogger()
	Repeat(@HotKeyPressed)
	HotKeySet(@HotKeyPressed)
	Send(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, "_KeyLogger")
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), "_KeyLogger")
	next
	
	for $i = 0 to 12
		HotKeySet("{F" & $i & "}", "_KeyLogger")
	next
endfunc

func Repeat($key)
	LogWrite("Repeat() - asc = " & asc($key) & " key = " & $key & @CRLF);

	SendClient($key, 50)
endfunc

InitKeyHooks()

; Main Loop
while true
	Sleep(10)
wend
