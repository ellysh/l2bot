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
		LogWrite("Target exist")
		return true
	Else
		LogWrite("Target not exist")
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
