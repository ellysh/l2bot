#include "analysis.au3"

func FollowLider()
	if not IsTargetExist() then
		SendTextClient("/target " & $kLeaderName)
		SendTextClient("/target " & $kLeaderName)
	endif
endfunc

func SearchTarget()
	LogWrite("SearchTarget() - assist")

	AttackNextTarget()

	local $timeout = 0
	while true
		$timeout = $timeout + 1
		
		PotionHealing()

		AttackNextTarget()

		if mod($timeout, 18) == 0 and not IsTargetDamaged() then
			exitloop
		endif

		if IsTargetForAttack() then
			exitloop
		endif
	wend
endfunc