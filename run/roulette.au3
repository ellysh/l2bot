#include "../conf/interface_roulette.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"

global const $kStartRate = "2000"
global const $kMaxRate = "200000"
global const $kSuccessTextColor = 0x03E903

global $gColorButton = $kRedButton
global $gRate = $kStartRate

func IsSuccess()
	return IsPixelExistClient($kRouletteWindowLeft, $kRouletteWindowRight, $kSuccessTextColor)
endfunc

func IsMaxRate()
	if Number($gRate) >= Number($kMaxRate) then
		return true
	else
		return false
	endif
endfunc

func IncreaseRate()
	local $number = Number($gRate)
	
	$gRate = String($number * 2)
endfunc

func ChangeColor()
	if $gColorButton[0] == $kRedButton[0] then
		$gColorButton = $kBlackButton
	else
		$gColorButton = $kRedButton
	endif
endfunc

; Main Loop
while true
	MouseClickClient("left", $kInputField[0], $kInputField[1])
	_Sleep(1000)
	
	SendSplitText($gRate)
	
	MouseClickClient("left", $gColorButton[0], $gColorButton[1])
	_Sleep(1000)
	
	if not IsSuccess() and not IsMaxRate() then
		IncreaseRate()
	else
		$gRate = $kStartRate
		ChangeColor()
	endif
	
	MouseClickClient("left", $kBackButton[0], $kBackButton[1])
	_Sleep(1000)
wend
