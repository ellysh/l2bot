; Configuration
global const $kAttackSkillTimeout = 15
global const $kAttackTimeout = 20
global const $kBuffTimeout = 5

; Skills
global const $kSpoilKey = "1"
global const $kSweeperKey = "2"
global const $kStunSkill = "{F2}"
global const $kAttackSkill = "{F3}"

func OnAttack()
	SendClient($kSpoilKey, 1000)
	
	if not IsManaCritical() then	
		SendClient($kAttackSkill, 1000)
	endif
endfunc

func OnAttackSkill()
endfunc

func OnFirstKill()
	SendClient($kSweeperKey, 1000)
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
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"