; Configuration
global const $kAttackSkillDelay = 6

; Skills
global const $kAttackSkill = "{F3}"
global const $kStunSkill = "{F2}"
global const $kHealSkill = "{F6}"
global const $kSelfBuff = "5"
global const $kDefenseSkill = "7"

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
	SendClient($kSelfBuff, 3000)
endfunc

func OnHealthCritical()
	SendClient($kDefenseSkill, 500)
endfunc

func OnHealthHalf()
	if not IsManaCritical() and not IsTargetForAttack() then
		LogWrite("Use heah skill")
		SendClient($kHealSkill, 8000)
	else
		PotionHealing()
	endif
endfunc