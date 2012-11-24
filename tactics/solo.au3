#include "../conf/hotbar.au3"
#include "../conf/interface.au3"
#include "../conf/control.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../source/motion.au3"
#include "../source/hooks.au3"
#include "../source/search_command.au3"
#include "../source/attack.au3"
#include "../source/items.au3"

LogWrite("Window handle = " + $kWindowHandle)

; Main Loop
while true
	ExitOnDeath()
	
	Attack()

	SearchTarget()
wend
