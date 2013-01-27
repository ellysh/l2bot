#include "../conf/control.au3"
#include "../source/hooks.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../conf/interface_fishing.au3"

global const $kFishingKey = "{F1}"
global const $kSkillPumpKey = "{F2}"
global const $kSkillReelKey = "{F3}"
global const $kFishShotKey = "{F12}"

global $gPrevHealth = 0

; This is needed for Windows Vista and above
#requireadmin

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

; Main Loop
while true
	SendClient($kFishingKey, 3000)
	
	while not IsFishBiting() and not IsFishingFinish()
		Sleep(500)
	wend
	
	UpdatePrevHealth()
	Sleep(1100)
	
	while not IsFishingFinish()
		SendClient($kFishShotKey, 0)	

		if IsHealthGrow() then
			SendClient($kSkillReelKey, 600)
		else
			SendClient($kSkillPumpKey, 600)		
		endif

		UpdatePrevHealth()		
		
		Sleep(1100)
	wend
wend
