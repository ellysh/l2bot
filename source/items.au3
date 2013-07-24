func PickDrop($count)
	for $i = 0 to $count step 1
		SendCurrentClient($kPickDropKey, 600)
	next
endfunc

func HealthPotion()
	LogWrite("HealthPotion()")
	SendCurrentClient($kHeathPoitionKey, 500)
endfunc

func ManaPotion()
	LogWrite("ManaPotion()")
	SendCurrentClient($kManaPoitionKey, 500)
endfunc
