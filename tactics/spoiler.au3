; Skills
global const $kSpoilKey = "1"
global const $kSweeperKey = "2"

; Pet
global const $kPetAttackKey = "{F2}"

func OnAttack()
	SendClient($kSpoilKey, 50)
	;SendClient($kPetAttackKey, 50)
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
	PotionHealing()
endfunc