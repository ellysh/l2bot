; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kTimeouts = "1,20,16,4"
global const $kTimeoutHandlers = "OnBDBuff,CustomScript,OnWarcBuff,OnWarcBuffShort"
global const $kIsCancelTargetMove = true
global const $kIsMultiWindow = true
global const $kIsRestEnable = false
global const $kIsMacroSearch = false

; Skills
global const $kAttackSkill = "{F2}"
global const $kDefenseSkill = "{F4}"

func OnAttack()
endfunc

func OnAttackSkill()
	if not IsManaLess($kBarCritical) then
		SendClient($kAttackSkill, 1000)
	endif
endfunc

func OnFirstKill()
endfunc

func OnAllKill()
	PickDrop(3)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendCurrentClient($kNextTargetKey, 800)
endfunc

func OnAttackTimeout()
	SendClient($kCancelTarget, 50)
	ChangePosition()
endfunc

func OnBDBuff()
	SendClient(1, 8000)
endfunc

func OnWarcBuff()
	SendClient(2, 20000)
endfunc

func OnWarcBuffShort()
	SendClient(3, 4000)
endfunc

func OnCheckHealthAndMana()
	if IsHealthLess($kBarCritical) then
		SendClient($kDefenseSkill, 1000)
	endif
	
	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif
	
	if IsManaLess($kBarThird) then
		ManaPotion()
	endif
endfunc

#include "../tactics/solo.au3"