func Attack()
	LogWrite("Start attack")
	
	if not IsTargetExist() or IsTargetPet() then
		return
	endif
	
	local $timeout = 0
	while IsTargetAlive()
		PotionHealing()
			
		Send($gAttackKey)
		Sleep(500)
		Send($gPetAttackKey)

		$timeout = $timeout + 1
		
		if $timeout = 6 then
			Send($gSpoilKey)
		endif
		
		if $timeout = 60 then
			LogWrite("Attack timeout")
			Send($gCancelTarget)
			WalkBack(4000)
		endif
	wend

	AttackNextTarget()
	
	LogWrite("Get drop")
	Send($gSweeperKey)
	Sleep(1000);
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("Next target")
	Send($gNextTargetKey)
	Sleep(200)
endfunc

func AttackNextTarget()
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
endfunc
