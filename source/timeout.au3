#include "../run/script.au3"

global const $kTimeoutsArray = StringSplit($kTimeouts, ",")
global const $kHandlersArray = StringSplit($kTimeoutHandlers, ",")
global const $kTimeoutCount = $kTimeoutsArray[0]
global $gPrevTimes[$kTimeoutCount + 1]

for $i = 1 to $kTimeoutCount
	$gPrevTimes[$i] = TimerInit()
next

func ProcessTimeout($index, $timeout)
	LogWrite("CheckTimeout() - index = " & $index)

	local $time_diff = TimerDiff($gPrevTimes[$index])
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		LogWrite("	- call " & $kHandlersArray[$index])
		Call($kHandlersArray[$index])
		$gPrevTimes[$index] = TimerInit()
	endif
endfunc
