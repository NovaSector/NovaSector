/obj/item/clothing/head/utility/radiation/cbrnhood
	name = "CBRN hood"
	armor_type = /datum/armor/utility_radiation/cbrn

/obj/item/clothing/head/utility/radiation/cbrnhood/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)

/datum/armor/utility_radiation/cbrn
	melee = 60
	bullet = 40
	laser = 30
	energy = 80
	bomb = 20
	bio = 100
	fire = 75
	acid = 100
	wound = 25

/obj/item/clothing/suit/utility/radiation/cbrnsuit
	name = "CBRN suit"
	allowed = null
	slowdown = 0
	armor_type = /datum/armor/utility_radiation/cbrn

/obj/item/clothing/suit/utility/radiation/cbrnsuit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)
