#include "analysis.au3"

func SearchTarget()
	LogWrite("Search target mouse")
	
	AttackNextTarget()
	
	LogWrite("Sit")
	SendClient($gSitKey)
	Sleep(2000)
	
	for $i = 0 to 10 step 1
		PotionHealing()

		if IsTargetInArea() then
			exitloop
		endif
		
		TurnRight(5)
	next
	
	if not IsTargetForAttack() then
		ChangePosition()
	endif
	
	LogWrite("Stand")
	SendClient($gSitKey)
	Sleep(2000)
endfunc

func IsTargetInArea()
	local $x
	local $y
	local $step = 25
	
	for $y  = $gSearchTargetArea[3] to $gSearchTargetArea[1] step -$step
		for $x = $gSearchTargetArea[0] to $gSearchTargetArea[2] step $step
			MouseClickClient("left", $x, $y)
			Sleep(20)
			if IsTargetForAttack() then
				return true
			endif
		next
		
		NextTarget()
	next
	return false
endfunc