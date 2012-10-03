func IsTargetExist()
	; Check target info window existance
	local $coord = PixelSearch($gTargetWindowPos[0], $gTargetWindowPos[1], $gTargetWindowPos[2], $gTargetWindowPos[3], $gTargetWindowColor)
	if not @error then
		LogWrite("Target exist")
		return true
	else
		LogWrite("Target not exist")
		return false
	endif
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

func SearchTarget()
	LogWrite("Search target")
	
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
	
	Send($gSitKey)
	Sleep(2000)
	
	local $offset
	
	for $offset = 0 to 10 step 1
		if IsTargetInArea() then
			exitloop
		endif
		
		TurnRight(5)
	next
	
	Send($gSitKey)
	Sleep(2000)
endfunc

func IsTargetInArea()
	local $x
	local $y
	local $step = 30
	
	for $y  = $gSearchTargetArea[3] to $gSearchTargetArea[1] step -$step
		for $x = $gSearchTargetArea[0] to $gSearchTargetArea[2] step $step
			MouseClick("left", $x, $y, 1, 1)
			if IsTargetExist() and IsTargetAlive() then
				return true
			endif
		next
		
		NextTarget()
	next
	return false
endfunc
