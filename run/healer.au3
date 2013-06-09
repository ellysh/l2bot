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

global const $kFirstHealKey = "{F1}"
global const $kSecondHealKey = "{F2}"
global const $kThirdHealKey = "{F3}"
global const $kFourthHealKey = "{F4}"
global const $kFifthHealKey = "{F7}"
global const $kSixthHealKey = "{F8}"
global const $kSeventhHealKey = "{F9}"
global const $kEighthHealKey = "{F10}"
global const $kSelfBuff = "{F11}"
global const $kSelfBuffLong = "{F11}"


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

func IsPartyDamaged($left, $right)
	return IsBarLess($left, $right, $kPartyHealthColor, $kBarHalf)
endfunc

func HealParty($number)
	$left = Eval("k" & $number & "HealthLeft")
	$right = Eval("k" & $number & "HealthRight")
	
	if IsPartyDamaged($left, $right) then
		LogWrite("	- heal " & $number)
		$key = Eval("k" & $number & "HealthKey")
		SendClient($key, 500)
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
