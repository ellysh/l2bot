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
		Send ("{F1}") ;Атака
		Sleep(500)
	wend
	
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
	
	LogWrite("Get drop")
	
	Send ("{F4}") ;Собрать дроп
	Sleep(4000)
EndFunc

Func Walk()

	while 1
		NextTarget()
		Sleep(1000)

		if IsTargetExist() then
			exitloop 
		endif

		if Random(0, 1, 1) = 1 then
			WalkForward()
		else
			WalkBackward()
		endif
		
		if Random(0, 1, 1) = 1 then
			TurnRight()
		else
			TurnLeft()
		endif
	wend
EndFunc

Func IsTargetExist()
	; Check target info window existance
	Local $coord = PixelSearch(548, 26, 735, 75, 0x282319)
	If Not @error Then
		;MouseClick("left", $coord[0], $coord[1])
		;MsgBox(0, "X and Y are:", $coord[0] & "," & $coord[1])
		LogWrite("Target exist")
		return true
	Else
		LogWrite("Target not exist")
		return false
	EndIf
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

Func TurnRight()
	Send("{D down}")
	Sleep(Random(200, 3000, 1))
	Send("{D up}")
EndFunc

Func TurnLeft()
	Send("{A down}")
	Sleep(Random(200, 3000, 1))
	Send("{A up}")
EndFunc

Func WalkForward()
	Send("{W down}")
	Sleep(Random(2000, 8000, 1))
	Send("{W up}")
EndFunc

Func WalkBackward()
	Send("{S down}")
	Sleep(Random(2000, 8000, 1))
	Send("{S up}")
EndFunc

func NextTarget()
	LogWrite("Next target")
	Send ("{F3}")
endfunc

func LogWrite($data)
	FileWrite($gLogFile, $data & chr(10))
endfunc