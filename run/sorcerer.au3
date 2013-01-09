; Configuration
global const $kAttackSkillTimeout = 10
global const $kAttackTimeout = 20
global const $kBuffTimeout = 16
global const $kIsCancelTargetMove = false

; Skills
global const $kBuffKey = "5"

func OnAttack()
endfunc

func OnAttackSkill()
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
	LogWrite("OnBuffTimeout()")
	SendClient($kBuffKey, 20 * 1000)
endfunc

func OnHealthCritical()
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"