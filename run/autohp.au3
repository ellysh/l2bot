#include "../conf/control.au3"
#include "../conf/interface.au3"
#include "../source/hooks.au3"
#include "../source/analysis.au3"
#include "../source/debug.au3"
#include "../source/items.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

func OnCheckHealthAndMana()
	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif
	
	if IsManaLess($kBarThird) then
		ManaPotion()
	endif
endfunc

; Main Loop
while true
	OnCheckHealthAndMana()
	
	Sleep(500)
wend
