; Configuration
global const $kAttackSkillTimeout = 6
global const $kAttackTimeout = 20
global const $kMoveTimeout = 40
global const $kBuffTimeout = 1.5
global const $kIsCancelTargetMove = true
global const $kIsRestEnable = true

; Skills
global const $kAttackSkill = "{F2}"
global const $kSelfBuff = "{F7}"
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
	SendClient($kSelfBuff, 6000)
endfunc

func OnCheckHealthAndMana()
	if IsHealthLess($kBarCritical) then
		SendClient($kDefenseSkill, 1000)
	endif
	
	if IsHealthLess($kBarHalf) then
		PotionHealing()
	endif
endfunc

; This is needed for Windows Vista and above
#requireadmin

#include "../tactics/solo.au3"
