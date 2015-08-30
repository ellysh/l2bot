/*
 * Functions exported in FastFind.dll - version 2.0
 * WINAPI is defined as follows : #define WINAPI _stdcall
 * COLORREF is defined as follows : typedef DWORD COLORREF
 */

// Exclusion areas
void WINAPI AddExcludedArea(int x1, int y1, int x2, int y2);
bool WINAPI IsExcluded(int x, int y, HWND hWnd);
void WINAPI ResetExcludedAreas();

// Configuration
void WINAPI SetDebugMode(int NewMode);
void WINAPI SetHWnd(HWND NewWindowHandle, bool bClientArea);
LPCTSTR WINAPI GetLastErrorMsg();
LPCTSTR WINAPI FFVersion(void);

// Basic functions
int WINAPI GetPixel(int X, int Y, int NoSnapShot);
int WINAPI ColorPixelSearch(int &XRef, int &YRef, int ColorToFind, int NoSnapShot);
int WINAPI GetPixelFromScreen(int x, int y, int NoSnapShot); // Idem GetPixel, mais en coordonnées écran

// Snapshots
int WINAPI SnapShot(int aLeft, int aTop, int aRight, int aBottom, int NoSnapShot);

// List of colors management
int WINAPI AddColor (COLORREF NewColor);
int WINAPI RemoveColor (COLORREF NewColor);
void WINAPI ResetColors ();

// Search function, for multiple colors (color list should be defined first)
int WINAPI ColorsPixelSearch(int &XRef, int &YRef, int NoSnapShot);

// ColorsSearch is close to ColorSearch, except it can look for several colors instead of only one. 
int WINAPI ColorsSearch(int SizeSearch, int &NbMatchMin, int &XRef, int &YRef, int NoSnapShot);

// Most generic search function : called in most case. 
int WINAPI GenericColorSearch(int SizeSearch, int &NbMatchMin, int &XRef, int &YRef, int ColorToFind, int ShadeVariation, int NoSnapShot);

// New vith verion 1.4 : more powerful search function : looks for 'spots' instead of pixels
int WINAPI ProgressiveSearch(int SizeSearch, int &NbMatchMin, int NbMatchMax, int &XRef, int &YRef, int ColorToFind/*-1 if several colors*/, int ShadeVariation, int NoSnapShot);

// Count pixels with a given color
int WINAPI ColorCount(int ColorToFind, int NoSnapShot, int ShadeVariation);

// SnapShot saving into bitmap file
bool WINAPI SaveBMP(int NoSnapShot, LPCSTR szFileName /* With no extension (xxx.bmp added)*/);
bool WINAPI SaveJPG(int NoSnapShot, LPCSTR szFileName /* With no extension*/, ULONG uQuality) ;
int WINAPI GetLastFileSuffix();

// Raw SnapShot rata retrieval
int * WINAPI GetRawData(int NoSnapShot, int &NbBytes);

// Detection of changes between two SnapShots
int WINAPI KeepChanges(int NoSnapShot, int NoSnapShot2, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **
int WINAPI KeepColor(int NoSnapShot, int ColorToFind, int ShadeVariation);  
int WINAPI HasChanged(int NoSnapShot, int NoSnapShot2, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **
int WINAPI LocalizeChanges(int NoSnapShot, int NoSnapShot2, int &xMin, int &yMin, int &xMax, int &yMax, int &nbFound, int ShadeVariation);  // ** Changed in version 2.0 : ShadeVariation added **

// Display of a SnapShot
bool WINAPI DrawSnapShot(int NoSnapShot);
bool WINAPI DrawSnapShotXY(int NoSnapShot, int X, int Y); // ** New in version 2.0 **

// Change of the color of a pixel (hyper-omptimized function)
bool WINAPI FFSetPixel(int x, int y, int Color, int NoSnapShot);

// SnapShot duplication
bool WINAPI DuplicateSnapShot(int Src, int Dst);

// Misc functions, new in version 2.0
int WINAPI ComputeMeanValues(int NoSnapShot, int &MeanRed, int &MeanGreen, int &MeanBlue);
int WINAPI ApplyFilterOnSnapShot(int NoSnapShot, int Red, int Green, int Blue);