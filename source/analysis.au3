global const $kEmptyColor = -1
global const $kBarFull = 95
global const $kBarHalf = 50
global const $kBarThird = 30
global const $kBarCritical = 20

global $gTargetHealthValue = 0

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

func IsBarLess($left, $right, $color, $value)
	local $coord = GetPixelCoordinateClient($left, $right, $color)
	local $bar_value = GetBarValue($coord, $left, $right)
	
	if $bar_value < -10 or $bar_value > 110 then
		LogWrite("bar undefined!")
		return false
	endif
	
	if $bar_value < $value then
		LogWrite("bar < " & $value & "%")
		return true
	else
		LogWrite("bar > " & $value & "%")
		return false
	endif
endfunc

func IsHealthLess($value)
	LogWrite("IsHealthLess()")
	return IsBarLess($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor, $value)
endfunc

func IsManaLess($value)
	LogWrite("IsManaLess()")
	return IsBarLess($kSelfManaLeft, $kSelfManaRight, $kSelfManaColor, $value)
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

	LogWrite("IsTargetDamaged()")

	local $coord = GetPixelCoordinateClient($kTargetHealthLeft, $kTargetHealthRight, $kTargetHealthColor)
	local $bar_value = GetBarValue($coord, $kTargetHealthLeft, $kTargetHealthRight)
	
	if $gTargetHealthValue == 0 then
		$gTargetHealthValue = $bar_value
	endif
	
	if $gTargetHealthValue <> $bar_value then
		LogWrite("	- target HP changed new = " & $bar_value & " old  = " & $gTargetHealthValue)	
		$gTargetHealthValue = $bar_value
		return true
	else
		LogWrite("	- same target HP = " & $bar_value)
		return false
	endif
endfunc

func ResetTargetHealthValue()
	$gTargetHealthValue = 0
endfunc

func IsPositionChanged()
	LogWrite("IsPositionChanged()")

	return IsPixelsChanged($kMapWindowLeft, $kMapWindowRight)
endfunc

func ExitOnDeath()
	LogWrite("ExitOnDeath()")
	if IsHealthLess(3) then
		LogWrite("	- player died")
		;exit
	else
		LogWrite("	- player alive")
	endif
endfunc
