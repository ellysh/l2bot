; Configuration
global const $kAttackSkillTimeout = 10
global const $kAttackTimeout = 20
global const $kBuffTimeout = 16

; Skills
global const $kBuffKey = "5"
global const $kStunSkill = "{F2}"

func OnAttack()
	if not IsManaCritical() then	
		SendClient($kStunSkill, 1000)
	endif
endfunc

func OnAttackSkill()
	if not IsManaCritical() then	
		SendClient($kStunSkill, 1000)
	endif
endfunc

func OnFirstKill()
endfunc

func OnAllKill()
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendClient($kNextTargetKey, 800)
endfunc

func OnAttackTimeout()
	SendClient($kCancelTarget, 50)
	ChangePosition()
endfunc

func OnBuffTimeout()
	LogWrite("OnBuffTimeout() - warcrayer")
	SendClient($kBuffKey, 20 * 1000)
endfunc

func OnHealthCritical()
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc