#include "source/motion.au3"
#include "conf/keys.au3"

global $gLogFile = "debug.log"

Sleep (3000)
HotKeySet ( "{ESC}" ,"_Exit")

While 1
	Walk()
	Attack()
WEnd

Func _Exit()
    Exit
EndFunc

Func Attack()
	LogWrite("Start attack")
	
	while IsTargetAlive()
		Send ($gAttackKey)
		Sleep(500)
	wend
	
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
	
	LogWrite("Get drop")
	
	Send ($gPickDropKey)
	Sleep(4000)
EndFunc

Func IsTargetAlive()
	; Check to red color in target info
	Local $coord = PixelSearch(548, 26, 735, 75, 0x871D18)
	If Not @error Then
		LogWrite("Target alive")
		return true
	Else
		LogWrite("Target not alive")
		return false
	EndIf
EndFunc

func NextTarget()
	LogWrite("Next target")
	Send ($gNextTargetKey)
endfunc

func LogWrite($data)
	FileWrite($gLogFile, $data & chr(10))
endfunc