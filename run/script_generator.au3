#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

global const $kScriptFile = "script.au3"
global $gCurrentTime = GetCurrentTime()

; This is needed for Windows Vista and above
#requireadmin

func _KeyLogger()
	WriteSendClient(@HotKeyPressed)
	HotKeySet(@HotKeyPressed)
	Send(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, "_KeyLogger")
endfunc

func _CustomExit()
	WriteFooter()
	exit
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), "_KeyLogger")
	next
	
	HotKeySet("!{F1}", "_CustomExit")
endfunc

func WriteHeader()
	FileWrite($kScriptFile, "func CustomScript()" & chr(10))
endfunc

func WriteFooter()
	FileWrite($kScriptFile, chr(10) & "endfunc")
endfunc

func GetCurrentTime()
	local $msec = @HOUR * 60 * 60 * 1000 + @MIN * 60 * 1000 + @SEC * 1000 + @MSEC
	
	return $msec
endfunc

func GetDelay()
	local $delay = GetCurrentTime() - $gCurrentTime
	$gCurrentTime = GetCurrentTime()
	
	return $delay
endfunc

func WriteSendClient($key)
	FileWrite($kScriptFile, '	Sleep(' & GetDelay() & ')' & @CRLF)
	
	LogWrite("asc = " & asc($key) & " key = " & $key & @CRLF);
	if asc($key) == 13 then
		$key = "{ENTER}"
	endif

	FileWrite($kScriptFile, '	SendClient("' & $key & '", 200)' & @CRLF)
endfunc

FileDelete($kScriptFile)

InitKeyHooks()

WriteHeader()

; Main Loop
while true
	Sleep(10)
wend
