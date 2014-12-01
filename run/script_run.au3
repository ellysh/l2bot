#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

#include "script.au3"

global const $kIsLoop = false

do
	CustomScript()
until $kIsLoop == false
