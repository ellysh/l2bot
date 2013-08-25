#include <ImageSearch.au3>
#include "analysis.au3"

global $gXMin = 200
global $gXMax = 800
global $gYMin = 200
global $gYMax = 300

func SearchInLine($y)
	local $window_left[2]
	local $window_right[2]
	local $x1 = 0, $y1 = 0

	for $x = $gXMin to $gXMax step 30
		MouseMove($x, $y)
		Sleep(10)
		
		$window_left[0] = $x-60
		$window_left[1] = $y-60
			
		$window_right[0] = $x+60
		$window_right[1] = $y+60
		
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

func SearchTarget()
	FileChangeDir("..\source")

	LogWrite("SearchTarget() - mouse")

	AttackNextTarget()
	
	while true
		for $y = $gYMax to $gYMin step -30
			NextTarget()
		
			if IsTargetForAttack() then
				return
			endif
		
			OnCheckHealthAndMana()
			
			if SearchInLine($y) then
				return
			endif
		next
		
		TurnRight(7)
	wend
endfunc
