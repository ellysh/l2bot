; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kBuffTimeout = 1

; Skills
global const $kAttackSkill = "{F3}"
global const $kSonicSkill = "{F2}"
global const $kSelfBuff = "5"
global const $kFocusSkill = "2"

func OnAttack()
	if not IsManaCritical() then
		SendClient($kSonicSkill, 1000)
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
	
	SendClient($kFocusSkill, 2000)
	SendClient($kFocusSkill, 1000)	
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

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"
