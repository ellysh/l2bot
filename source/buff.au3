global const $kBuffTimeout = 15 * 60 * 1000 ;ms

global $gLastBuffTime = TimerInit()

func Buff()
	LogWrite("Buff()")

	local $time_diff = TimerDiff($gLastBuffTime)
	
	LogWrite("	- time_diff = " & $time_diff & " timeout = " & $kBuffTimeout)
	
	if $time_diff >= $kBuffTimeout then
		OnBuffTimeout()
		$gLastBuffTime = TimerInit()
	endif
endfunc