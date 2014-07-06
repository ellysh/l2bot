#include <ImageSearch.au3>
#include "analysis.au3"

global const $kPointLeft[2] = [200, 0]
global const $kPointRight[2] = [800, 300]
global const $kDeltaX = 150
global const $kDeltaY = 60
global const $kTargetColor = 0xFBFBFB

global $gSearchChecksum
global $gFailedTurns = 0

func SearchInRow($y, $left, $right)
	local $window_left[2]
	local $window_right[2]
	local $x1 = 0, $y1 = 0

	for $x = $left[0] to $right[0] step 10
		MouseMove($x, $y)
		Sleep(100)

		$window_left[0] = $x - 60
		$window_left[1] = $y - 60

		$window_right[0] = $x + 60
		$window_right[1] = $y + 60
		
		$result = _ImageSearch("marker.jpg", 0, $x1, $y1, 20)
		if $result = 1 then
			LogWrite("	- success")
			MouseClick("left")
			Sleep(500)
			return true
		endif
	next
	
	return false
endfunc

func SearchInRegion($left, $right)
	for $y = $left[1] to $right[1] step 20
		NextTarget()
		
		if IsTargetForAttack() then
			return
		endif
	
		if SearchInRow($y, $left, $right) then
			return
		endif
	next
endfunc

func CameraMove()
	if $gFailedTurns < 6 then
		TurnRight(7)
		$gFailedTurns = $gFailedTurns + 1
	else
		RandomMove()
		$gFailedTurns = 0
	endif
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

		$left = GetPixelCoordinateClient($kPointRight, $kPointLeft, $kTargetColor)

		if $left[0] == $kErrorCoord or $left[1] == $kErrorCoord then
			CameraMove()
			continueloop
		endif

		$left[0] = $left[0] - 20
		$left[1] = $left[1] + 20

		$right[0] = $left[0] + $kDeltaX
		$right[1] = $left[1] + $kDeltaY

		LogWrite("	- coord x = " & $left[0] & " coord y = " & $left[1])

		SearchInRegion($left, $right)

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif

		CameraMove()
	wend
endfunc
