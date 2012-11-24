func Attack()
	LogWrite("Attack()")

	if not IsTargetForAttack() then
		return
	endif

	local $timeout = 0
	local $is_attacked = false
	while IsTargetAlive()
		PotionHealing()

		SendClient($kAttackKey)
		Sleep(500)

		$timeout = $timeout + 1

		if IsTargetDamaged() and not $is_attacked then
			OnAttack()
			$is_attacked = true
		endif

		if mod($timeout, 18) == 0 and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			SendClient($kCancelTarget)
			ChangePosition()
		endif
		
		ExitOnDeath()
	wend
	
	OnKill()

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
