func Attack()
	LogWrite("Attack()")

	if not IsTargetForAttack() then
		return
	endif

	local $timeout = 0
	local $is_spoiled = false
	while IsTargetAlive()
		PotionHealing()

		SendClient($kAttackKey)
		Sleep(500)

		$timeout = $timeout + 1

		if mod($timeout, 6) == 0 and not IsTargetDamaged() then
			AttackNextTarget()
			return
		endif

		if IsTargetDamaged() and not $is_spoiled then
			SendClient($kSpoilKey)
			SendClient($kPetAttackKey)
			$is_spoiled = true
		endif

		if $timeout = 20 and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			SendClient($kCancelTarget)
			ChangePosition()
		endif
	wend

	SendClient($kSweeperKey)
	Sleep(1000);

	AttackNextTarget()

	LogWrite("Get drop")
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendClient($kNextTargetKey)
	Sleep(800)
endfunc

func AttackNextTarget()
	LogWrite("AttackNextTarget()")
	NextTarget()

	if IsTargetForAttack() then
		Attack()
	endif
endfunc
