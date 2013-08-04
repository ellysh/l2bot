#include "../conf/control.au3"
#include "../conf/interface_chat.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kIsPrivateChat = true
; Проект бесплатного скриптового бота с открытыми исходниками
global const $kMessageTextRus = "Ghjtrn ,tcgkfnyjuj ,jnf c jnrhsnsvb bc[jlybrfvb"
global const $kMessageTextEn = "Бесплатный бот с открытым исходным кодом - http://vk.com/l2bot"
global const $kDelaySecond = 5

global $gTextChecksum = 0
global $gCurrentNick = 1

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
	
	Sleep($kDelaySecond * 1000)
endfunc

func IsNickSelected($number)
	local $nickname = Eval("kNickname" & $number)

	MouseClickClient("left", $nickname[0], $nickname[1])
	
	Sleep(500)
	
	return IsPixelsChanged($kTextLeft, $kTextRight, $gTextChecksum)
endfunc

func SelectTarget()
	if not $kIsPrivateChat then
		return
	endif

	IsPixelsChanged($kTextLeft, $kTextRight, $gTextChecksum)
	
	while true
		if $gCurrentNick == 3 then
			$gCurrentNick = 1
		else
			$gCurrentNick = $gCurrentNick + 1
		endif

		if IsNickSelected($gCurrentNick) then
			exitloop
		endif
	wend
endfunc

; Main Loop
while true
	SelectTarget()
	
	SendMessage()
wend
