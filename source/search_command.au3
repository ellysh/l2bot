#include "analysis.au3"
#include "../conf/targets_ru.au3"

func SearchTarget()
	LogWrite("SearchTarget() - command")

	AttackNextTarget()

	for $i = 0 to $kTargetCount step 1
		NextTarget()
		PotionHealing()

		SendClient($kEnterKey)
		Sleep(500)
		SendTextClient("/target " & $kTargetNames[$i])
		Sleep(500)
		SendClient($kEnterKey)
		Sleep(500)

		if IsTargetForAttack() then
			exitloop
		endif
	next
endfunc