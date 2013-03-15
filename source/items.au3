func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey, 600)
	next
endfunc

func HealthPotion()
	LogWrite("HealthPotion()")
	SendClient($kHeathPoitionKey, 500)
endfunc

func ManaPotion()
	LogWrite("ManaPotion()")
	SendClient($kManaPoitionKey, 500)
endfunc
