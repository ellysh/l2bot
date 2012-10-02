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
endfunc

func TurnRight()
	MouseMove($gXCenter, $gYCenter)
	MouseDown("right")
	MouseMove($gXCenter + Random(1, 10), $gYCenter)
	Sleep(100)	
	MouseUp("right")
endfunc

func TurnLeft()
	MouseMove($gXCenter, $gYCenter)
	MouseDown("right")
	MouseMove($gXCenter - Random(1, 10), $gYCenter)
	Sleep(100)	
	MouseUp("right")
endfunc

func WalkForward()
	Send("{W down}")
	Sleep(Random(2000, 8000, 1))
	Send("{W up}")
endfunc

func WalkBackward()
	Send("{S down}")
	Sleep(Random(2000, 8000, 1))
	Send("{S up}")
endfunc
