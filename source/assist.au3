#include "analysis.au3"

func FollowLider()
	if not IsTargetExist() then
		SendTextClient("/target " & $kLeaderName)
		SendTextClient("/target " & $kLeaderName)
	endif
endfunc

func SearchTarget()
	LogWrite("SearchTarget() - assist")

	ResetTargetHealthValue()
	local $timeout = 0
	while true

		NextTarget()

		if IsTargetForAttack() then
			exitloop
		endif

		$timeout = $timeout + 1

		OnCheckHealthAndMana()

		if mod($timeout, $kAttackTimeout) == 0 and IsTargetForAttack() and not IsTargetDamaged() then		
			exitloop
		endif

		if IsTargetForAttack() then
			exitloop
		endif
		
		for $i = 0 to ubound($kTimeouts) - 1
			ProcessTimeout($i, $kTimeouts[$i] * $kMinute)
		next
	wend
endfunc
