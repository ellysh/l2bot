#include "conf/control.au3"
#include "source/hooks.au3"
#include "source/debug.au3"
#include "source/functions.au3"
#include "source/buff.au3"

global const $kDelayMinutes = 3
global const $kMessageText = "Project of free Open Source bot - http://vk.com/l2bot"

; This is needed for Windows Vista and above
#requireadmin

; Main Loop
while true
	SendTextClient($kMessageText)
	
	Sleep($kDelayMinutes * $kMinute)
wend
