global const $kMinute = 60 * 1000

global $gLastBuffTime = TimerInit()

func Buff($timeout)
	LogWrite("Buff()")

	local $time_diff = TimerDiff($gLastBuffTime)
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $timeout)
	
	if $time_diff >= $timeout then
		OnBuffTimeout()
		$gLastBuffTime = TimerInit()
	endif
endfunc