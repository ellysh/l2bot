; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kBuffTimeout = 16
global const $kIsCancelTargetMove = true

; Skills
global const $kAttackSkill = "{F3}"
global const $kStunSkill = "{F2}"
global const $kBuffKey = "5"
global const $kDefenseSkill = "6"

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
	SendClient($kBuffKey, 5000)
endfunc

func OnHealthCritical()
	SendClient($kDefenseSkill, 500)
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"