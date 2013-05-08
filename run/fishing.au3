#include "../conf/control.au3"
#include "../conf/interface.au3"
#include "../conf/interface_fishing.au3"
#include "../source/hooks.au3"
#include "../source/analysis.au3"
#include "../source/debug.au3"
#include "../source/items.au3"
#include "../source/move.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $kIsMultiWindow = false
global const $kFishingKey = "{F5}"
global const $kSkillPumpKey = "{F6}"
global const $kSkillReelKey = "{F7}"
global const $kFishShotKey = "{F12}"
global const $kWeaponKey = "{F2}"
global const $kFishrodKey = "{F3}"
global const $kBaitKey = "{F4}"

global $gPrevHealth = 0


func IsFishBiting()
	if IsPixelExistClient($kFishHealthLeft, $kFishHealthRight, $kFishHealthColor) then
		LogWrite("Fish is bitting!")
		return true
	else	
		LogWrite("Fish is not bitting")
		return false
	endif
endfunc

func IsFishingFinish()
	if IsPixelExistClient($kFishingWindowLeft, $kFishingWindowRight, $kFishingColor1) _
	and IsPixelExistClient($kFishingWindowLeft, $kFishingWindowRight, $kFishingColor2) then
		LogWrite("Fishing is not finish")
		return false
	else
		LogWrite("Fishing is finish")
		return true
	endif
endfunc

func IsHealthGrow()
	local $coord = GetPixelCoordinateClient($kFishHealthLeft, $kFishHealthRight, $kFishHealthColor)
	
	if $coord[0] = $kErrorCoord then
		LogWrite("IsHealthGrow() - health bar is not exist")
		return false
	endif

	LogWrite("IsHealthGrow() - coord[0] = " & $coord[0] & " prev = " & $gPrevHealth)
	
	if $coord[0] > $gPrevHealth then
		LogWrite("IsHealthGrow() - health is grow")
		$gPrevHealth = $coord[0]
		return true	
	else
		LogWrite("IsHealthGrow() - health is not grow")
		$gPrevHealth = $coord[0]
		return false	
	endif
endfunc

func UpdatePrevHealth()
	local $coord = GetPixelCoordinateClient($kFishHealthLeft, $kFishHealthRight, $kFishHealthColor)
	
	if $coord <> false then
		$gPrevHealth = $coord[0]	
	endif
endfunc

func Fishing()
	SendClient($kFishingKey, 3000)
	
	while not IsFishBiting() and not IsFishingFinish()
		Sleep(500)
	wend
	
	UpdatePrevHealth()
	Sleep(1100)
	
	while not IsFishingFinish()
		SendClient($kFishShotKey, 0)	

		if IsHealthGrow() then
			SendClient($kSkillReelKey, 1200)
		else
			SendClient($kSkillPumpKey, 1200)
		endif

		UpdatePrevHealth()		
		
		Sleep(1100)
	wend
endfunc

func AttackLoop()
	while IsTargetAlive()
		SendClient($kAttackKey, 500)
	wend
endfunc

func Attack()
	LogWrite("Attack()")
	
	if not IsTargetForAttack() then
		return
	endif

	SendClient($kWeaponKey, 500)

	while IsTargetAlive()
		AttackLoop()
		
		SendClient($kNextTargetKey, 800)
	wend
	
	PickDrop(5)
	
	MoveBack(500)
	
	SendClient($kFishrodKey, 500)
	SendClient($kBaitKey, 500)
endfunc

; Main Loop
while true
	Attack()
	
	Fishing()
wend
