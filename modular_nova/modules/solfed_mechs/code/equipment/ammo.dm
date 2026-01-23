/obj/item/mecha_ammo/teargas
	name = "launchable tear gas grenades"
	desc = "A box of sealed tear gas grenades, for use with a large exosuit launcher. Cannot be primed by hand."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_ammo.dmi'
	icon_state = "teargas"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2, /datum/material/silver=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	ammo_type = MECHA_AMMO_TEARGAS

/obj/item/mecha_ammo/siege
	name = "40x250mm Sabot Slug Crate"
	desc = "A crate of hyperdense sabot slugs for siege-grade mech weapons. Designed for the T-99 'Hammerfall' mass driver."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_ammo.dmi'
	icon_state = "sabot"
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT*10)
	rounds = 24
	ammo_type = MECHA_AMMO_SIEGE

/obj/item/mecha_ammo/emp
	name = "EMP pulse cell pack"
	desc = "A sealed pack of EMP pulse cells, calibrated for Hermes-class electronic warfare rifles. Emits focused bursts designed to disable electronics without causing structural damage."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_ammo.dmi'
	icon_state = "emp"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*3)
	rounds = 12
	ammo_type = MECHA_AMMO_EMP

/obj/item/mecha_ammo/rubber
	name = "rubber slug crate"
	desc = "A crate of dense rubber slugs designed for non-lethal riot suppression. Compatible with exosuit-mounted riotguns."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_ammo.dmi'
	icon_state = "rubber"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/plastic = SMALL_MATERIAL_AMOUNT*5)
	rounds = 24
	ammo_type = MECHA_AMMO_RUBBER
