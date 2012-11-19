global $gXCenter = 650
global $gYCenter = 450

func Walk()
	while 1
		NextTarget()
		Sleep(1000)

		if IsTargetExist() then
			exitloop 
		endif

		if Random(0, 1, 1) = 1 then
			WalkFront()
		else
			WalkBack()
		endif
		
		if Random(0, 1, 1) = 1 then
			TurnRight()
		else
			TurnLeft()
		endif
	wend
endfunc

func TurnRight($offset)
	MouseMove($gXCenter, $gYCenter)
	MouseDown("right")
	MouseMove($gXCenter + $offset, $gYCenter)
	Sleep(400)	
	MouseUp("right")
endfunc

func TurnLeft($offset)
	MouseMove($gXCenter, $gYCenter)
	MouseDown("right")
	MouseMove($gXCenter - $offset, $gYCenter)	
	Sleep(400)	
	MouseUp("right")
endfunc

func WalkFront($delay)
	SendClient("{" & $gWalkFrontKey & " down}")
	Sleep($delay)
	SendClient("{" & $gWalkFrontKey & " up}")
endfunc

func WalkBack($delay)
	SendClient("{" & $gWalkBackKey & " down}")
	Sleep($delay)
	SendClient("{" & $gWalkBackKey & " up}")
endfunc

func ChangePosition()
	WalkBack(4000)
	TurnRight(5)
endfunc