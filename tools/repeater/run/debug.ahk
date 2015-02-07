kLogFile = debug.log

LogWrite(data)
{
	global kLogFile
	FileAppend, %data%`n, %kLogFile%
}
