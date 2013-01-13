#include "../source/hooks.au3"
#include "../conf/interface_highfive.au3"
#include "../conf/control.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../source/move.au3"
#include "../source/items.au3"
#include "../source/attack.au3"
#include "../source/assist.au3"
#include "../source/buff.au3"

; Team info
global const $kLeaderName = "Logis"

; Main Loop
while true
	;ExitOnDeath()

	FollowLider()

	SearchTarget()
	
	Attack()	
wend
