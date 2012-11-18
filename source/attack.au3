func Attack()
	LogWrite("Start attack")
	
	if not IsTargetForAttack() then
		return
	endif
	
	local $timeout = 0
	while IsTargetAlive()
		PotionHealing()
			
		Send($gAttackKey)
		Sleep(500)

		$timeout = $timeout + 1
		
		if $timeout = 6 then
			Send($gSpoilKey)
			Send($gPetAttackKey)			
		endif
		
		if $timeout = 100 then
			LogWrite("Attack timeout")
			Send($gCancelTarget)
			ChangePosition()
		endif
	wend

	Send($gSweeperKey)
	Sleep(1000);

	AttackNextTarget()
	
	LogWrite("Get drop")
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("Next target")
	Send($gNextTargetKey)
	Sleep(800)
endfunc

func AttackNextTarget()
	NextTarget()
	
	if IsTargetForAttack() then
		Attack()
	endif
endfunc
