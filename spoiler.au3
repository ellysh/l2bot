#include "conf/hotbar.au3"
#include "conf/interface.au3"
#include "source/motion.au3"

global $gLogFile = "debug.log"

Sleep (3000)
HotKeySet ( "{ESC}" ,"_Exit")

while 1
	Walk()
	Attack()
wend

func _Exit()
    exit
endfunc

func Attack()
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
endfunc

func IsTargetAlive()
	; Check to red color in target info
	local $coord = PixelSearch($gTargetWindowPos[0], $gTargetWindowPos[1], $gTargetWindowPos[2], $gTargetWindowPos[3], $gHealthColor)
	if not @error then
		LogWrite("Target alive")
		return true
	else
		LogWrite("Target not alive")
		return false
	endif
endfunc

func NextTarget()
	LogWrite("Next target")
	Send ($gNextTargetKey)
endfunc

func LogWrite($data)
	FileWrite($gLogFile, $data & chr(10))
endfunc