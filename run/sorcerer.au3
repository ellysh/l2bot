; Configuration
global const $kAttackSkillTimeout = 3
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kBuffTimeout = 16
global const $kIsCancelTargetMove = false
global const $kIsRestEnable = true

; Skills
global const $kBuffKey = "{F7}"
global const $kAttackSkill = "{F2}"
global const $kMeleeAttackKey = "{F3}"

func OnAttack()
endfunc

func OnAttackSkill()
	SendClient($kAttackSkill, 1200)
endfunc

func OnFirstKill()
endfunc

func OnAllKill()
	SendClient($kMeleeAttackKey, 2000)
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

func OnCheckHealthAndMana()
	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif

	if IsManaLess($kBarHalf) then
		ManaPotion()
	endif
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"