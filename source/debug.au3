global $kLogFile = "..\run\debug.log"

func LogWrite($data)
	FileWrite($kLogFile, $data & chr(10))
endfunc
