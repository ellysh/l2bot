; Spoiler skills
global const $kSpoilKey = "1"
global const $kSweeperKey = "2"

; Pet
global const $kPetAttackKey = "{F2}"

func OnAttack()
	SendClient($kSpoilKey)
	;SendClient($kPetAttackKey)
endfunc

func OnFirstKill()
	SendClient($kSweeperKey)
	Sleep(1000);
endfunc

func OnAllKill()
	LogWrite("Get drop")
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendClient($kNextTargetKey)
	Sleep(800)
endfunc

func OnTimeout()
	SendClient($kCancelTarget)
	ChangePosition()	
endfunc