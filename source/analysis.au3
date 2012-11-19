func IsTargetExist()
	; Check target info window existance
	if IsPixelExistClient($gTargetWindowPos, $gTargetWindowColor) then
		LogWrite("Target exist")
		return true
	else
		LogWrite("Target not exist")
		return false
	endif
endfunc

func IsTargetAlive()
	; Check to red color in target info
	if IsPixelExistClient($gTargetWindowPos, $gTargetHealthColor) then
		LogWrite("Target alive")
		return true
	else
		LogWrite("Target not alive")
		return false
	endif
endfunc

func IsTargetPet()
	; Check to blue color in target info
	if IsPixelExistClient($gTargetWindowPos, $gTargetManaColor) then
		LogWrite("Target is pet")
		return true
	else
		LogWrite("Target is not pet")
		return false
	endif
endfunc

func SearchTarget()
	LogWrite("Search target")
	
	AttackNextTarget()
	
	LogWrite("Sit")
	SendClient($gSitKey)
	Sleep(2000)
	
	for $i = 0 to 10 step 1
		PotionHealing()

		if IsTargetInArea() then
			exitloop
		endif
		
		TurnRight(5)
	next
	
	if not IsTargetForAttack() then
		ChangePosition()
	endif
	
	LogWrite("Stand")
	SendClient($gSitKey)
	Sleep(2000)
endfunc

func IsTargetInArea()
	local $x
	local $y
	local $step = 25
	
	for $y  = $gSearchTargetArea[3] to $gSearchTargetArea[1] step -$step
		for $x = $gSearchTargetArea[0] to $gSearchTargetArea[2] step $step
			MouseClickClient("left", $x, $y)
			Sleep(20)
			if IsTargetForAttack() then
				return true
			endif
		next
		
		NextTarget()
	next
	return false
endfunc

func IsHealthCritical()
	local $color = PixelPixelGetColorClient($gSelfHealthPos)
	if $color <= $gSelfHealthColor then
		LogWrite("Health is critical, color = " & hex($color, 6))
		return true
	else
		LogWrite("Health is ok, color = " & hex($color, 6))
		return false
	endif
endfunc

func IsTargetForAttack()
	if IsTargetExist() and IsTargetAlive() and not IsTargetPet() then
		return true
	else
		return false
	endif
endfunc