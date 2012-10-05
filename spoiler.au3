#include "conf/hotbar.au3"
#include "conf/interface.au3"
#include "conf/control.au3"
#include "source/motion.au3"
#include "source/hooks.au3"
#include "source/analysis.au3"
#include "source/debug.au3"
#include "source/attack.au3"

; This is needed for Windows Vista and above
#requireadmin

Sleep (3000)

; Main Loop
while 1
	;Walk()

	Attack()

	SearchTarget()
wend
