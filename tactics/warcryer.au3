func OnAttack()
endfunc

func OnFirstKill()
	SendClient($kCancelTarget)
	Sleep(200)
	FollowLider()
endfunc

func OnAllKill()
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendTextClient("/target " & $kLeaderName)
	SendTextClient("/assist")
	Sleep(800)
endfunc

func OnTimeout()
endfunc