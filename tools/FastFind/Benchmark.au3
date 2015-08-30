 #cs ----------------------------------------------------------------------------
 FastFind Version: 1.8
 AutoIt Version: 3.3.6.1
 Author:         FastFrench

 Script Function:
	FastFind simple Benchmark.

#ce ----------------------------------------------------------------------------

#include "FastFind.au3"

; In order to acheive full possible speed, I disable all debug features
;FFSetDebugMode(0) 

; Use Native Pixelgetcolor() on 100 different points

ProgressOn ( "FastFind Benchmark", "Running...", "Native PixelGetcolor")
$begin = TimerInit()
for $x = 1 to 100
  $a = PixelGetcolor($x, 500);
 Next
$dif = TimerDiff($begin)

ProgressSet(10, "Native PixelSearch")
; Use Native PixelSearch() on FullScreen (1920x1080) x 100 with ShadeVariation
$begin1 = TimerInit()
for $x = 1 to 100
  $a = PixelSearch(0,0,1919,1079, 0x00FF5511, 2);
Next
$dif1 = TimerDiff($begin1)

ProgressSet(20, "FFGetPixel")
; Processing time comparaison with FastFind equivalent : FFGetPixel, that works on a SnapShot.
FFSnapShot() ; To keep it simple, a FullScreen capture here
$begin2 = TimerInit()
for $x = 1 to 2000
  ; Func FFGetPixel($x, $y, $NoSnapShot=$FFLastSnap)
  $a = FFGetPixel($x, 500);
Next
$dif2 = TimerDiff($begin2)

ProgressSet(30, "GetPixel direct DllCall")
; Same with direct dll call => nearly 40% faster
FFSnapShot() ; To keep it simple, a FullScreen capture here
$begin22 = TimerInit()
for $x = 1 to 3000
  DllCall($FFDllHandle, "int", "FFGetPixel", "int", $x, "int", 500, "int", $FFLastSnap)
 Next
$dif22 = TimerDiff($begin22)

ProgressSet(40, "10x10 FFSnapShot")
; SnapShot BenchMark : 100 SnapShots of 10x10 areas
$begin3 = TimerInit()
for $x = 1 to 100
  ;Func FFSnapShot(const $Left=0, const $Top=0, const $Right=0, const $Bottom=0, const $NoSnapShot=$FFDefaultSnapShot, const $WindowHandle=-1)
  $a = FFSnapShot(0,0,9,9) ; 10x10 pixels area
Next
$dif3 = TimerDiff($begin3)

ProgressSet(50, "FullScreen FFSnapShot")
; SnapShot BenchMark : 100 FullScreen SnapShots
$begin4 = TimerInit()
for $x = 1 to 100
  ;Func FFSnapShot(const $Left=0, const $Top=0, const $Right=0, const $Bottom=0, const $NoSnapShot=$FFDefaultSnapShot, const $WindowHandle=-1)
  $a = FFSnapShot() ; FullScreen Capture
Next
$dif4 = TimerDiff($begin4)

ProgressSet(60, "Simple FFNearestPixel")
; FFNearestPixel BenchMark : 500 simple pixel search in 200x200 area
$a = FFSnapShot(0,0,199,199) ; 200x200 pixels
$begin5 = TimerInit()
for $x = 1 to 500
  ; Func FFNearestPixel($PosX, $PosY, $Color, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
  $a = FFNearestPixel($x,$x,0x002545FA,false) ; Pixel search in 200x200 area, don't force SnapShots each time
Next
$dif5 = TimerDiff($begin5)

ProgressSet(70, "FFNearestSpot - simple usage")
; FFNearestPixel BenchMark : 200 pixel search in FullScreen and ShadeVariation
; As NearestPixel do not expose ShadeVariation, we use FFNearestSpot($SizeSearch, $NbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
$a = FFSnapShot() ; FullScreen
$begin52 = TimerInit()
for $x = 1 to 200
  ; Func FFNearestSpot($SizeSearch, $NbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
  $a = FFNearestSpot(1, 1, $x, $x, 0x00FF5511, 2, false)
Next
$dif52 = TimerDiff($begin52)


ProgressSet(80, "FFNearestSpot - complex usage")
; FFNearestPixel BenchMark : 500 simple pixel search in 200x200 area
; SnapShot BenchMark : 100 FullScreen SnapShots
$a = FFSnapShot() ; FullScreen Capture
FFAddColor(0x453456)
FFAddColor(0xFF0034)
FFAddColor(0x76FF98)
FFAddColor(0x8723FF)
FFAddColor(0x771122)
FFAddExcludedArea(5,10,10,15)
FFAddExcludedArea(52,52,80,80)
FFAddExcludedArea(120,130,100,180)
$begin6 = TimerInit()
for $x = 1 to 100
  ; Func FFNearestSpot($SizeSearch, $NbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)
  $a = FFNearestSpot(20, 50, 100, 100, -1, 10, false) ; With ShadeVariation, don't force SnapShots each time
Next
$dif6 = TimerDiff($begin6)

ProgressSet(90, "FFBestSpot  - complexe usage")
$begin7 = TimerInit()
for $x = 1 to 100
  ; Func FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, $Color, $ShadeVariation=0, $ForceNewSnap=true, $Left=0, $Top=0, $Right=0, $Bottom=0, $NoSnapShot=$FFLastSnap, $WindowHandle=-1)	
  $a = FFBestSpot(20, 2, 50, 100, 100, -1, 10, false) ; Same as before, but can accept down to 2 pixels only instead of 50
Next
$dif7 = TimerDiff($begin7)

Func TimeSpan($dif, $Nb)
	$res = ($dif / 1000)/$Nb
	if ($res >= 0.010) Then
		return " = "&Round($res*1000)&" mS ("&$Nb&" runs)"&@lf
	Else
		return " = "&Round($res*1000000)&" µS ("&$Nb&" runs)"&@lf
	EndIf
EndFunc
ProgressOff()
MsgBox(0, "FastFind Benchmark", "Elpased time for :"&@lf&@lf&"PixelGetColor" & TimeSpan($dif,100) & "FullScreen PixelSearch with ShadeVariation" & TimeSpan($dif1,100) & @lf & "FFGetPixel" & TimeSpan($dif2,2000) & "Same with direct dllCall" & TimeSpan($dif22,3000) & @lf & "SnapShot 10x10 area " & TimeSpan($dif3,100) & "FullSreen SnapShot" & TimeSpan($dif4,100) & "Simple Pixel Searches in 200x200 area" & TimeSpan($dif5,500) & "Pixel Searches with ShadeVariation in FullScreen" & TimeSpan($dif52, 200) & "Complexe FullScreen searches (20x20 Spot, List of 5 colors with ShadeVariation and 3 excluded rectangles)" & TimeSpan($dif6,100) & "Same as before, but searches best spot containing from 2 to 50 good pixels (FFBestSpot)" & TimeSpan($dif7,100))


; Results : PixelGetColor x 500 = 9.61 Seconds
;           FFGetPixel x 500    = 0.0893 Seconds