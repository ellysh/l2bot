global const $kEmptyColor = -1
global const $kBarFull = 98
global const $kBarHalf = 50
global const $kBarThird = 30
global const $kBarCritical = 20

global $gMoveControlColor1 = $kEmptyColor
global $gMoveControlColor2 = $kEmptyColor
global $gMoveControlColor3 = $kEmptyColor

func IsTargetExist()
	; Check target info window existance
	if IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorBrown) then
		if IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorGray) then
			LogWrite("Target exist")
			return true
		endif
	endif

	LogWrite("Target not exist")
endfunc

func IsTargetAlive()
	; Check to red color in target info
	if IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetHealthColor) then
		LogWrite("Target alive")
		return true
	else
		LogWrite("Target not alive")
		return false
	endif
endfunc

func IsTargetPet()
	; Check to blue color in target info
	if IsPixelExistClient($kTargetManaLeft, $kTargetManaRight, $kTargetManaColor) _
	or IsPixelExistClient($kTargetManaLeft, $kTargetManaRight, $kTargetManaEmptyColor) then
		LogWrite("Target is pet")
		return true
	else
		LogWrite("Target is not pet")
		return false
	endif
endfunc

func IsHealthLess($value)
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)
	if GetBarValue($coord, $kSelfHealthLeft, $kSelfHealthRight) < $value then
		LogWrite("Health < " & $value & "%")
		return true
	else
		LogWrite("Health > " & $value & "%")
		return false
	endif
endfunc

func IsManaLess($value)
	local $coord = GetPixelCoordinateClient($kSelfManaLeft, $kSelfManaRight, $kSelfManaColor)
	if GetBarValue($coord, $kSelfManaLeft, $kSelfManaRight) < $value then
		LogWrite("Mana < " & $value & "%")
		return true
	else
		LogWrite("Mana > " & $value & "%")
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

	local $coord = GetPixelCoordinateClient($kTargetHealthLeft, $kTargetHealthRight, $kTargetHealthColor)
	if GetBarValue($coord, $kTargetHealthLeft, $kTargetHealthRight) < $kBarFull then
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
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)
	if GetBarValue($coord, $kSelfHealthLeft, $kSelfHealthRight) < 1 then
		LogWrite("Player died")
		;exit
	else
		LogWrite("Player alive")
		return false
	endif
endfunc
