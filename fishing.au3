#include "conf/control.au3"
#include "source/hooks.au3"
#include "source/debug.au3"
#include "source/functions.au3"
#include "source/buff.au3"

global const $kFishingWindowPos[4] = [373, 106, 490, 150]
global const $kFishingColor1 = 0x181810	; dark brown
global const $kFishingColor2 = 0x73797B	; grey

global const $kSkillWindowPos[4] = [319, 166, 350, 200]
global const $kSkillReelColor = 0x310C39	; dark purple
global const $kSkillPumpColor = 0x183452	; dark blue

global const $kFishingKey = "{F1}"
global const $kSkillPumpKey = "{F2}"
global const $kSkillReelKey = "{F3}"

; This is needed for Windows Vista and above
#requireadmin

func IsFishBiting()
	if IsPixelExistClient($kSkillWindowPos, $kSkillReelColor) _ 
	or IsPixelExistClient($kSkillWindowPos, $kSkillPumpColor) then
		LogWrite("Fish is bitting!")
		return true
	else	
		LogWrite("Fish not bitting")
		return false
	endif
endfunc

func IsFishingFinish()
	if IsPixelExistClient($kFishingWindowPos, $kFishingColor1) _
	and IsPixelExistClient($kFishingWindowPos, $kFishingColor2) then
		LogWrite("Fishing is not finish")
		return false
	else
		LogWrite("Fishing is finish")
		return true
	endif
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
	SendClient($kFishingKey, 3000)
	
	while not IsFishBiting() and not IsFishingFinish()
		Sleep(500)
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
