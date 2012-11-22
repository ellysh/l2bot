#include "analysis.au3"

func SearchTarget()
	LogWrite("SearchTarget() - mouse")

	AttackNextTarget()

	LogWrite("Sit")
	SendClient($kSitKey)
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
	SendClient($kSitKey)
	Sleep(2000)
endfunc

func IsTargetInArea()
	local $x
	local $y
	local $step = 25

	for $y  = $kSearchTargetArea[3] to $kSearchTargetArea[1] step -$step
		for $x = $kSearchTargetArea[0] to $kSearchTargetArea[2] step $step
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