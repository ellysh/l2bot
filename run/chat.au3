#include "../conf/control.au3"
#include "../conf/interface_chat.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kIsMultiWindow = false
; Проект бесплатного скриптового бота с открытыми исходниками
global const $kMessageTextRus = "Ghjtrn ,tcgkfnyjuj ,jnf c jnrhsnsvb bc[jlybrfvb"
global const $kMessageTextEn = "Бесплатный бот с открытым исходным кодом - http://vk.com/l2bot"
global const $kDelayMinutes = 2

global $gTextChecksum = 0

func SwitchLanguage()
	Send ("{ALTDOWN}{LSHIFT}")
	Send ("{ALTUP}")
endfunc

func SendSplitTextRus($text)
	SwitchLanguage()
	SendSplitText($text)
	SwitchLanguage()
endfunc

func SendMessage()
	SendClient($kEnterKey, 200)
	
	;SendSymbolClient("!", 20)
	
	;SendSplitTextRus($kMessageTextRus)
	
	SendSplitText($kMessageTextEn)
	
	SendClient($kEnterKey, 500)
	
	Sleep($kDelayMinutes * $kMinute)
endfunc

func IsNickSelected($number)
	local $nickname = Eval("k" & $number & "Nickname")

	MouseClickClient("left", $nickname[0], $nickname[1])
	
	Sleep(100)
	
	return IsPixelsChanged($kTextLeft, $kTextRight, $gTextChecksum)
endfunc

func SelectTarget()
	IsPixelsChanged($kTextLeft, $kTextRight, $gTextChecksum)
	
	while true
		MouseClickClient("left", $kFirstNickname[0], $kFirstNickname[1])
	
		if IsNickSelected("First") or IsNickSelected("Second") or IsNickSelected("Third") then
			exitloop
		endif
	wend
endfunc

; Main Loop
while true
	SelectTarget()
	
	SendMessage()
wend
