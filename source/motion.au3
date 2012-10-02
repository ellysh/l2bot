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
	Send("{D down}")
	Sleep(Random(200, 3000, 1))
	Send("{D up}")
endfunc

func TurnLeft()
	Send("{A down}")
	Sleep(Random(200, 3000, 1))
	Send("{A up}")
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
