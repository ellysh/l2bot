; Skills
global const $kBuffKey = "3"
global const $kAssistKey = "{F2}"

func OnAttack()
endfunc

func OnFirstKill()
	SendClient($kCancelTarget, 200)
	FollowLider()
endfunc

func OnAllKill()
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendTextClient("/target " & $kLeaderName)
	SendClient($kAssistKey, 500)
endfunc

func OnAttackTimeout()
	SendClient($kCancelTarget, 200)
	FollowLider()
endfunc

func OnBuffTimeout()
	LogWrite("OnBuffTimeout() - warcrayer")
	SendTextClient("/target " & $kLeaderName)
	SendClient($kBuffKey, 16 * 1000)
endfunc