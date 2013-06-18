global const $kIsMultiWindow = false
global const $kTimeoutCount = 2
global const $kTimeouts[$kTimeoutCount] = [ 10, 20 ]
global const $kTimeoutHandlers[$kTimeoutCount] = [ "OnBuffTimeout", "OnBuffTimeoutLong" ]

#include "../conf/control.au3"
#include "../conf/interface_healer.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"
#include "../source/analysis.au3"
#include "../source/debug.au3"
#include "../source/items.au3"
#include "../source/timeout.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kHealKey = "{F2}"

func OnBuffTimeout()
	LogWrite("OnBuffTimeout()")
	SendClient($kSelfBuff, 10 * 1000)
endfunc

func OnBuffTimeoutLong()
	LogWrite("OnBuffTimeout()")
	SendClient($kSelfBuffLong, 20 * 1000)
endfunc

func OnCheckHealthAndMana()
	if IsHealthLess($kBarHalf) then
		HealthPotion()
	endif
	
	if IsManaLess($kBarThird) then
		ManaPotion()
	endif
endfunc

func NumberToLeft($number)
	return Eval("k" & $number & "HealthLeft")
endfunc

func NumberToRight($number)
	return Eval("k" & $number & "HealthRight")
endfunc

func IsPartyDamaged($left, $right)
	return IsBarLess($left, $right, $kPartyHealthColor, $kBarTwoThirds)
endfunc

func HealParty($number)
	local $left = NumberToLeft($number)
	local $right = NumberToRight($number)
	
	if IsPartyDamaged($left, $right) then
		LogWrite("	- heal " & $number)
		MouseClickClient("left", $left[0], $left[1])
		Sleep(500)
		SendClient($kHealKey, 500)
	endif
endfunc

func OnPartyHeal()
	LogWrite("OnPartyHeal()")

	HealParty("First")
	HealParty("Second")
	HealParty("Third")
	HealParty("Fourth")
	HealParty("Fifth")
	HealParty("Sixth")
	HealParty("Seventh")
	HealParty("Eighth")
endfunc

; Main Loop
while true
	OnCheckHealthAndMana()
	
	OnPartyHeal()
wend
