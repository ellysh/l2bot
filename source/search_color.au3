#include "analysis.au3"

global const $kSelfLeft[2] = [650, 250]
global const $kSelfRight[2] = [750, 400]
global const $kSelfColor = 0xFBFBFB
global const $kTargetLeft[2] = [200, 0]
global const $kTargetRight[2] = [1000, 500]
global const $kTargetColors = "0xA1DA95,0xFF7779"
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

func IsSelfExist()
	LogWrite("IsSelfExist()")
	local $left[2]
	$left = GetPixelCoordinateClient($kSelfLeft, $kSelfRight, $kSelfColor)

	if not IsCoordinateCorrect($left) then
		return false
	endif

	if IsText($left) then
		return true
	else
		return false
	endif
endfunc

func MoveFromWall()
	LogWrite("MoveFromWall()")
	if not IsSelfExist() then
		LogWrite("	- moving...")
		MouseClickClient("left", $kSelfLeft[0], $kSelfLeft[1])
		Sleep(1000)
	endif
endfunc

func SearchTarget()
	LogWrite("SearchTarget() - color")

	local $left[2]
	local $target_colors = StringSplit($kTargetColors, ",")

	while true
		NextTarget()

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif

		MoveFromWall()

		for $i = 1 to $target_colors[0] step 1
			$left = GetPixelCoordinateClient($kTargetRight, $kTargetLeft, $target_colors[$i])

			if IsCoordinateCorrect($left) then
				exitloop
			endif
		next

		if not IsCoordinateCorrect($left) then
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
