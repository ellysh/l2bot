; Configuration
global const $kAttackSkillTimeout = 10
global const $kAttackTimeout = 20
global const $kBuffTimeout = 16

; Skills
global const $kSummonAttackKey = "{F2}"
global const $kBuffKey = "5"
global const $kSummonSkill = "6"
global const $kHealthSkill = "1"

func OnAttack()
	SendClient($kSummonAttackKey, 1000)
endfunc

func OnAttackSkill()
	SendClient($kHealthSkill, 1000)
endfunc

func OnFirstKill()
endfunc

func OnAllKill()
	SendClient($kHealthSkill, 1000)
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
	SendClient($kSummonSkill, 2000)
	SendClient($kBuffKey, 4000)
endfunc

func OnHealthCritical()
endfunc

func OnHealthHalf()
	PotionHealing()
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"