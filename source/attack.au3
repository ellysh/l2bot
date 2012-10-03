func Attack()
	LogWrite("Start attack")
	
	if not IsTargetExist() then
		return
	endif
	
	while IsTargetAlive()
		Send($gAttackKey)
		Sleep(500)
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
	Sleep(500)
endfunc

func PickDrop($count)
	for $i = 0 to $count step 1
		Send($gPickDropKey)
		Sleep(300)
	next
endfunc
