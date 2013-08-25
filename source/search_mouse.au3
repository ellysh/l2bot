#include <ImageSearch.au3>
#include "analysis.au3"

global $kPointLeft[2] = [200, 100]
global $kPointRight[2] = [800, 500]
global $kDelta = 200

global $gSearchChecksum

func SearchInRow($y, $left, $right)
	local $window_left[2]
	local $window_right[2]
	local $x1 = 0, $y1 = 0

	for $x = $left[0] to $right[0] step 20
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
	for $y = $left[1] to $right[1] step 30
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

	while true
		local $left[2] = [$kPointLeft[0], $kPointLeft[1]]
		local $right[2] = [$left[0] + $kDelta, $left[1] + $kDelta]

		while true
			$gSearchChecksum = 0
			IsPixelsChanged($left, $right, $gSearchChecksum)
			Sleep(100)

			if IsPixelsChanged($left, $right, $gSearchChecksum) then
				SearchInRegion($left, $right)
			endif

			if IsTargetForAttack() then
				return
			endif

			if $right[0] < $kPointRight[0] then
				$left[0] = $left[0] + $kDelta
				$right[0] = $right[0] + $kDelta
			else
				if $right[1] < $kPointRight then
					$left[0] = $kPointLeft[0]
					$left[1] = $left[1] + $kDelta
					$right[0] = $left[0] + $kDelta
					$right[1] = $right[1] + $kDelta
				else
					exitloop
				endif
			endif
		wend
		
		TurnRight(7)
	wend
endfunc
