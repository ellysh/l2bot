#include <ImageSearch.au3>
#include "analysis.au3"

global const $kPointLeft[2] = [200, 0]
global const $kPointRight[2] = [800, 300]
global const $kTargetColor = 0xFBFBFB
global const $kTextColor = 0x000000

global $gFailedTurns = 0

func CameraMove()
	if $gFailedTurns < 6 then
		TurnRight(7)
		$gFailedTurns = $gFailedTurns + 1
	else
		RandomMove()
		$gFailedTurns = 0
	endif
endfunc

func IsText($left)
	local $right[2]
	
	$right[0] = $left[0] + 30
	$right[1] = $left[1] + 30
	
	return IsPixelExistClient($left, $right, $kTextColor)
endfunc

func SearchTarget()
	FileChangeDir("..\source")

	LogWrite("SearchTarget() - mouse")

	local $left[2]
	local $right[2]

	while true
		NextTarget()

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif

		$left = GetPixelCoordinateClient($kPointLeft, $kPointRight, $kTargetColor)

		if $left[0] == $kErrorCoord or $left[1] == $kErrorCoord then
			CameraMove()
			continueloop
		endif
		
		if IsText($left) then
			MouseClickClient("left", $left[0], $left[1])
			exitloop
		else
			CameraMove()
		endif
	wend
endfunc
