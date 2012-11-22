func IsTargetExist()
	; Check target info window existance
	if IsPixelExistClient($kTargetWindowPos, $kTargetWindowColor) then
		LogWrite("Target exist")
		return true
	else
		LogWrite("Target not exist")
		return false
	endif
endfunc

func IsTargetAlive()
	; Check to red color in target info
	if IsPixelExistClient($kTargetWindowPos, $kTargetHealthColor) then
		LogWrite("Target alive")
		return true
	else
		LogWrite("Target not alive")
		return false
	endif
endfunc

func IsTargetPet()
	; Check to blue color in target info
	if IsPixelExistClient($kTargetWindowPos, $kTargetManaColor) then
		LogWrite("Target is pet")
		return true
	else
		LogWrite("Target is not pet")
		return false
	endif
endfunc

func IsHealthCritical()
	local $color = PixelPixelGetColorClient($kSelfHealthPos)
	if $color <= $kSelfDamagedHealthColor then
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

func IsTargetDamaged()
	if not IsTargetExist() then
		return false
	endif

	; Check to red color in target info
	local $color = PixelPixelGetColorClient($kTargetHealthPos)
	if $color <= $kTargetDamagedHealthColor then
		LogWrite("Target damaged, color = " & hex($color, 6))
		return true
	else
		LogWrite("Target not damaged, color = " & hex($color, 6))
		return false
	endif
endfunc

func ExitOnDeath()
	if IsPixelExistClient($kCityWindowPos, $kCityColor) then
		LogWrite("Player died")
		exit
	else
		LogWrite("Player alive")
	endif
endfunc