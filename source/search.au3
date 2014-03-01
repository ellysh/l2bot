#include "analysis.au3"
#include "../conf/targets.au3"

func SearchTarget()
	LogWrite("SearchTarget() - command")

	AttackNextTarget()

	local $target_names = StringSplit($kTargetNames, ",")
	local $names_count = $target_names[0]
	local $target_index = 1

	while true
		NextTarget()

		OnCheckHealthAndMana()

		if $kIsMacroSearch then
			Send($target_names[$target_index])
		else
			SendTextClient("/target " & $target_names[$target_index])
		endif
		Sleep(500)

		if $target_index == $names_count then
			$target_index = 1
		else
			$target_index = $target_index + 1
		endif

		if IsTargetForAttack() then
			exitloop
		endif
	wend
endfunc