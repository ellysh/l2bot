; Configuration
global const $kAttackSkillDelay = 15
global const $kBuffTimeout = 5

; Skills
global const $kBuffKey = "5"
global const $kAssistKey = "{F11}"
global const $kStunSkill = "{F2}"

func OnAttack()
	if not IsManaCritical() then	
		SendClient($kStunSkill, 1000)
	endif
endfunc

func OnAttackSkill()
endfunc

func OnFirstKill()
	SendClient($kCancelTarget, 200)
	FollowLider()
endfunc

func OnAllKill()
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendTextClient("/target " & $kLeaderName)
	SendClient($kAssistKey, 1000)
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