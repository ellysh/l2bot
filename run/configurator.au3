global const $kParamCount = 19
global const $kTipText[$kParamCount] = [ _
	"1. Укажите левую-верхнюю точку окна цели", _
	"2. Укажите правую-нижнюю точку окна цели", _	
	"3. Укажите первую точку окна цели с характерным цветом", _
	"4. Укажите вторую точку окна цели с характерным цветом", _
	"5. Укажите левую-верхнюю точку на полоске HP цели", _
	"6. Укажите правую-нижнюю точку на полоске HP цели", _	
	"7. Укажите точку на полной полоске HP цели с характерным цветом", _
	"8. Укажите левую-верхнюю точку на полоске MP цели (выделите себя)", _
	"9. Укажите правую-нижнюю точку на полоске MP цели (выделите себя)", _	
	"10. Укажите точку на полной полоске MP цели с характерным цветом (выделите себя)", _	
	"11. Укажите точку на пустой полоске MP цели с характерным цветом (выделите себя)", _		
 	"12. Укажите левую-верхнюю точку на полоске HP игрока", _
 	"13. Укажите правую-нижнюю точку на полоске HP игрока", _	
	"14. Укажите точку на полной полоске HP игрока с характерным цветом", _	
	"15. Укажите левую-верхнюю точку на полоске MP игрока", _
	"16. Укажите правую-нижнюю точку на полоске MP игрока", _
	"17. Укажите точку на полной полоске MP игрока с характерным цветом", _	
	"18. Укажите левую-верхнюю точку окна карты", _
	"19. Укажите правую-нижнюю точку окна карты" _
]

global const $kParamNames[$kParamCount] = [ _
	"kTargetWindowLeft", _
	"kTargetWindowRight", _
	"kTargetWindowColorBrown", _
	"kTargetWindowColorGray", _	
	"kTargetHealthLeft", _
 	"kTargetHealthRight", _
 	"kTargetHealthColor", _
 	"kTargetManaLeft", _
 	"kTargetManaRight", _
 	"kTargetManaColor", _
 	"kTargetManaEmptyColor", _
 	"kSelfHealthLeft", _
 	"kSelfHealthRight", _
 	"kSelfHealthColor", _
 	"kSelfManaLeft", _	
 	"kSelfManaRight", _	
 	"kSelfManaColor", _
	"kMapWindowLeft", _
	"kMapWindowRight" _
]

global const $kConfigFile = "../conf/interface.au3"

#include "../source/configurator.au3"
