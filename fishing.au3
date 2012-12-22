#include "conf/control.au3"
#include "source/hooks.au3"
#include "source/debug.au3"
#include "source/functions.au3"
#include "source/buff.au3"

global const $kBittingPos[4] = [306, 352, 387, 369]
global const $kBittingColor = 0xA59AA5	; grey

global const $kFishingWindowPos[4] = [373, 106, 490, 150]
global const $kFishingColor1 = 0x181810	; dark brown
global const $kFishingColor2 = 0x73797B	; grey

global const $kSkillWindowPos[4] = [319, 166, 350, 200]
global const $kSkillReelColor = 0x310C39	; grey

global const $kFishingKey = "{F1}"
global const $kSkillPumpKey = "{F2}"
global const $kSkillReelKey = "{F3}"

; This is needed for Windows Vista and above
#requireadmin

func IsFishBiting()
	if IsPixelExistClient($kBittingPos, $kBittingColor) then
		LogWrite("Fish is bitting!")
		return true
	else
		LogWrite("Fish not bitting")
		return false
	endif
endfunc

func IsFishingFinish()
	if not IsPixelExistClient($kFishingWindowPos, $kFishingColor1) then
		LogWrite("Fishing is finish #1")
		return false
	endif

	if not IsPixelExistClient($kFishingWindowPos, $kFishingColor2) then
		LogWrite("Fishing is finish #2")
		return false
	endif
	
	LogWrite("Fishing is not finish")
	return true
endfunc

func IsSkillReel()
	if IsPixelExistClient($kSkillWindowPos, $kSkillReelColor) then	
		LogWrite("Current skill is reel")
		return true
	else
		LogWrite("Current skill is pump")
		return false
	endif
endfunc

; Main Loop
while true
	SendClient($kFishingKey, 500)
	
	while not IsFishBiting()
		Sleep(10)
	wend
	
	while not IsFishingFinish()
		if IsSkillReel() then
			SendClient($kSkillReelKey, 500)
		else
			SendClient($kSkillPumpKey, 500)		
		endif
		
		Sleep(500)
	wend
wend
