#include <ImageSearch.au3>

#include "analysis.au3"

func SearchTarget()
	FileChangeDir("..\source")

	LogWrite("SearchTarget() - mouse")

	AttackNextTarget()
	local $window_left[2]
	local $window_right[2]
	local $x1 = 0, $y1 = 0

	for $y = 200 to 500 step 30
		NextTarget()
		
		if IsTargetForAttack() then
			return
		endif
		
		OnCheckHealthAndMana()
		
		for $x = 500 to 700 step 20
			MouseMove($x, $y)
			Sleep(100)
			
			$window_left[0] = $x-60
			$window_left[1] = $y-60
			
			$window_right[0] = $x+60
			$window_right[1] = $y+60
		
			$result = _ImageSearch("marker.jpg", 1, $x1, $y1, 20)
			if $result = 1 then
				LogWrite("	- success")
				MouseClick("left")
				Sleep(500)
			endif
		next
	next
endfunc