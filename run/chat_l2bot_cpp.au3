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
global const $kMessageTextEn = "Новый бот Lineage 2: фарм, рыбалка, чат, многооконность - vk.com/l2bot | play4relax.ru"
global const $kDelaySecond = 30

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

func SelectNick($number)
	local $nickname = Eval("kNickname" & $number)

	MouseClickClient("left", $nickname[0], $nickname[1])

	Sleep(500)
endfunc

func IsNickSelected()
	local $left = GetPixelCoordinateClient($kTextLeft, $kTextRight, $kTextColor)

	if $left[0] <> $kErrorCoord and $left[1] <> $kErrorCoord then
		return true
	else
		return false
	endif
endfunc

func SelectTarget()
	if not $kIsPrivateChat then
		return
	endif

	while true
		if $gCurrentNick == 3 then
			$gCurrentNick = 1
		else
			$gCurrentNick = $gCurrentNick + 1
		endif

		SelectNick($gCurrentNick)

		if IsNickSelected() then
			exitloop
		endif
	wend
endfunc

; Main Loop
while true
	SelectTarget()
	
	SendMessage()
wend
