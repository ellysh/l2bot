func Attack()
	LogWrite("Start attack")
	
	if not IsTargetExist() then
		return
	endif
	
	local $timeout = 0
	while IsTargetAlive()
		Send($gAttackKey)
		Sleep(500)
		$timeout = $timeout + 1
		
		if $timeout = 360 then
			LogWrite("Attack timeout")
			Send($gCancelTarget)
			WalkBack(6000)
		endif
	wend

	LogWrite("Get drop")
	PickDrop(4)
	
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
endfunc

func NextTarget()
	LogWrite("Next target")
	Send($gNextTargetKey)
	Sleep(200)
endfunc

func PickDrop($count)
	for $i = 0 to $count step 1
		Send($gPickDropKey)
		Sleep(300)
	next
endfunc
