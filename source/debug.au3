global $gLogFile = "debug.log"

func LogWrite($data)
	FileWrite($gLogFile, $data & chr(10))
endfunc
