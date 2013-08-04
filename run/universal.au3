; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kTimeoutCount = 2
global const $kTimeouts[$kTimeoutCount] = [ 1.5, 20 ]
global const $kTimeoutHandlers[$kTimeoutCount] = [ "OnBuffTimeout", "CustomScript" ]
global const $kIsCancelTargetMove = true
global const $kIsMultiWindow = false
global const $kIsRestEnable = true
global const $kIsMacroSearch = false

; Skills
global const $kAttackSkill = "{F2}"
global const $kSelfBuff = "{F3}"

func OnAttack()
	SendClient($kAttackSkill, 3000)
endfunc

func OnAttackSkill()
	SendClient($kAttackSkill, 3000)
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
	SendClient($kSelfBuff, 1000)
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
