global $gPrevHealth = 0

func IsHealthDecrease()
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)
	
	if $coord[0] = $kErrorCoord then
		LogWrite("IsHealthDecrease() - health bar is not exist")
		return false
	endif

	LogWrite("IsHealthDecrease() - coord[0] = " & $coord[0] & " prev = " & $gPrevHealth)
	
	if $coord[0] < $gPrevHealth then
		LogWrite("IsHealthDecrease() - health is decrease")
		$gPrevHealth = $coord[0]
		return true	
	else
		LogWrite("IsHealthDecrease() - health is not decrease")
		$gPrevHealth = $coord[0]
		return false	
	endif
endfunc

func UpdatePrevHealth()
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)
	
	if $coord <> false then
		$gPrevHealth = $coord[0]	
	endif
endfunc

func Retarget($is_attacked)
	if not $kIsCancelTargetMove and not $is_attacked and IsHealthDecrease() then
		SendClient($kCancelTarget, 200)
		NextTarget()
	endif
endfunc

func Attack()
	LogWrite("Attack()")
	
	if not IsTargetForAttack() then
		return
	endif

	UpdatePrevHealth()
					
	local $timeout = 0
	local $is_attacked = false
	while IsTargetAlive()
		$timeout = $timeout + 1
		
		OnCheckHealthAndMana()
		
		if $kIsMultiWindow then
			SendClient($kAttackKey, 2000)
		else
			SendClient($kAttackKey, 500)
		endif

		if IsTargetDamaged() and not $is_attacked then
			OnAttack()
			$is_attacked = true
		else
			Retarget($is_attacked)
		endif

		if mod($timeout, $kAttackSkillTimeout) == 0 and $is_attacked then
			OnAttackSkill()
		endif

		if mod($timeout, $kAttackTimeout) == 0 and IsTargetForAttack() and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			OnAttackTimeout()
		endif

		UpdatePrevHealth()
					
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