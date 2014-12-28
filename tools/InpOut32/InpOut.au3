#include-once

global const $kLibraryName = "inpout32.dll"
;global const $kLibraryName = "inpoutx64.dll"

func InpOut_LogWrite($data)
	FileWrite("inpout.log", $data & chr(10))
endfunc

func _Out32($PortAddress, $data)
	DllCall($kLibraryName, "none", "Out32", "short", $PortAddress, "short", $data)
	
	if @error <> 0 then
		InpOut_LogWrite("_Out32 - error = " & @error)
		return 0
	endif

	return 1
endfunc

func _Inp32($PortAddress)
	$result = DllCall($kLibraryName, "short", "Inp32", "short", $PortAddress)

	if @error <> 0 then
		InpOut_LogWrite("_Inp32 - error = " & @error)
		return 0
	endif
	
	return $result[0]
endfunc

func _IsInpOutDriverOpen()
	$result = DllCall($kLibraryName, "bool", "IsInpOutDriverOpen")
	
	if @error <> 0 then 
		InpOut_LogWrite("_IsInpOutDriverOpen - error = " & @error)
		return 0
	endif
	
	return $result[0]
endfunc
