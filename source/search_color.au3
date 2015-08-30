#include "analysis.au3"
#include "FastFind.au3"

global const $kSearchRadius = 500
global const $kSearchRegionSize = 100
global const $kSearchSource[2] = [623, 371]
global const $kTargetColors[3] = [0xA4E098, 0x010202, 0xFFFBFF]

FFAddColor($kTargetColors)
; Player Area
FFAddExcludedArea(570, 290, 690, 420)
; Windows Taskbar
FFAddExcludedArea(0, 721, 1365, 767)
; Ingame Windows
FFAddExcludedArea(9, 393, 359, 709)
FFAddExcludedArea(9, 37, 181, 122)

global $gFailedTurns = 0

func CameraMove()
	if $gFailedTurns < 6 then
		TurnRight(7)
		$gFailedTurns = $gFailedTurns + 1
	else
		RandomMove()
		$gFailedTurns = 0
	endif
endfunc

func SearchTarget()
	LogWrite("SearchTarget() - color")

	local $coord[3]
	
	while true
		NextTarget()

		if IsTargetForAttack() then
			exitloop
		else
			SendClient($kCancelTarget, 500)
		endif

		$coord = FFBestSpot($kSearchRegionSize, 500, 1000, $kSearchSource[0], $kSearchSource[1], -1, 10, true)
		
		if UBound($coord) <> 0 then
			LogWrite("SearchTarget() - coord = " & $coord[0] & "x" & $coord[1])
			MouseClickClient("left", $coord[0], $coord[1])
			MoveToTarget()
			return
		else
			LogWrite("SearchTarget() - coord = NOT FOUND")
			CameraMove()
		endif
	wend
endfunc
