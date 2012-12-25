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
	if IsPixelExistClient($kTargetManaPos, $kTargetManaColor) _
	or IsPixelExistClient($kTargetManaPos, $kTargetManaEmptyColor) then
		LogWrite("Target is pet")
		return true
	else
		LogWrite("Target is not pet")
		return false
	endif
endfunc

func IsHealthCritical()
	local $coord = GetPixelCoordinateClient($kSelfHealthPos, $kSelfHealthColor)
	if GetBarValue($coord, $kSelfHealthPos) < 30 then
		LogWrite("Health is critical")
		return true
	else
		LogWrite("Health is not critical")
		return false
	endif
endfunc

func IsHealthHalf()
	local $coord = GetPixelCoordinateClient($kSelfHealthPos, $kSelfHealthColor)
	if GetBarValue($coord, $kSelfHealthPos) < 50 then
		LogWrite("Health is half")
		return true
	else
		LogWrite("Health is ok")
		return false
	endif
endfunc

func IsManaCritical()
	local $coord = GetPixelCoordinateClient($kSelfManaPos, $kSelfManaColor)
	if GetBarValue($coord, $kSelfManaPos) < 20 then
		LogWrite("Mana is critical")
		return true
	else
		LogWrite("Mana is ok")
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

	local $coord = GetPixelCoordinateClient($kTargetHealthPos, $kTargetHealthColor)
	if GetBarValue($coord, $kTargetHealthPos) < 95 then
		LogWrite("Target damaged")
		return true
	else
		LogWrite("Target not damaged")
		return false
	endif
endfunc

func SetControlColors($color1, $color2, $color3)
	$gMoveControlColor1 = $color1
	$gMoveControlColor2 = $color2
	$gMoveControlColor3 = $color3
endfunc

func IsPositionChanged()
	local $color1 = GetPixelColorClient($kMoveControlPos1)
	local $color2 = GetPixelColorClient($kMoveControlPos2)
	local $color3 = GetPixelColorClient($kMoveControlPos3)

	if $gMoveControlColor1 == $kEmptyColor or $gMoveControlColor2 == $kEmptyColor or $gMoveControlColor3 == $kEmptyColor then
		SetControlColors($color1, $color2, $color3)
		LogWrite("Player moving #1")
		return true
	endif
	
	if $gMoveControlColor1 == $color1 and $gMoveControlColor2 == $color2 and $gMoveControlColor3 == $color3 then
		SetControlColors($color1, $color2, $color3)	
		LogWrite("Player not moving")
		return false
	endif

	SetControlColors($color1, $color2, $color3)
	LogWrite("Player moving #2")
	return true
endfunc

func ExitOnDeath()
	local $coord = GetPixelCoordinateClient($kSelfHealthPos, $kSelfHealthColor)
	if GetBarValue($coord, $kSelfHealthPos) < 1 then
		LogWrite("Player died")
		;exit
	else
		LogWrite("Player alive")
		return false
	endif
endfunc
