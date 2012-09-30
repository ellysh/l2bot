Sleep (3000)
HotKeySet ( "{ESC}" ,"_Exit")
Global $gIsTargetFind = false

While 1
	Walk()
	
	Attack()
WEnd

Func _Exit()
    Exit
EndFunc

Func Attack()
	while IsTargetAlive()
		Send ("{F1}") ;Атака
		Sleep(1000)
	wend
	
	NextTarget()
	
	if IsTargetExist() then
		Attack()
	endif
	
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
		
		Send("{W down}")
		Sleep(Random(2000, 8000, 1))
		Send("{W up}")
		
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
		;$gIsTargetFind = true
		;wMsgBox(0, "X and Y are:", $coord[0] & "," & $coord[1])
		return true
	Else
		return false
	EndIf
EndFunc

Func IsTargetAlive()
	; Check to red color in target info
	Local $coord = PixelSearch(548, 26, 735, 75, 0x871D18)
	If Not @error Then
		return true
	Else
		return false
	EndIf
EndFunc

Func TurnRight()
	Send("{D down}")
	Sleep(Random(100, 2000, 1))
	Send("{D up}")
EndFunc

Func TurnLeft()
	Send("{A down}")
	Sleep(Random(100, 2000, 1))
	Send("{A up}")
EndFunc

func NextTarget()
	Send ("{F3}")
endfunc