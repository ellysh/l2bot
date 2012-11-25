global $kXCenter = 650
global $kYCenter = 450

func Walk()
	while 1
		NextTarget()
		Sleep(1000)

		if IsTargetExist() then
			exitloop
		endif

		if Random(0, 1, 1) = 1 then
			WalkFront(4000)
		else
			WalkBack(4000)
		endif

		if Random(0, 1, 1) = 1 then
			TurnRight(5)
		else
			TurnLeft(5)
		endif
	wend
endfunc

func TurnRight($offset)
	MouseMove($kXCenter, $kYCenter)
	MouseDown("right")
	MouseMove($kXCenter + $offset, $kYCenter)
	Sleep(400)
	MouseUp("right")
endfunc

func TurnLeft($offset)
	MouseMove($kXCenter, $kYCenter)
	MouseDown("right")
	MouseMove($kXCenter - $offset, $kYCenter)
	Sleep(400)
	MouseUp("right")
endfunc

func WalkFront($delay)
	SendClient("{" & $kWalkFrontKey & " down}", $delay)
	SendClient("{" & $kWalkFrontKey & " up}", 0)
endfunc

func WalkBack($delay)
	SendClient("{" & $kWalkBackKey & " down}", $delay)
	SendClient("{" & $kWalkBackKey & " up}", 0)
endfunc

func ChangePosition()
	LogWrite("ChangePosition()")
	TurnRight(5)
	WalkBack(4000)
endfunc