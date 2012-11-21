#include "analysis.au3"
#include "../conf/locations_ru.au3"

func SearchTarget()
	LogWrite("SearchTarget() - command")
	
	AttackNextTarget()
	
	for $i = 0 to $gTargetsCount step 1
		NextTarget()
		PotionHealing()		

		SendClient($kEnterKey)
		Sleep(500)
		SendClient("/target " & $gLocation[$i])
		SendClient($kEnterKey)
		Sleep(500)
		
		if IsTargetForAttack() then
			exitloop
		endif
	next
endfunc