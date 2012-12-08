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

		if IsHealthCritical() then
			OnHealthCritical()
		endif
		
		if IsHealthHalf() then
			OnHealthHalf()
		endif

		AttackNextTarget()

		if mod($timeout, 20) == 0 and IsTargetForAttack() and not IsTargetDamaged() then		
			exitloop
		endif

		if IsTargetForAttack() then
			exitloop
		endif
		
		Buff(10 * $kMinute)
	wend
endfunc