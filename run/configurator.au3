; FIXME: Make Russian and English variant of tips
global const $kParamCount = 17
global const $kTipText[$kParamCount] = [ _
	"Укажите левую-верхнюю точку окна цели", _
	"Укажите правую-нижнюю точку окна цели", _	
	"Укажите первую точку окна цели с характерным цветом", _
	"Укажите вторую точку окна цели с характерным цветом", _
	"Укажите левую-верхнюю точку на полоске HP цели", _
	"Укажите правую-нижнюю точку на полоске HP цели", _	
	"Укажите точку на полной полоске HP цели с характерным цветом", _
	"Укажите левую-верхнюю точку на полоске MP цели (выделите себя или пета)", _
	"Укажите правую-нижнюю точку на полоске MP цели (выделите себя или пета)", _	
	"Укажите точку на полной полоске MP цели с характерным цветом (выделите себя или пета)", _	
	"Укажите точку на пустой полоске MP цели с характерным цветом (выделите себя или пета)", _		
 	"Укажите левую-верхнюю точку на полоске HP персонажа", _
 	"Укажите правую-нижнюю точку на полоске HP персонажа", _	
	"Укажите точку на полной полоске HP персонажа с характерным цветом", _	
	"Укажите левую-верхнюю точку на полоске MP персонажа", _
	"Укажите правую-нижнюю точку на полоске MP персонажа", _
	"Укажите точку на полной полоске MP персонажа с характерным цветом" _	
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
 	"kSelfManaColor" _	
]

global const $kConfigFile = "../conf/interface.au3"

#include "../source/configurator.au3"
