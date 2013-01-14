; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kBuffTimeout = 16
global const $kIsCancelTargetMove = true

; Skills
global const $kAttackSkill = "{F2}"
global const $kDefenseSkill = "6"

func OnAttack()
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
endfunc

func OnHealthCritical()
	SendClient($kDefenseSkill, 1000)
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"