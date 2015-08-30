#cs ----------------------------------------------------------------------------
 FastFind Version: 2.2
 Author:         	FastFrench
 Some Wrappers:		frank10
 AutoIt Version: 3.3.8.1

 Script Function:
	All FastFind.dll wrapper functions.
    This dll provides optimized screen processing. All actions implies at least 2 dll calls : one to copy the screen data into memory, and a second to make specific action.
	This way, you can make several actions even faster when they apply to the same screen data.

 Functions exported in FastFind.dll 1.8 are :

   	SnapShot (Makes captures of the screen, a Window - partial or full - into memory, required before using any of the following.)

	ColorPixelSearch (Search the closest pixel with a given color)
	ColorCount (Count how many pixels with a given color exist in the SnapShot.)

	HasChanged (Says if two snapshots are exactly the same or not. Usefull to check if some changes occured in a given area. )
	LocalizeChanges (Same has HasChanged, but returns precisely the smallest rectangle that includes all the changes, and the number of pixels that are different).

	GetPixel (Gives the color of a pixel in the SnapShot. Much faster than PixelGetColor if you use this a lot.)

	AddColor
	RemoveColor (Those 3 functions allow management of a list of colors, instead of using only one)
	ResetColors (Tou can have up to 1024 colors active in the list)

	AddExcludedArea (Those functions add exceptions in the processing of screen areas, with rectangles that are ignored)
	ResetExcludedAreas (You can have up to 1024 areas in the list)
	IsExcluded

	ColorsSearch (Close to ColorSearch, except that instead of a single color, all colors of the current list are in use)
	ColorsPixelSearch (Similar to ColorPixelSearch, except that instead of a single color, all colors of the current list are in use)

	ColorSearch (it's the most versatile and powerful function (in 1.3) : you can, at the same time, check for as many colors as you want,
	             with possibly a "ShadeVariation",  multiple subareas to ignore... will Find the closest spot with a all specified criteria.
				 The spot is a square area of NxN pixels with at least P pixels that are as close as allowed by ShadeVariation
				 from any of the colors in the list).

	ProgressiveSearch (new with 1.4 : similar to ColorSearch, except that if the "ideal" spot can't be found, can still search for the best spot available).

	GetLastErrorMsg
	FFVersion

	-- New in version 1.6
	SaveBMP
	SaveJPG
	GetLastFileSuffix

	KeepChanges
	KeepColor

	-- New in version 1.7
	DrawSnapShot
	FFSetPixel

	DuplicateSnapShot
	GetRawData

	-- New in version 2.0

	Function with an additionnal parameter (ShadeVariation) :
	KeepChanges
	LocalizeChanges
	HasChanged

	New functions :
	DrawSnapShotXY (same as DrawSnapShot, with specific top-left position for drawing).
	ComputeMeanValues (Gives mean Red, Green and Blue values)
	ApplyFilterOnSnapShot (apply a AND filter on each pixels in the SnapShot)
	FFGetRawData (gets direct access to all pixel data of a ScreenShot)
	
	Bug fix :
	FFColorCount with ShadeVariation

	-- 2.2

	Detects more error patterns (wrong coordinates)

#ce ----------------------------------------------------------------------------


; User global variables (can be changes by user)
global $FFDefaultSnapShot = 0 	 ; Default SnapShot Nb


global $FFDefautDebugMode = 0xE7 ; Si below to the meaning of this value. To remove all debug features (file traces, graphical feedback..., use 0 here)


; System global variables ** do not change them **
global $FFDllHandle = -1
global $FFLastSnap = 0
global const $FFNbSnapMax = 1024
global $FFLastSnapStatus[$FFNbSnapMax] ; array used to automatically make a SnapShot when needed

global const $FFCurrentVersion="2.2"

InitFFDll()



; Loading the the dll and initialisation of the wrapper
; -----------------------------------------------------
Func InitFFDll()
	for $i = 0 To $FFNbSnapMax-1
		$FFLastSnapStatus[$i] = 0
		Next
	If @AutoItX64 Then
		Global $DllName = "FastFind64.dll"
	Else
		Global $DllName = "FastFind.dll"
	Endif
		$FFDllHandle = DllOpen($DllName)
	If $FFDllHandle=-1 Then
		$FFDllHandle=$DllName
		MsgBox(0,"Error","Failed to load "&$DllName&", application probably won't properly work. "&@LF&"Check if the file "&$DllName&"is installed near this script")
		Exit(100)
		Return
	EndIf
	if ($FFCurrentVersion<>FFGetVersion()) Then
		MsgBox(0, "Error", "Wrong version of "&$DllName&". The dll is version "&FFGetVersion()&" while version "&$FFCurrentVersion&" is required.");
		Exit(101)
		EndIf
	FFSetDebugMode($FFDefautDebugMode)
EndFunc

Func CloseFFDll()
	If $FFDllHandle<>-1 Then DllClose($FFDllHandle)
EndFunc

; Determines the debugging mode.
; ------------------------------------------------- --------------------
; The 4 bits determine the channel debugging enabled, they have the following meanings:
; 0x00 = no debug
; 0x01 = Information sent to the console (RequireAdmin)
; 0x02 = debug information sent to a file (trace.txt)
; 0x04 = Graphic display of points / areas identified
; 0x08 = Display MessageBox (blocking)
; Note that in case of error, a MessageBox is displayed in the DLL if DebugMode> 0

; The following 4 bits are used to filter based on the origin of the debug message
; 0x0010 / / Excludes internal traces of the DLL
; 0x0020 / / Excludes detailed internal traces of the DLL
; 0x0040 / / Excludes external traces (those of the application)
; 0x0080 / / Error message (priority)
;
; Errors (serious) are displayed on all available channels (file, console and MessageBox) if $ DebugMode> 0
;
; Proto C function: void SetDebugMode (int NewMode)
Func FFSetDebugMode($DebugMode)
	DllCall($FFDllHandle, "none", "SetDebugMode", "int", $DebugMode)
EndFunc

; The DLL also exposes its debugging functions, allowing the AutoIt application share same traces
Func FFTrace($DebugString)
	DllCall($FFDllHandle, "none", "DebugTrace", "str", $DebugString)
EndFunc


; This function allows you to handle errors (the text appears in the logfile, the console and a MessageBox if $ DebugMode> 0)
Func FFTraceError($DebugString)
	DllCall($FFDllHandle, "none", "DebugError", "str", $DebugString)
EndFunc


; Sets the current window to use
; -----------------------------------
; By default, the entire screen is used. You can select a particular window. By default, we will always use the last Window set.
; If $WindowsHandle = 0, the entire screen : GetDesktopWindow ()
; If ClientOnly = True, then only the client part of the Window will be capturable, and coordinates will be relative to top-left
; corner of the client area (client area is the full Window except title bar, possibly menu area, borders...)
; If ClientOnly = False, then the full Window will be used.
;
; Proto C function: void SetHWnd(HWND NewWindowHandle, bool bClientArea);
Func FFSetWnd($WindowHandle, $ClientOnly=True)
	DllCall($FFDllHandle, "none", "SetHWnd", "HWND", $WindowHandle, "BOOLEAN", $ClientOnly)
EndFunc


; Choose the Default SnapShot that will by used in the next operations. This avoid to specify the number of the SnapShot every time when you always work on the same
Func FFSetDefaultSnapShot($NewSnapShot)
	$FFDefaultSnapShot = $NewSnapShot
EndFunc

; Managing the list of colors
; ================================
; When a parameter is proposed Dane Color function, the value -1 means that all colors in the list are taken into account

; Add one or more colors in the list maintained by FastFind
; Proto C function: int addColor (int newColor)
Func FFAddColor(const $NewColor)
	local $res
	if (IsArray($NewColor)) Then
		For $Color In $NewColor
			$res = DllCall($FFDllHandle, "int", "AddColor", "int", $Color)
		Next
	Else
		$res = DllCall($FFDllHandle, "int", "AddColor", "int", $NewColor)
	EndIf
	if IsArray($res) Then return $res[0]
	return $res
EndFunc

; Remove a color (if any) from the list of colors
;
; Proto C function: int RemoveColor (int newColor)
Func FFRemoveColor(const $OldColor)
	local $res = DllCall($FFDllHandle, "int", "RemoveColor", "int", $OldColor)
	if IsArray($res) Then return $res[0]
	return $res
EndFunc

; Totally Empty the list of colors
;
; Proto C function: int ResetColors ()
Func FFResetColors()
	DllCall($FFDllHandle, "none", "ResetColors")
EndFunc


; Exclusion areas management
; ==========================
; Exclusion zones can restrict searches with all functions
; Search
; It is possible to have up to 1024 rectangles of exclusion, thereby removing precisely
; Any search area. For example, with flash, the mouse cursor will usually appears on the snapshots
; (unlike cursors managed by Windows API). You can use an Exclusion rectangle established according to the position
; of the mouse so the cursor does not affect the Search results.
;
; Adds an exclusion zone
;
; Proto C function: void WINAPI AddExcludedArea (int x1, int y1, int x2, int y2)
Func FFAddExcludedArea(const $x1, const $y1, const $x2, const $y2)
	local $Res = DllCall($FFDllHandle, "int", "AddExcludedArea", "int", $x1, "int", $y1, "int", $x2, "int", $y2)
	if IsArray($res) Then return $res[0]
	return $res
EndFunc

; Clears the list of all zones
;
; Proto C function: void WINAPI ResetExcludedAreas()
Func FFResetExcludedAreas()
	DllCall($FFDllHandle, "none", "ResetExcludedAreas")
EndFunc

; Through the list of exclusion zones to determine if the point passed as a parameter is excluded or not.
;
; Proto C function: bool WINAPI IsExcluded(int x, int y, HWND hWnd)
Func FFIsExcluded(const $x, const $y, const $hWnd)
	local $Res = DllCall($FFDllHandle, "BOOLEAN", "IsExcluded", "int", $x, "int", $y, "HWND", $hWnd)
	if IsArray($res) Then return $res[0]
	return $res
EndFunc


; FFSnapShot Function - This function allows you to make a copy of the screen, window or only a part in memory
; - All other functions of FF running from memory, it should first run FFSnapShot (either explicitly or implicitly as designed within this wrapper)
; It is possible to perform several different catches and work on any thereafter.
;
; Input:
; The area to capture (in coordinates relative to the boundaries of the window if a window handle nonzero indicated) [optional, the entire screen by default]
; If the area indicated is 0,0,0,0 then this is the entire window (or screen) to be captured
; The ID to use SnapShot (optional, default to the last used, 0 initially)
; And a window handle [optional, the same screen as the previous time by default. Initially, the entire screen.]
;
; Warning: Graphic data is stored in memory, the use of this feature consumes memory. It takes about 1.8 MB of RAM to capture 800x600.
; Therefore it should preferably always reuse the same No. SnapShot. Nevertheless, it is possible to store up to 1024 screens.
;
; Return Values: If unsuccessful, returns 0 and sets @Error.
; If successful, returns 1
; Proto C function: int WINAPI SnapShot(int aLeft, int aTop, int aRight, int aBottom, int NoSnapShot)
Func FFSnapShot(const $Left=0, const $Top=0, const $Right=0, const $Bottom=0, const $NoSnapShot=$FFDefaultSnapShot, const $WindowHandle=-1)
	if ($WindowHandle <> -1) Then FFSetWnd($WindowHandle)
	$FFDefaultSnapShot = $NoSnapShot ; On mémorise le no du SnapShot utilisé, cela restera le SnapShop par défaut pour les prochains appels
	local $Res = DllCall($FFDllHandle, "int", "SnapShot", "int", $Left, "int", $Top, "int", $Right, "int", $Bottom, "int", $NoSnapShot)
	If ( ((Not IsArray($Res)) AND ($Res=0)) OR $Res[0]=0) Then
		MsgBox(0, "FFSnapShot", "SnapShot ("&$Left&","&$Top&","&$Right&","&$Bottom&","&$NoSnapShot&","&Hex($WindowHandle,8)&") failed ")
		if (IsArray($Res)) Then
			MsgBox(0, "FFSnapShot Error", "IsArray($Res):"&IsArray($Res)&" - Ubound($Res):"&UBound($Res)&" - $Res[0]:"&$Res[0])
		else
			MsgBox(0, "FFSnapShot Error", "IsArray($Res):"&IsArray($Res)&" - $Res:"&$Res)
		EndIf
		$FFLastSnapStatus[$NoSnapShot] = -1
		SetError(2)
		Return False
	EndIf
	$FFLastSnapStatus[$NoSnapShot] = 1
	$FFLastSnap  = $NoSnapShot
	Return True
EndFunc


; Internal Function, don't use it directly
Func SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle)
	; Si on impose une nouvelle capture ou si aucun SnapShot valide n'a déjà été effectué pour ce N°
	if ($ForceNewSnap OR $FFLastSnapStatus[$NoSnapShot] <> 1) Then return FFSnapShot($Left, $Top, $Right, $Bottom, $NoSnapShot, $WindowHandle)
	Return True
EndFunc

; FFNearestPixel Function - This function works like PixelSearch, except that instead of returning the first pixel found,
; it returns the closest from a given position ($PosX,$PosY)
; Return Values: If unsuccessful, returns 0 and sets @Error.
; If successful, an array of 2 elements:
;		[0] : X coordinate of the pixel found the nearest
; 		[1] : Y coordinate of the pixel
; Example: To find the pixel with color 0x00AB0C45 as close as possible from 500, 500 in full screen
;  $Res = FFNearestPixel(500, 500, 0x00AB0C45)
; If Not @Error Then MsgBox (0, "Resource", "Found in" & $PosX & "," & $PosY)
;
; Proto C function: int WINAPI ColorPixelSearch(int &XRef, int &YRef, int ColorToFind, int NoSnapShot)
Func FFNearestPixel($PosX, $PosY, $Color, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
 	;local $NoSnapShot = 2 ; Slot utilisé pour les captures d'écran (entre 0 et 3), choisi arbitrairement
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
	EndIf
	local $Result = DllCall($FFDllHandle, "int", "ColorPixelSearch", "int*", $PosX, "int*",$PosY, "int", $Color, "int", $NoSnapShot)
	If ( Not IsArray($Result) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIf
	local $CoordResult[2] = [$Result[1], $Result[2]] ; PosX, PosY
	return $CoordResult
EndFunc

; FFNearestSpot Function - This feature allows you to find, among all the area (or "spots") containing a minimum number of pixels
; a given color, the one that is closest to a reference point.
; Return Values: If unsuccessful, returns 0 and sets @Error.
; If successful, an array of 3 elements: [0] : X coordinate of the nearest spot   [1] : Y coordinate of the nearest spot   [2] : Number of pixels found in the nearest spot
; For example, suppose you want to detect a blue circle (Color = 0x000000FF) partially obscured, diameter 32 pixels (say with at least 45 pixels having the right color)
; and the closest possible to the position x = 198 and y = 543, in a full screen, so the function is called as follows:
; FFNearestSpot $Res = (32, 45, 198, 543, 0x000000FF)
; If Not @Error Then MsgBox (0, "Blue Circle", "The blue circle closest to the position 198, 543 is at "&$PosX&","&$PosY&@LF&" and contains "&$NbPixel&" blue pixels")
;
; Proto C function: int WINAPI GenericColorSearch(int SizeSearch, int &NbMatchMin, int &XRef, int &YRef, int ColorToFind, int ShadeVariation, int NoSnapShot)
Func FFNearestSpot($SizeSearch, $NbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
	EndIf
	local $Result = DllCall($FFDllHandle, "int", "GenericColorSearch", "int", $SizeSearch, "int*", $NbPixel, "int*", $PosX, "int*",$PosY, "int", $Color, "int", $ShadeVariation, "int", $NoSnapShot)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	local $CoordResult[3] = [$Result[3], $Result[4], $Result[2]] ; PosX, PoxY, Nombre de pixels
	return $CoordResult
EndFunc

; FFBestSpot Function - This feature is similar to FFNearestSpot, but even more powerful.
;    Suppose for instance that you want to find a spot with ideally 200 blue pixels in a 50x50 area, but some of those pixels may be covered, and also for transparency reasons, the color may be a bit different.
;    So, if it can't find a spot with 200 pure blue pixels, you could accept "lower" results, like only 120 blue pixels minimum, and - if enough pure blue pixels can't be found - try to find something close enough
;    with ShadeVariation.
;    FFBestSpot will do that all for you.
;    Here is how it works :
;      Only one additionnal parameters compared to FFNearestSpot : you give the minimum acceptable number of pixels to find, and then the "optimal" number. All other parameters are the same, with same meaning.
;      First, FFBestSpot will try to find if any spot exist with at least the optimal number of pixels and pure color (or colors). If yes, then it return the one that as the shorter distance with $PoxX/$PosY
;     Otherwise, it will try to find the spots that has the better number of pixels in the pure Color (or colors). If it can find a spot with at least the minimum acceptable number of pixels, then it returns this spot.
;     Otherwise, it will try again the two same searches, but now with ShadeVariation as set in the parameter (if this parameter is not 0)
;     If no proper spot can be found, returns 0 in the first element of the array and set @Error=1.
;
; Proto C function: int WINAPI ProgressiveSearch(int SizeSearch, int &NbMatchMin, int NbMatchMax, int &XRef, int &YRef, int ColorToFind/*-1 if several colors*/, int ShadeVariation, int NoSnapShot)
Func FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
		EndIf
	local $Result = DllCall($FFDllHandle, "int", "ProgressiveSearch", "int", $SizeSearch, "int*", $MinNbPixel, "int", $OptNbPixel, "int*", $PosX, "int*",$PosY, "int", $Color, "int", $ShadeVariation, "int", $NoSnapShot)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
		EndIf
	local $CoordResult[3] = [$Result[4], $Result[5], $Result[2]] ; PosX, PoxY, Nombre de pixels
	return $CoordResult
EndFunc


; FFColorCount Function - This function counts the number of pixels with the specified color, exact or approximate (ShadeVariation).
;
; Proto C  : int WINAPI ColorCount(int ColorToFind, int NoSnapShot, int ShadeVariation)
Func FFColorCount($ColorToCount, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle)  Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "int", "ColorCount", "int", $ColorToCount, "int", $NoSnapShot, "int", $ShadeVariation)
	If (Not IsArray($Result)) Then Return False
	Return $Result[0]
EndFunc

; FFIsDifferent Function - This function compares two SnapShots of the same window and return whether they have different or not .
; modified by frank10
; Proto C : int WINAPI HasChanged(int NoSnapShot, int NoSnapShot2, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **
Func FFIsDifferent($NoSnapShot1, $NoSnapShot2, $ShadeVariation=0)
	$Result = DllCall($FFDllHandle, "int", "HasChanged", "int", $NoSnapShot1, "int", $NoSnapShot2, "int", $ShadeVariation)
	If (Not IsArray($Result)) Then Return False
	Return $Result[0]
EndFunc

; FFLocalizeChanges Function - This function compares two SnapShots and specifies the number of different pixels and the smallest rectangle containing all changes.
; modified by frank10
; If unsuccessful, @Error = 1 and returns 0
; In case of differences, returns an array of 5 elements thus formed:
; [0]: left edge of the rectangle
; [1]: upper edge of the rectangle
; [2]: right edge of the rectangle
; [3]: lower edge of the rectangle
; [4]: Number of pixels that changed
; Proto C : int WINAPI LocalizeChanges(int NoSnapShot, int NoSnapShot2, int &xMin, int &yMin, int &xMax, int &yMax, int &nbFound, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **
Func FFLocalizeChanges($NoSnapShot1, $NoSnapShot2, $ShadeVariation=0)
	$Result = DllCall($FFDllHandle, "int", "LocalizeChanges", "int", $NoSnapShot1, "int", $NoSnapShot2, "int*", 0, "int*", 0, "int*", 0, "int*", 0, "int*", 0, "int" , $ShadeVariation )
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	local $TabRes[5] = 	[$Result[3], $Result[4], $Result[5], $Result[6], $Result[7]];
	Return $TabRes
EndFunc


; FFGetPixel Function - Cette fonction est close to PixelGetColor, except it works on a SnapShot.
;                       In order to make this function as fast as possible, you should explicitely make the snapshot before using it (cf benchmark.au3)
;
; Proto C : int WINAPI FFgetPixel(int X, int Y, int NoSnapShot)
Func FFGetPixel($x, $y, $NoSnapShot=$FFLastSnap)
	$Result = DllCall($FFDllHandle, "int", "FFGetPixel", "int", $x, "int", $y, "int", $NoSnapShot)
	If ( (Not IsArray($Result)) or ($Result[0]=-1) ) Then
		SetError(2)
		Return -1
	EndIf
	Return $Result[0]
EndFunc

; FFGetVersion Function - This function returns the version Nb of FastFind DLL
;
; Proto C : LPCTSTR WINAPI FFVersion(void)
Func FFGetVersion()
	$Result = DllCall($FFDllHandle, "str", "FFVersion")
	If ( (Not IsArray($Result))  ) Then
		SetError(2)
		Return "???"
	EndIf
	Return $Result[0]
EndFunc

; FFGetLastError function - This function will return the last error message, if any (won't work if all debug are disabled, as error strings won't be initialized).
;
; Proto C : LPCTSTR WINAPI GetLastErrorMsg(void)
Func FFGetLastError()
	$Result = DllCall($FFDllHandle, "str", "GetLastErrorMsg")
	If ( (Not IsArray($Result))  ) Then
		SetError(2)
		Return ""
	EndIf
	Return $Result[0]
EndFunc

global $LastFileNameParam=""

; New in version 1.6 => Save a SnapShot in a .BMP file.
; Exemple of usage: FFSaveBMP("TOTO")
Func FFSaveBMP($FileNameWithNoExtension, $ForceNewSnap=false, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
	EndIf
	local $Result = DllCall($FFDllHandle, "BOOLEAN", "SaveBMP", "int", $NoSnapShot, "str", $FileNameWithNoExtension)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIf
	local $Suffixe = DllCall($FFDllHandle, "int", "GetLastFileSuffix")
	If (IsArray($Result)) Then
		If ($Result[0]>0) Then
			$LastFileNameParam = $FileNameWithNoExtension+".BMP"
		Else
			$LastFileNameParam = $FileNameWithNoExtension+"_"+$Result[0]+".BMP"
		EndIf
	EndIf
	return true
EndFunc

; New in version 1.6 => Save a SnapShot in a JPEG file.
; Exemple of usage: FFSaveJPG("TOTO")
Func FFSaveJPG($FileNameWithNoExtension, $QualityFactor=85, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
	EndIf
	local $Result = DllCall($FFDllHandle, "BOOLEAN", "SaveJPG", "int", $NoSnapShot, "str", $FileNameWithNoExtension, "ULONG", $QualityFactor)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIf
	local $Suffixe = DllCall($FFDllHandle, "int", "GetLastFileSuffix")
	If (IsArray($Result)) Then
		If ($Result[0]>0) Then
			$LastFileNameParam = $FileNameWithNoExtension+".JPG"
		Else
			$LastFileNameParam = $FileNameWithNoExtension+"_"+$Result[0]+".JPG"
		EndIf
	EndIf
	return true
EndFunc

; Gives the FileName of the last file written with FFSaveJPG of FFSaveBMP
Func FFGetLastFileName()
	return $LastFileNameParam
EndFunc

; Change a SnapShot so that it keeps only the pixels that are different from another SnapShot.
; modified by frank10
; Exemple :
;   FFSnapShot(0, 0, 0, 0, 1) ; Takes FullScreen SnapShot N°1
;   Sleep(1000)				  ; Wait 1 second
;   FFSnapShot(0, 0, 0, 0, 2) ; Takes another SnapShot (N°2)
;   FFKeepChanges(1, 2, 8)       ; SnapShot N°1 will have all pixels black, except those that have changed between the 2 SnapShots with a shadevariation of 8. SnapShot N°2 is kept unchanged.
;   FFSaveBMP("snapshot", false, 0,0,0,0, 1) ; Saves the result into snapshot.bmp
;
;Prototype : int WINAPI KeepChanges(int NoSnapShot, int NoSnapShot2, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **
Func FFKeepChanges($NoSnapShot1, $NoSnapShot2, $ShadeVariation=0)
	$Result = DllCall($FFDllHandle, "int", "KeepChanges", "int", $NoSnapShot1, "int", $NoSnapShot2, "int", $ShadeVariation)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc

; Change a SnapShot so that it keeps only the color (or colors if a list is used) asked. All other pixels will be black.
; Exemple :
;   FFSnapShot(0, 0, 0, 0, 1) ; Takes FullScreen SnapShot N°1
;   Sleep(1000)				  ; Wait 1 second
;   FFSnapShot(0, 0, 0, 0, 2) ; Takes another SnapShot (N°2)
;   FFKeepChanges(1, 2)       ; SnapShot N°1 will have all pixels black, except those that have changed between the 2 SnapShots. SnapShot N°2 is kept unchanged.
;   FFResetColors()           ; Rest of the list of colors
;   local $Couleurs[2]=[0x00FF0000, 0x000000FF] ; Pure blue and pure red
;   FFAddColor($Couleurs)
;   FFKeepColor(-1, 60, false, 0,0,0,0, 1, -1) ;  As the SnapShot N°1 now has only very few pixels (only changes), we can now make de detection with very high ShadeVariation value
;                                              ;  After this step, the SnapShot N°1 will only have blue and red pixels left.
;Prototype : int WINAPI KeepColor(int NoSnapShot, int ColorToFind, int ShadeVariation);
Func FFKeepColor($ColorToFind, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
	if Not SnapShotPreProcessor($Left, $Top, $Right, $Bottom, $ForceNewSnap, $NoSnapShot, $WindowHandle) Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "int", "KeepColor", "int", $NoSnapShot, "int", $ColorToFind, "int", $ShadeVariation)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc

; FFDrawSnapShot will draw the SnapShot back on screen (using the same Window and same position).
; Can also be used on modified SnapShots (after use of FFsetPixel, FFKeepChanges or FFKeepColor)
; Proto C: bool WINAPI DrawSnapShot(int NoSnapShot);
Func FFDrawSnapShot($NoSnapShot=$FFLastSnap)
	if $FFLastSnapStatus[$NoSnapShot] <> 1 Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "BOOLEAN", "DrawSnapShot", "int", $NoSnapShot)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc

; FFSetPixel will change the color of a pixel in a given SnapShot
;bool WINAPI FFSetPixel(int x, int y, int Color, int NoSnapShot);
Func FFSetPixel($x, $y, $Color, $NoSnapShot=$FFLastSnap)
	if $FFLastSnapStatus[$NoSnapShot] <> 1 Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "BOOLEAN", "FFSetPixel", "int", $x, "int", $y, "int", $Color, "int", $NoSnapShot)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc

;bool WINAPI DuplicateSnapShot(int Src, int Dst);
Func FFDuplicateSnapShot($NoSnapShotSrc, $NoSnapShotDst)
	; If $NoSnapShotSrc do not exist, then make the capture
	if Not SnapShotPreProcessor(0, 0, 0, 0, false, $NoSnapShotSrc, -1) Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "BOOLEAN", "DuplicateSnapShot", "int", $NoSnapShotSrc, "int", $NoSnapShotDst)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc

; GetRawData Function - Gives RawBytes of the SnapShot
; Wrapper made by frank10
; If unsuccessful, @Error = 1 and returns 0
; Success: 	it returns a string stride with the Raw bytes of the SnapShot in 8 Hex digits (BGRA) of pixels from left to right, top to bottom
;           every pixel can be accessed like this:   StringMid($sStride, $pixelNo *8 +1  ,8)  and you get 685E5B00 68blue 5Egreen 5Bred 00alpha
;Proto C: int * WINAPI GetRawData(int NoSnapShot, int &NbBytes);
Func FFGetRawData($NoSnapShot=$FFLastSnap)
	$aResult = DllCall($FFDllHandle, "ptr", "GetRawData", "int", $NoSnapShot, "int*", 0)
	If ( Not IsArray($aResult) ) Then
		SetError(1)
		Return False
	EndIf
	Local $t_Raw  = DllStructCreate('ubyte['&  $aResult[2]  &  ']',$aResult[0])
	Local $sStride = DllStructGetData($t_Raw, 1)
	$sStride = StringRight($sStride,StringLen($sStride)-2)
	Return $sStride
EndFunc

; FFComputeMeanValues Function - Gives mean Red, Green and Blue values, useful for detecting changed areas
; Wrapper made by frank10
; If unsuccessful, @Error = 1 and returns 0
; It returns an array with:
; [0]: MeanRed
; [1]: MeanGreen
; [2]: MeanBlue
; Proto C : int WINAPI ComputeMeanValues(int NoSnapShot, int &MeanRed, int &MeanGreen, int &MeanBlue);
Func FFComputeMeanValues($NoSnapShot=$FFLastSnap)
	$aResult = DllCall($FFDllHandle, "int", "ComputeMeanValues", "int", $NoSnapShot, "int*", 0, "int*", 0, "int*", 0)
	If ( Not IsArray($aResult) OR $aResult[0]<>1) Then
		SetError(1)
		Return False
	EndIf
	local $MeanResult[3] = [$aResult[2], $aResult[3], $aResult[4]] ; MeanRed, MeanGreen, MeanBlue
	return $MeanResult
EndFunc

; FFApplyFilterOnSnapshot Function - apply an AND filter on each pixels in the SnapShot
; Wrapper made by frank10
; If unsuccessful, @Error = 1 and returns 0
; Success: It returns 1
;Proto C : int WINAPI ApplyFilterOnSnapShot(int NoSnapShot, int Red, int Green, int Blue); // ** New in version 2.0 **
Func FFApplyFilterOnSnapShot($Red, $Green, $Blue, $NoSnapShot=$FFLastSnap)
	$aResult = DllCall($FFDllHandle, "int", "ApplyFilterOnSnapShot", "int", $NoSnapShot, "int", $Red, "int", $Green, "int", $Blue)
	If ( Not IsArray($aResult) OR $aResult[0]<>1) Then
		SetError(1)
		Return False
	EndIf
	return true
EndFunc

; FFDrawSnapShotXY Function - same as DrawSnapShot, with specific top-left position for drawing
; Wrapper made by frank10
; If unsuccessful, @Error = 1 and returns 0
; Success: returns 1
;Proto C : bool WINAPI DrawSnapShotXY(int NoSnapShot, int X, int Y); // ** New in version 2.0 **
Func FFDrawSnapShotXY($iX, $iY, $NoSnapShot = $FFLastSnap)
	if $FFLastSnapStatus[$NoSnapShot] <> 1 Then
		SetError(2)
		Return False
	EndIf
	$Result = DllCall($FFDllHandle, "BOOLEAN", "DrawSnapShotXY", "int", $NoSnapShot, "int", $iX, "int", $iY)
	If ((Not IsArray($Result)) OR $Result[0]<>1) Then
		SetError(1)
		Return False
	EndIF
	Return true
EndFunc
