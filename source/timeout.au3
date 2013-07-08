#include "../run/script.au3"

global $gPrevTimes[$kTimeoutCount]

for $i = 0 to UBound($gPrevTimes) - 1
	$gPrevTimes[$i] = TimerInit()
next

func ProcessTimeout($index, $timeout)
	LogWrite("CheckTimeout() - index = " & $index)

	local $time_diff = TimerDiff($gPrevTimes[$index])
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		LogWrite("	- call " & $kTimeoutHandlers[$index])
		Call($kTimeoutHandlers[$index])
		$gPrevTimes[$index] = TimerInit()
	endif
endfunc
