#include "../source/hooks_win.au3"
#include "../conf/interface.au3"
#include "../conf/control.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../source/items.au3"
#include "../source/attack.au3"
#include "../source/assist.au3"
#include "../source/timeout.au3"

; Team info
global const $kLeaderName = "Logis"

; Main Loop
while true
	;ExitOnDeath()

	;FollowLider()
	
	NextTarget()
	
	Sleep(1000)

	SendClient("{F1}", 1000)
	
	Sleep(2000)
	
	Buff()
wend