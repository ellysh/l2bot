func Attack()
	LogWrite("Attack()")

	if not IsTargetForAttack() then
		return
	endif

	local $timeout = 0
	local $is_attacked = false
	while IsTargetAlive()
		$timeout = $timeout + 1
		
		if IsHealthCritical() then
			OnHealthCritical()
		endif

		SendClient($kAttackKey, 500)

		if IsTargetDamaged() and not $is_attacked then
			OnAttack()
			$is_attacked = true
		endif

		if mod($timeout, 6) == 0 and $is_attacked then
			OnAttackSkill()
		endif

		if mod($timeout, 20) == 0 and IsTargetForAttack() and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			OnAttackTimeout()
		endif
		
		ExitOnDeath()
	wend
	
	OnFirstKill()

	AttackNextTarget()
	
	OnAllKill()
endfunc

func AttackNextTarget()
	LogWrite("AttackNextTarget()")
	NextTarget()

	if IsTargetForAttack() then
		Attack()
	endif
endfunc