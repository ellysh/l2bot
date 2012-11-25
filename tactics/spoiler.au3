; Spoiler skills
global const $kSpoilKey = "1"
global const $kSweeperKey = "2"

; Pet
global const $kPetAttackKey = "{F2}"

func OnAttack()
	SendClient($kSpoilKey, 50)
	;SendClient($kPetAttackKey, 50)
endfunc

func OnFirstKill()
	SendClient($kSweeperKey, 1000)
endfunc

func OnAllKill()
	LogWrite("Get drop")
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendClient($kNextTargetKey, 800)
endfunc

func OnTimeout()
	SendClient($kCancelTarget, 50)
	ChangePosition()	
endfunc