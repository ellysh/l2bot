#include "analysis.au3"
#include "../conf/targets_en.au3"

global $gTargetIndex

func SearchTarget()
	LogWrite("SearchTarget() - command")

	AttackNextTarget()

	while true
		NextTarget()
		
		if IsHealthHalf() then
			OnHealthHalf()
		endif

		SendTextClient("/target " & $kTargetNames[$gTargetIndex])
		Sleep(500)

		if $gTargetIndex == ($kTargetCount - 1) then
			$gTargetIndex = 0		
		else
			$gTargetIndex = $gTargetIndex + 1
		endif

		if IsTargetForAttack() then
			exitloop
		endif
	wend
endfunc