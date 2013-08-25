#include <ImageSearch.au3>
#include "analysis.au3"

global $kPointLeft[2] = [200, 0]
global $kPointRight[2] = [800, 300]
global $kDelta = 100

global $gSearchChecksum

func SearchInRow($y, $left, $right)
	local $window_left[2]
	local $window_right[2]
	local $x1 = 0, $y1 = 0

	for $x = $left[0] to $right[0] step 15
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

func SearchTarget()
	FileChangeDir("..\source")

	LogWrite("SearchTarget() - mouse")

	AttackNextTarget()

	local $left[2]
	local $right[2]

	while true
		$left = GetPixelCoordinateClient($kPointRight, $kPointLeft, 0xFBFBFB)

		$left[0] = $left[0] - 20
		$left[1] = $left[1] + 20

		$right[0] = $left[0] + $kDelta
		$right[1] = $left[1] + $kDelta

		LogWrite("	- coord x = " & $left[0] & " coord y = " & $left[1])

		SearchInRegion($left, $right)

		if IsTargetForAttack() then
			return
		endif

		TurnRight(7)
	wend
endfunc
