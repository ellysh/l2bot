func Attack()
	LogWrite("Attack()")
	
	if not IsTargetForAttack() then
		return
	endif
	
	local $timeout = 0
	local $is_spoiled = false
	while IsTargetAlive()
		PotionHealing()
			
		SendClient($gAttackKey)
		Sleep(500)

		$timeout = $timeout + 1
		
		if IsTargetDamaged() and not $is_spoiled then
			SendClient($gSpoilKey)
			SendClient($gPetAttackKey)			
			$is_spoiled = true
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
	LogWrite("NextTarget()")
	SendClient($gNextTargetKey)
	Sleep(800)
endfunc

func AttackNextTarget()
	LogWrite("AttackNextTarget()")
	NextTarget()
	
	if IsTargetForAttack() then
		Attack()
	endif
endfunc
