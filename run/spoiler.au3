; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kBuffTimeout = 5
global const $kScriptTimeout = 20
global const $kIsCancelTargetMove = true
global const $kIsRestEnable = true

; Skills
global const $kSpoilKey = "{F4}"
global const $kSweeperKey = "{F7}"
global const $kStunSkill = "{F2}"
global const $kAttackSkill = "{F3}"

func OnAttack()
	SendClient($kSpoilKey, 1000)
endfunc

func OnAttackSkill()
	if not IsManaLess($kBarCritical) then
		SendClient($kAttackSkill, 1000)
	endif
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

func OnCheckHealthAndMana()
	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif
	
	if IsManaLess($kBarThird) then
		ManaPotion()
	endif
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"