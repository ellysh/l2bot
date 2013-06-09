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

func OnPartyHeal()
	LogWrite("OnPartyHeal()")

	if IsPartyDamaged($kFirstHealthLeft, $kFirstHealthRight) then
		LogWrite("	- heal 1")
		SendClient($kFirstHealKey, 500)
	endif
	
	if IsPartyDamaged($kSecondHealthLeft, $kSecondHealthRight) then
		LogWrite("	- heal 2")
		SendClient($kSecondHealKey, 500)
	endif
	
	if IsPartyDamaged($kThirdHealthLeft, $kThirdHealthRight) then
		LogWrite("	- heal 3")
		SendClient($kThirdHealKey, 500)
	endif

	if IsPartyDamaged($kFourthHealthLeft, $kFourthHealthRight) then
		LogWrite("	- heal 4")
		SendClient($kFourthHealKey, 500)
	endif
	
	if IsPartyDamaged($kFifthHealthLeft, $kFifthHealthRight) then
		LogWrite("	- heal 5")
		SendClient($kFifthHealKey, 500)
	endif
	
	if IsPartyDamaged($kSixthHealthLeft, $kSixthHealthRight) then
		LogWrite("	- heal 6")
		SendClient($kSixthHealKey, 500)
	endif
	
	if IsPartyDamaged($kSeventhHealthLeft, $kSeventhHealthRight) then
		LogWrite("	- heal 7")
		SendClient($kSeventhHealKey, 500)
	endif

	if IsPartyDamaged($kEighthHealthLeft, $kEighthHealthRight) then
		LogWrite("	- heal 8")
		SendClient($kEighthHealKey, 500)
	endif
endfunc

; Main Loop
while true
	OnCheckHealthAndMana()
	
	OnPartyHeal()
wend
