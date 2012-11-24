; Spoiler skills
global const $kSpoilKey = "1"
global const $kSweeperKey = "2"

; Pet
global const $kPetAttackKey = "{F2}"

func OnAttack()
	SendClient($kSpoilKey)
	;SendClient($kPetAttackKey)
endfunc

func OnKill()
	SendClient($kSweeperKey)
	Sleep(1000);
endfunc