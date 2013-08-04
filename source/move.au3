global const $kXCenter = 650
global const $kYCenter = 450

func MoveToTarget()
	LogWrite("MoveToTarget()")
	
	if not IsTargetForAttack() then
		return
	endif

	if $kIsMultiWindow then
		SendClient($kAttackKey, 2000)
	else
		SendClient($kAttackKey, 500)
	endif

	if $kIsCancelTargetMove then
		SendClient($kCancelTarget, 500)	
	endif
	
	local $timeout = 0
	while not IsTargetForAttack()
		$timeout = $timeout + 1
		
		Sleep(500)
		
		if mod($timeout, 5) == 0 and not IsPositionChanged() then
			LogWrite("Move timeout #1")
			OnAttackTimeout()
			return
		endif
		
		if mod($timeout, $kMoveTimeout) == 0 then
			LogWrite("Move timeout #2")
			OnAttackTimeout()
			return
		endif
		
		NextTarget()
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

func MoveFront($delay)
	SendClient("{" & $kWalkFrontKey & " down}", $delay)
	SendClient("{" & $kWalkFrontKey & " up}", 0)
endfunc

func MoveBack($delay)
	SendClient("{" & $kWalkBackKey & " down}", $delay)
	SendClient("{" & $kWalkBackKey & " up}", 0)
endfunc

func ChangePosition()
	LogWrite("ChangePosition()")

	do 
		TurnRight(5)
		MoveBack(4000)
	until IsPositionChanged()
endfunc

func SitLoop()
	SwitchToggle(11, $kSitKey, true)
	Sleep(500)
	
	while not IsTargetForAttack() 
		if not IsHealthLess($kBarFull) and not IsManaLess($kBarFull) then
			exitloop
		endif
		
		Sleep(500)
	wend
	
	SwitchToggle(11, $kSitKey, false)
	Sleep(500)
endfunc

func Rest()
	if IsTargetForAttack() or not $kIsRestEnable then
		return
	endif

	if IsHealthLess($kBarCritical) or IsManaLess($kBarCritical) then
		LogWrite("Rest")
		SitLoop()
	endif
endfunc
