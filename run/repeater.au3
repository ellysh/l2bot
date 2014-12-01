#include <WinAPI.au3>

#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

global const $kHandler = "_KeyLogger"
global const $kCurrentWindow = WinGetHandle("")
global const $kWinClass = _WinAPI_GetClassName($kCurrentWindow)
global const $kWinList = WinList("[CLASS:" & $kWinClass & "]")
;global const $kWinList = WinList(WinGetTitle($kCurrentWindow))

LogWrite("kCurrentWindow = " & $kCurrentWindow)
LogWrite("WinGetTitle = " & WinGetTitle($kCurrentWindow))

for $i = 1 to $kWinList[0][0] step 1
	LogWrite("kWinList = " & $kWinList[$i][1])
next

func _KeyLogger()
	HotKeySet(@HotKeyPressed)
	Repeat(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, $kHandler)
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), $kHandler)
	next
	
	for $i = 0 to 12
		HotKeySet("{F" & $i & "}", $kHandler)
	next
endfunc

func SendMultiClient($key)
	for $i = 1 to $kWinList[0][0] step 1
		_SendMessage($kWinList[$i][1], 0x6, 0x1)
		Sleep(50)
		LogWrite("ControlSend() - win = " & $kWinList[$i][1])
		ControlSend($kWinList[$i][1], "", "", $key)
	next
endfunc

func Repeat($key)
	LogWrite("Repeat() - asc = " & asc($key) & " key = " & $key & @CRLF);
	SendMultiClient($key)
endfunc

InitKeyHooks()

; Main Loop
while true
	Sleep(1)
wend
