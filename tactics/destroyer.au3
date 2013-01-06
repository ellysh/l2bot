; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kBuffTimeout = 1.5

; Skills
global const $kAttackSkill = "{F3}"
global const $kStunSkill = "{F2}"
global const $kSelfBuff = "5"

func OnAttack()
	if not IsManaCritical() then
		SendClient($kStunSkill, 1000)
	endif
endfunc

func OnAttackSkill()
	if not IsManaCritical() then
		SendClient($kAttackSkill, 1000)
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
	SendClient($kSelfBuff, 1000)
endfunc

func OnHealthCritical()
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc