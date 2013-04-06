#include "../conf/interface_roulette.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kIsMultiWindow = false
global const $kRate = "1000"

; Main Loop
while true
	MouseClickClient("left", $kInputField[0], $kInputField[1])
	Sleep(1000)
	
	SendSplitText($kRate)
	
	MouseClickClient("left", $kRedButton[0], $kRedButton[1])
	Sleep(1000)
	
	MouseClickClient("left", $kBackButton[0], $kBackButton[1])
	Sleep(1000)
	exit
wend
