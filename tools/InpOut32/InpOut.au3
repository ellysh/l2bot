#include-once

func InpOut_LogWrite($data)
	FileWrite("inpout.log", $data & chr(10))
endfunc

func _Out32($PortAddress, $data)
	DllCall("inpout32.dll", "none", "Out32", "short", $PortAddress, "short", $data)
	
	if @error <> 0 then
		InpOut_LogWrite("_Out32 - error = " & @error)
		return 0
	endif

	return 1
endfunc

func _Inp32($PortAddress)
	$result = DllCall("inpout32.dll", "short", "Inp32", "short", $PortAddress)

	if @error <> 0 then
		InpOut_LogWrite("_Inp32 - error = " & @error)
		return 0
	endif
	
	return $result[0]
endfunc

func _IsInpOutDriverOpen()
	$result = DllCall("inpout32.dll", "bool", "IsInpOutDriverOpen")
	
	if @error <> 0 then 
		InpOut_LogWrite("_IsInpOutDriverOpen - error = " & @error)
		return 0
	endif
	
	return $result[0]
endfunc
