#include "../run/script.au3"

global const $kMinute = 60 * 1000

global $gLastBuffTimes[$kBuffCount]
global $gLastScriptTime = TimerInit()


for $i = 0 to UBound($gLastBuffTimes) - 1
	$gLastBuffTimes[$i] = TimerInit()
next

func Buff($index, $timeout)
	LogWrite("Buff()")

	local $time_diff = TimerDiff($gLastBuffTimes[$index])
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		Call($kBuffHandlers[$index])
		$gLastBuffTimes[$index] = TimerInit()
	endif
endfunc

func Script($timeout)
	LogWrite("Script()")

	local $time_diff = TimerDiff($gLastScriptTime)
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		LogWrite("	- call CustomScript()")
		CustomScript()
		$gLastScriptTime = TimerInit()
	endif
endfunc
