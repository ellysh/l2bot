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
	Send("{" & $gWalkFrontKey & " down}")
	Sleep($delay)
	Send("{" & $gWalkFrontKey & " up}")
endfunc

func WalkBack($delay)
	Send("{" & $gWalkBackKey & " down}")
	Sleep($delay)
	Send("{" & $gWalkBackKey & " up}")
endfunc

func ChangePosition()
	WalkBack(4000)
	TurnRight(5)
endfunc