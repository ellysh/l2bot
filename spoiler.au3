#include "conf/hotbar.au3"
#include "conf/interface.au3"
#include "source/motion.au3"
#include "source/hooks.au3"
#include "source/analysis.au3"
#include "source/debug.au3"

Sleep (3000)

; Main Loop
while 1
	Walk()
	Attack()
wend

func Attack()
	LogWrite("Start attack")
	
	while IsTargetAlive()
		Send ($gAttackKey)
		Sleep(500)
	wend
	
	NextTarget()
	
	if IsTargetExist() and IsTargetAlive() then
		Attack()
	endif
	
	LogWrite("Get drop")
	
	Send ($gPickDropKey)
	Sleep(4000)
endfunc

func NextTarget()
	LogWrite("Next target")
	Send ($gNextTargetKey)
endfunc
