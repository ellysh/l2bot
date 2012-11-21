#include "analysis.au3"
#include "../conf/locations_ru.au3"

func SearchTarget()
	LogWrite("SearchTarget() - command")
	
	AttackNextTarget()
	
	for $i = 0 to $gTargetsCount step 1
		NextTarget()
		PotionHealing()		

		SendClient($kEnterKey)
		Sleep(1000)
		SendTextClient("/target " & $gLocation[$i])
		Sleep(1000)
		SendClient($kEnterKey)
		Sleep(1000)
		
		if IsTargetForAttack() then
			exitloop
		endif
	next
endfunc