global const $kTimeouts = "10,20"
global const $kTimeoutHandlers = "OnBuffTimeout,OnBuffTimeoutLong"

#include "../conf/control.au3"
#include "../conf/interface_healer.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"
#include "../source/analysis.au3"
#include "../source/debug.au3"
#include "../source/items.au3"
#include "../source/timeout.au3"

global const $kHealKey = "{F2}"
global const $kSelfBuff = "{F11}"
global const $kSelfBuffLong = "{F12}" 

global const $kPartyHealthMin = 80
global const $kHealSkillDelay = 1000

global $gLastHealed = ""

func OnBuffTimeout()
	LogWrite("OnBuffTimeout()")
	SendClient($kSelfBuff, 10 * 1000)
	FollowParty("First")
endfunc

func OnBuffTimeoutLong()
	LogWrite("OnBuffTimeout()")
	SendClient($kSelfBuffLong, 20 * 1000)
	FollowParty("First")
endfunc

func OnCheckHealthAndMana()
	LogWrite("OnCheckHealthAndMana()")
	if IsHealthLess($kBarHalf) then
		HealthPotion()
		FollowParty("First")
	endif
	
	if IsManaLess($kBarThird) then
		ManaPotion()
		FollowParty("First")
	endif
endfunc

func FollowParty($number)
	local $left = NumberToLeft($number)
	local $right = NumberToRight($number)

	MouseClickClient("left", $left[0], $left[1])
	Sleep(500)
	MouseClickClient("left", $left[0], $left[1])
	Sleep(500)
endfunc

func NumberToLeft($number)
	return Eval("k" & $number & "HealthLeft")
endfunc

func NumberToRight($number)
	return Eval("k" & $number & "HealthRight")
endfunc

func IsPartyDamaged($left, $right)
	return IsBarLess($left, $right, $kPartyHealthColor, $kPartyHealthMin)
endfunc

func HealParty($number)
	local $left = NumberToLeft($number)
	local $right = NumberToRight($number)
	
	if IsPartyDamaged($left, $right) then
		LogWrite("	- heal " & $number)
		MouseClickClient("left", $left[0], $left[1])
		Sleep(500)
		SendClient($kHealKey, $kHealSkillDelay)
		$gLastHealed = $number
	endif
endfunc

func OnPartyHeal()
	LogWrite("OnPartyHeal()")
	
	$gLastHealed = ""

	HealParty("First")
	HealParty("Second")
	HealParty("Third")
	HealParty("Fourth")
	HealParty("Fifth")
	HealParty("Sixth")
	HealParty("Seventh")
	HealParty("Eighth")
	
	if $gLastHealed <> "" then
		FollowParty($gLastHealed)
	endif
endfunc


FollowParty("First")

; Main Loop
while true
	OnCheckHealthAndMana()
	
	OnPartyHeal()
wend
