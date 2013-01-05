#include "../conf/control.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../source/buff.au3"

; Проект бесплатного скриптового бота с открытыми исходниками
global const $kMessageTextRus = "Ghjtrn ,tcgkfnyjuj ,jnf c jnrhsnsvb bc[jlybrfvb"
global const $kMessageTextEn = " - http://vk.com/l2bot"
global const $kDelayMinutes = 2

; This is needed for Windows Vista and above
#requireadmin

func SendSymbolClient($key, $delay)
	LogWrite("SendSymbolClient() - " & $key)
	Send($key, 1)
	Sleep($delay)
endfunc

func SwitchLanguage()
	Send ("{CTRLDOWN}{LSHIFT}")
	Send ("{CTRLUP}")
endfunc

func SendSplitTextRus($text)
	SwitchLanguage()
	SendSplitText($text)
	SwitchLanguage()
endfunc

; Main Loop
while true

	SendClient($kEnterKey, 200)
	
	SendSymbolClient("!", 20)
	
	SendSplitTextRus($kMessageTextRus)
	
	SendSplitText($kMessageTextEn)
	
	SendClient($kEnterKey, 500)
	
	Sleep($kDelayMinutes * $kMinute)
wend
