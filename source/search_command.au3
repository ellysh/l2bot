#include "analysis.au3"
#include "../conf/targets_ru.au3"

global $gTargetIndex

func SearchTarget()
	LogWrite("SearchTarget() - command")

	AttackNextTarget()

	while true
		NextTarget()
		PotionHealing()

		SendClient($kEnterKey)
		Sleep(200)
		SendTextClient("/target " & $kTargetNames[$gTargetIndex])
		Sleep(200)
		SendClient($kEnterKey)
		Sleep(500)

		if $gTargetIndex < $kTargetCount then
			$gTargetIndex = $gTargetIndex + 1
		else
			$gTargetIndex = 0
		endif

		if IsTargetForAttack() then
			exitloop
		endif
	wend
endfunc