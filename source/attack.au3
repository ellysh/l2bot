func Attack()
	LogWrite("Start attack")
	
	if not IsTargetForAttack() then
		return
	endif
	
	local $timeout = 0
	while IsTargetAlive()
		PotionHealing()
			
		SendClient($gAttackKey)
		Sleep(500)

		$timeout = $timeout + 1
		
		if $timeout = 6 then
			SendClient($gSpoilKey)
			SendClient($gPetAttackKey)			
		endif
		
		if $timeout = 100 and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			SendClient($gCancelTarget)
			ChangePosition()
		endif
	wend

	SendClient($gSweeperKey)
	Sleep(1000);

	AttackNextTarget()
	
	LogWrite("Get drop")
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("Next target")
	SendClient($gNextTargetKey)
	Sleep(800)
endfunc

func AttackNextTarget()
	NextTarget()
	
	if IsTargetForAttack() then
		Attack()
	endif
endfunc
