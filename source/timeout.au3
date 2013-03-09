#include "../run/script.au3"

global const $kMinute = 60 * 1000

global $gLastBuffTime = TimerInit()
global $gLastScriptTime = TimerInit()

func Buff($timeout)
	LogWrite("Buff()")

	local $time_diff = TimerDiff($gLastBuffTime)
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		OnBuffTimeout()
		$gLastBuffTime = TimerInit()
	endif
endfunc

func Script($timeout)
	LogWrite("Script()")

	local $time_diff = TimerDiff($gLastScriptfTime)
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		CustomScript()()
		$gLastScriptTime = TimerInit()
	endif
endfunc
