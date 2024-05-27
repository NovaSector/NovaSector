// Creates 3 new ammo boxes that will feed into every weapon that's not a clown/mime, uses pre-defined ammo vars in code.
// LMG = Ballistic / Flashbang = Non-Lethal / PEP = Explosive
// it all prints out of the same machine, not like it matters that much, might as well make it easy.

/obj/item/mecha_ammo/lmg/ballistic
	name = "Ballistic ammo box"
	desc = "A box of linked ammunition, designed for all ballistic weapons."
	icon_state = "lmg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2)
	rounds = 300
	ammo_type = MECHA_AMMO_LMG

/obj/item/mecha_ammo/flashbang/nonlethal
	name = "Non-lethal ammo box"
	desc = "A box of non-lethal ammunition, flashbangs, stingbangs and pepperspray"
	icon_state = "flashbang"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	ammo_type = MECHA_AMMO_FLASHBANG

/obj/item/mecha_ammo/pep/explosive
	name = "Explosive ammo box"
	desc = "A box of large explosives, for explosive weapons."
	icon_state = "missile_br"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*4,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	direct_load = TRUE
	load_audio = 'sound/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_PEP
