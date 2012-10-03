#include "conf/hotbar.au3"
#include "conf/interface.au3"
#include "source/motion.au3"
#include "source/hooks.au3"
#include "source/analysis.au3"
#include "source/debug.au3"

Sleep (3000)

; Main Loop
while 1
	;Walk()
	
	SearchTarget()
	
	Attack()
wend

func Attack()
	LogWrite("Start attack")
	
	if not IsTargetExist() then
		return
	endif
	
	while IsTargetAlive()
		Send ($gAttackKey)
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
	Send ($gNextTargetKey)
	Sleep(500)
endfunc

func PickDrop($count)
	for $i = 0 to $count step 1
		Send ($gPickDropKey)
		Sleep(300)
	next
endfunc
