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