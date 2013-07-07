#include "analysis.au3"
#include "../conf/targets.au3"

global $gTargetIndex

func SearchTarget()
	LogWrite("SearchTarget() - command")

	AttackNextTarget()

	while true
		NextTarget()
		
		OnCheckHealthAndMana()

		if $kIsMacroSearch then
			Send($kTargetNames[$gTargetIndex])
		else
			SendTextClient("/target " & $kTargetNames[$gTargetIndex])
		endif
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