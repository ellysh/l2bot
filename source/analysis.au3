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
