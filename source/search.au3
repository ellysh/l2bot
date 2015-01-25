#include "analysis.au3"
#include "../conf/targets.au3"

global $gTargetIndex = 1

func SearchTarget()
	LogWrite("SearchTarget() - command")

	local $target_names = StringSplit($kTargetNames, ",")
	local $names_count = $target_names[0]

	while true
		NextTarget()

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif

		OnCheckHealthAndMana()

		if $kIsMacroSearch then
			SendClient($target_names[$gTargetIndex], 0)
		else
			SendTextClient("/target " & $target_names[$gTargetIndex])
		endif
		_Sleep(500)

		if $gTargetIndex == $names_count then
			$gTargetIndex = 1
		else
			$gTargetIndex = $gTargetIndex + 1
		endif

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif
	wend
endfunc
