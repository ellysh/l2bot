global const $kEmptyColor = -1
global $gMoveControlColor1 = $kEmptyColor
global $gMoveControlColor2 = $kEmptyColor
global $gMoveControlColor3 = $kEmptyColor

func IsTargetExist()
	; Check target info window existance
	if IsPixelExistClient($kTargetWindowPos, $kTargetWindowColorBrown) then
		if IsPixelExistClient($kTargetWindowPos, $kTargetWindowColorGray) then
			LogWrite("Target exist")
			return true
		endif
	endif

	LogWrite("Target not exist")
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
	if not IsPixelExistClient($kSelfHealthMinPos, $kSelfHealthColor) then
		LogWrite("Health is critical")
		return true
	else
		LogWrite("Health is ok")
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
	if not IsTargetExist() or not IsTargetAlive() then
		return false
	endif

	; Check to red color in target info
	if not IsPixelExistClient($kTargetHealthPos, $kTargetHealthColor) then
		LogWrite("Target damaged")
		return true
	else
		LogWrite("Target not damaged")
		return false
	endif
endfunc

func IsPositionChanged()
	local $control_color1 = PixelGetColorClient($kMoveControlPos1)
	local $control_color2 = PixelGetColorClient($kMoveControlPos2)
	local $control_color3 = PixelGetColorClient($kMoveControlPos3)

	if $gMoveControlColor1 == $kEmptyColor or $gMoveControlColor2 == $kEmptyColor or $gMoveControlColor3 == $kEmptyColor then
		$gMoveControlColor1 = $control_color1
		$gMoveControlColor2 = $control_color2
		$gMoveControlColor3 = $control_color3
		return true
	endif
	
	if $gMoveControlColor1 == $control_color1 and $gMoveControlColor2 == $control_color2 and $gMoveControlColor3 == $control_color3 then
		$gMoveControlColor1 = $control_color1
		$gMoveControlColor2 = $control_color2
		$gMoveControlColor3 = $control_color3
		return false
	endif
	
	return true
endfunc

func ExitOnDeath()
	if not IsPixelExistClient($kSelfHealthEmptyPos, $kSelfHealthColor) then
		LogWrite("Player died")
		exit
	else	
		LogWrite("Player alive")
	endif
endfunc