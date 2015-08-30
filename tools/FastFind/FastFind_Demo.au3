; Demo FastFind (officielle)
#include "FastFind.au3"
#Include <WinAPI.au3>

#RequireAdmin

global const $DEBUG_DEFAULT = 3
global const $DEBUG_GRAPHIC = $DEBUG_DEFAULT + 4
global const $WINDOW_CLASS = "Notepad" ; CLASS of the target Window
global const $WINDOW_TITLE = "" ; TITLE of the target Window

FFSetDebugMode($DEBUG_GRAPHIC) 	 ; Enable advanced (graphical) debug mode, so you will have traces + graphical feedback
FFSetDefaultSnapShot(0)

TrayTip("Démo FastFind", "F1 to detect a blue area, F2 for a black or white area, "&@LF&"F3 to bind with either a Notepad or [Active] Window, "&@LF&"F4 to bind with full screen, "&@LF&"F5 to detect changes since last capture, "&@LF&"F6 to repeatedly scan for changes, "&@LF&"ESC to exit",50000)
HotKeySet("{F1}", "DetectBleu")
HotKeySet("{F2}", "DetectBlancNoir")
HotKeySet("{F3}", "SelectWindow")
HotKeySet("{F4}", "SelectScreen")
HotKeySet("{F5}", "ShowChanges")
HotKeySet("{F6}", "PeriodicChanges")
HotKeySet("{ESC}", "TheEnd")
While (1)
	Sleep(10) ; 'til we press "Esc" to leave
Wend

; We're looking for a 43x43 area as close as possible from upper left corner (0,0), with at least 100 pixels close enough with blue (0x000000FF)
; In the first loop, we're looking for pure blue, then with each iteration, tolerancy on color increase of 5.
; We will always detect a right area, in worst case with ShadeVariation = 255 (all pixels of the screen will then meet the condition)
;
; If FFSetDebugMode = 7, the area will be surrounded with a red rectangle. 
Func DetectBleu()
	FFSetDebugMode($DEBUG_GRAPHIC)
	FFTrace(@lf&"   ** Detection of blue area"&@lf&"") ; Put this in the different debugging channels (tracer.txt, console...) as set with FFSetDebugMode
	local $ShadeVariation=0
	local $ResBleu
	do
		$ResBleu = FFNearestSpot(43, 100, 100, 100, 0x000000FF, $ShadeVariation, 0, 0, 0, 0, true) ; Force un nouveau snapShot à chaque passage (cf DetectBlancNoir pour optimisation simple possible)
		if (Not IsArray($ResBleu)) Then $ShadeVariation += 5
	until (IsArray($ResBleu) OR $ShadeVariation >250)
	if (IsArray($ResBleu)) Then
		local $sMsg = "43x43 area with 100 blue pixels found (ShadeVariation : "&$ShadeVariation&"): the corresponding spot the closest to (100,100) is in "&$ResBleu[0]&","&$ResBleu[1];
		FFTrace("   ** "&$sMsg&""&@lf&"")
		TrayTip("Area found", $sMsg, 2000)
	Else
		local $sMsg = "Not blue area found"
		FFTrace("   ** "&$sMsg&@lf&"")
		TrayTip("Not found", $sMsg, 2000)
	EndIf
EndFunc

; We're looking for a 10x10 spot close to 0,0 with only pixels either white or black (so 100 matching pixels).
;
; With FFSetDebugMode equal 7 (bit 4 is 1), the found area will be shown with a red rectangle
Func DetectBlancNoir()
	FFSetDebugMode($DEBUG_GRAPHIC)
	FFTrace(@lf&"   ** FFNearestSpot(10, 100, 0, 0, -1, 0+, 0, 0, 0, 0, true)"&@lf&"") ; Put this in the different debugging channels as set with FFSetDebugMode
	local $ShadeVariation=0
	local $ResBlancNoir
	FFResetColors() ; Rest of the list of colors
	FFAddColor(0x00FFFFFF) ; Add pure White as one of the color we're looking for
	FFAddColor(0x00000000) ; Add pure Black as one of the color we're looking for
	local $FirstLoop = true ; This will be used to optimize the processing, forcing to do a new snapshot the first but not in the next iterations, making them much faster
	do
		; [0, 0, 0, 0] => FullScreen, 10 => Size of the area to find, 100 => Number of pixels in the area, [0, 0] reference point, -1 => Use the Color list, $ShadeVariation => Tolerancy on the Color, true => Force to take a new SnapShot only on the first iteration
		$ResBlancNoir = FFNearestSpot(10, 100, 0, 0, -1, $ShadeVariation, 0, 0, 0, 0, $FirstLoop) ; Ne force pas un nouveau snapShot si il y en a déjà un
		$FirstLoop = false
		if (Not IsArray($ResBlancNoir)) Then $ShadeVariation += 2

	until (IsArray($ResBlancNoir) OR $ShadeVariation >20)
	if (IsArray($ResBlancNoir)) Then
		local $sMsg = "10x10 spot full of pixels either white or black found (with ShadeVariation of "&$ShadeVariation&"): the spot the closest from (0,0) is in "&$ResBlancNoir[0]&","&$ResBlancNoir[1];
		FFTrace("   ** "&$sMsg&""&@lf&"") ; Put this in the different debugging channels as set with FFSetDebugMode
		TrayTip("Area found", $sMsg, 2000)
	Else
		local $sMsg = "No 10x10 spot found with only white or black pixels"
		FFTrace("   ** "&$sMsg&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
		TrayTip("Not found", $sMsg, 2000)
	EndIf
EndFunc

Func SelectWindow()
	FFTrace(@lf&"   ** SelectWindow"&@lf&"") ; Put this in the different debugging channels as set with FFSetDebugMode
	local $hWnd = WinActivate("[CLASS:"&$WINDOW_CLASS&"; TITLE:"&$WINDOW_TITLE&"]", "") ; We try to find and activate the proper windows
	if $hWnd="" Then
		$hWnd = WinGetHandle("[ACTIVE]", "") ; If the proper set window can't be found, we use the current active window
	EndIf
	WinSetOnTop ( $hWnd, "", 1)

	FFSetDebugMode($DEBUG_DEFAULT)
	FFSetWnd($hWnd)
	FFSnapShot()
	TrayTip("Select Window","Title of the Window: "&WinGetTitle($hWnd)&" Class:"&_WinAPI_GetClassName($hWnd), 2000)
	FFTrace("   ** SelectWindow => Title of the Window: "&WinGetTitle($hWnd)&" Class:"&_WinAPI_GetClassName($hWnd)&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
EndFunc

; Sélectionne un écran
Func SelectScreen()
	FFTrace(@lf&"   ** SelectScreen"&@lf&"") ; Put this in the different debugging channels as set with FFSetDebugMode
	FFSetWnd(0)
	FFSnapShot()
	TrayTip("Select Screen","Select FullScreen", 2000)
EndFunc

Func ShowChanges()
	FFTrace(@lf&"   ** ShowChanges"&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
	FFSetDebugMode($DEBUG_DEFAULT) ; We keep traces in a file, but no graphical display, to avoid adding our own changes on the screen
	FFSetDefaultSnapShot(1) ; We select Slot N°1 as the default for next operations
	FFSnapShot()
	FFSetDebugMode($DEBUG_GRAPHIC)	 ; Include graphical feedback to see the area that have changed
	$Res = FFLocalizeChanges(0, 1) ; We're loonking for differences bestween SnatShot N°0 and N°1
	if @Error Then
		TrayTip("ShowChanges","No change detected",2000)
		FFTrace("   ** ShowChanges => No change detected !"&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
	Else
		TrayTip("ShowChanges","Change detected : ("&$Res[0]&","&$Res[1]&","&$Res[2]&","&$Res[3]&"), "&$Res[4]&" pixels are different",2000)
		FFTrace("   ** ShowChanges => Change detected : ("&$Res[0]&","&$Res[1]&","&$Res[2]&","&$Res[3]&"), "&$Res[4]&" pixels are different"&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
	EndIf
	FFSetDefaultSnapShot(0) ; Back on SnapShot N°0 by default for next operations	
	FFSnapShot() ; And take New SnapShot (N°0)
EndFunc

; We continuously watch changes on the screen (or selected Window, if any), showing them when any occure (Graphical debug + Tray Message)
Func PeriodicChanges()
	while 1
		FFSetDebugMode($DEBUG_DEFAULT) ; Remove graphical debug
		
		FFSetDefaultSnapShot(0) ; Take a SnapShot in slot 0
		FFSnapShot()
		
		Sleep(300)				; wait 300ms (no need to eat to much CPU), the value here should be much higher compare to the other operations in the loop (less than 100ms alltogether)
		
		FFSetDefaultSnapShot(1) ; Take a second SnapShot in slot 1
		FFSnapShot()
		
		FFSetDebugMode($DEBUG_GRAPHIC) ; Activate graphical debug to show the result
		$Res = FFLocalizeChanges(0, 1) ; Search all differences between two SnapShots
		if @Error Then
			FFTrace("   ** ShowChanges => No change detected !"&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
		Else
			TrayTip("ShowChanges","Change detected : ("&$Res[0]&","&$Res[1]&","&$Res[2]&","&$Res[3]&"), "&$Res[4]&" pixels are different",2000)
			FFTrace("   ** ShowChanges => Change detected : ("&$Res[0]&","&$Res[1]&","&$Res[2]&","&$Res[3]&"), "&$Res[4]&" pixels are different"&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
		EndIf
	Wend

EndFunc

Func TheEnd()
	FFTrace("   ** Bybye"&@lf&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
	CloseFFDll() ; Unload the DLL, free the memory, close files... makes all the cleaning. Don't use FastFind anymore after this instruction. 
	Exit
Endfunc