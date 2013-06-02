; Configuration
global const $kAttackSkillTimeout = 10
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kTimeoutCount = 2
global const $kTimeouts[$kTimeoutCount] = [ 16, 20 ]
global const $kTimeoutHandlers[$kTimeoutCount] = [ "OnBuffTimeout", "CustomScript" ]
global const $kIsCancelTargetMove = true
global const $kIsMultiWindow = false
global const $kIsRestEnable = true

; Skills
global const $kBuffKey = "{F7}"
global const $kStunSkill = "{F2}"

func OnAttack()
	if not IsManaLess($kBarCritical) then	
		SendClient($kStunSkill, 1000)
	endif
endfunc

func OnAttackSkill()
	if not IsManaLess($kBarCritical) then
		SendClient($kStunSkill, 1000)
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
	LogWrite("OnBuffTimeout() - warcrayer")
	SendClient($kBuffKey, 20 * 1000)
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