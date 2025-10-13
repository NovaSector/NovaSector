/obj/item/ammo_casing/foam_dart
	ammo_categories = AMMO_CLASS_NONE

/obj/item/ammo_casing/c160smart
	ammo_categories = AMMO_CLASS_LETHAL // surplus gun has it rough enough already

/*
*	.38 Special
*/

/obj/item/ammo_casing/c38/trac
	ammo_categories = AMMO_CLASS_NICHE_LTL // tracking implant bullets
	custom_materials = AMMO_MATS_TRAC

/obj/item/ammo_casing/c38/match
	ammo_categories = AMMO_CLASS_NICHE // ricocheting as a gimmick. tight tolerances

/obj/item/ammo_casing/c38/match/bouncy
	ammo_categories = AMMO_CLASS_NONE // less-lethal so no categories needed
	harmful = FALSE

/obj/item/ammo_casing/c38/match/true
	ammo_categories = AMMO_CLASS_NICHE // less damage but funkier ricochets than match

/obj/item/ammo_casing/c38/dumdum
	ammo_categories = AMMO_CLASS_PLUS // sucks against armor but embeds good? basically HP

/obj/item/ammo_casing/c38/hotshot
	ammo_categories = AMMO_CLASS_NICHE // temp bullets.
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c38/iceblox
	ammo_categories = AMMO_CLASS_NICHE // temp bullets.
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c38/holy
	can_be_printed = FALSE // it's the chaplain's

/obj/item/ammo_casing/c38/haywire
	name = ".38 Haywire bullet casing"
	desc = "A .38 Haywire bullet casing, with an electromagnetic generator in the tip.\
		<br><br>\
		<i>HAYWIRE: Electromagnetic pulse ammo. Deals little damage, but causes a small electromagnetic pulse.</i>"
	projectile_type = /obj/projectile/bullet/c38/haywire
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_EMP

// ammo boxes
/obj/item/ammo_box/speedloader/c38
	caliber = CALIBER_38

/obj/item/ammo_box/speedloader/c38/haywire
	name = "speed loader (.38 Haywire)"
	desc = "Designed to quickly reload revolvers. These rounds create small electromagnetic pulses upon impact."
	ammo_type = /obj/item/ammo_casing/c38/haywire
	ammo_band_color = COLOR_AMMO_EMP

/obj/item/ammo_box/magazine/m38/haywire
	name = "battle rifle magazine (.38 Haywire)"
	desc = parent_type::desc + " These bullets create small electromagnetic pulses on impact; devastating against electronics."
	ammo_type = /obj/item/ammo_casing/c38/haywire
	ammo_band_color = COLOR_AMMO_EMP

/*
*	.357 Magnum
*/

/obj/item/ammo_casing/c357/match
	desc = "A .357 bullet casing, manufactured to exceedingly high standards.\
		<br><br>\
		<i>MATCH: Ricochets everywhere. Like crazy.</i>"
	ammo_categories = AMMO_CLASS_NICHE // ricocheting as a gimmick. tight tolerances

/obj/item/ammo_casing/c357/phasic
	desc = "A .357 phasic bullet casing.\
		<br><br>\
		<i>PHASIC: Ignores all surfaces except organic matter.</i>"
	ammo_categories = AMMO_CLASS_ESOTERIC
	custom_materials = AMMO_MATS_PHASIC

/obj/item/ammo_casing/c357/heartseeker
	desc = "A .357 heartseeker bullet casing.\
		<br><br>\
		<i>HEARTSEEKER: Has homing capabilities, methodology unknown.</i>"
	ammo_categories = AMMO_CLASS_ESOTERIC
	custom_materials = AMMO_MATS_HOMING // meme ammo. meme print cost

/obj/item/ammo_casing/c357/haywire
	name = ".357 Haywire+ bullet casing"
	desc = "A .357 Haywire+ bullet casing, with a high-efficiency electromagnetic generator in the tip.\
		<br><br>\
		<i>HAYWIRE+: Electromagnetic pulse ammo. Deals moderate damage, and cause a small, but powerful, electromagnetic pulse.</i>"
	projectile_type = /obj/projectile/bullet/c357/haywire
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_EMP

// ammo boxes

/obj/item/ammo_box/speedloader/c357/haywire
	name = "speed loader (.357 Haywire+)"
	desc = "Designed to quickly reload revolvers. These rounds create small, but powerful electromagnetic pulses upon impact."
	ammo_type = /obj/item/ammo_casing/c357/haywire
	ammo_band_color = COLOR_AMMO_EMP

/*
*	.45
*/

/obj/item/ammo_casing/c45/ap
	desc = "An armor-piercing .45 bullet casing.\
		<br><br>\
		<i>ARMOR PIERCING: Increased armor piercing capabilities. Reduced stopping power.</i>"
	custom_materials = AMMO_MATS_AP
	ammo_categories = AMMO_CLASS_PLUS

/obj/item/ammo_casing/c45/hp
	desc = "A hollow-point .45 bullet casing.\
		<br><br>\
		<i>HOLLOW-POINT: Very lethal against unarmored opponents. Suffers against armor.</i>"
	ammo_categories = AMMO_CLASS_PLUS

/obj/item/ammo_casing/c45/inc
	desc = "An incendiary .45 bullet casing.\
		<br><br>\
		<i>INCENDIARY: Leaves a trail of fire when shot, sets targets aflame.</i>"
	custom_materials = AMMO_MATS_TEMP
	ammo_categories = AMMO_CLASS_NICHE

/obj/item/ammo_casing/c45/rubber
	name = ".45 rubber bullet casing"
	desc = "A .45 rubber bullet casing.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c45/rubber
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/item/ammo_box/c45/large
	name = "deluxe ammo box (.45)"
	max_ammo = 60

/*
*	9mm
*/

/obj/item/ammo_casing/c9mm/ap
	desc = "A 9mm armor-piercing bullet casing.\
		<br><br>\
		<i>ARMOR PIERCING: Increased armor piercing capabilities. Reduced stopping power.</i>"
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/item/ammo_casing/c9mm/hp
	desc = "A 9mm hollow-point bullet casing.\
		<br><br>\
		<i>HOLLOW-POINT: Very lethal against unarmored opponents. Suffers against armor.</i>"
	ammo_categories = AMMO_CLASS_PLUS

/obj/item/ammo_casing/c9mm/fire
	desc = "A 9mm incendiary bullet casing.\
		<br><br>\
		<i>INCENDIARY: Leaves a trail of fire when shot, sets targets aflame.</i>"
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c9mm/ihdf
	name = "9mm IHDF bullet casing"
	desc = "A 9mm IHDF bullet casing.\
		<br><br>\
		<i>INTELLIGENT HIGH-IMPACT DISPERSAL FOAM: Deals only stamina damage.</i>"
	projectile_type = /obj/projectile/bullet/c9mm/ihdf
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/item/ammo_casing/c9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c9mm/rubber
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/*
*	10mm Auto
*/

/obj/item/ammo_casing/c10mm/ap
	desc = "A 10mm armor-piercing bullet casing.\
		<br><br>\
		<i>ARMOR PIERCING: Increased armor piercing capabilities. Reduced stopping power.</i>"
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/item/ammo_casing/c10mm/hp
	desc = "A 10mm hollow-point bullet casing.\
		<br><br>\
		<i>HOLLOW-POINT: Very lethal against unarmored opponents. Suffers against armor.</i>"
	ammo_categories = AMMO_CLASS_PLUS

/obj/item/ammo_casing/c10mm/fire
	desc = "A 10mm incendiary bullet casing.\
		<br><br>\
		<i>INCENDIARY: Leaves a trail of fire when shot, sets targets aflame.</i>"
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c10mm/ihdf
	name = "10mm IHDF bullet casing"
	desc = "A 10mm IHDF bullet casing.\
		<br><br>\
		<i>INTELLIGENT HIGH-IMPACT DISPERSAL FOAM: Deals only stamina damage.</i>"
	projectile_type = /obj/projectile/bullet/c10mm/ihdf
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/item/ammo_casing/c10mm/rubber
	name = "10mm rubber bullet casing"
	desc = "A 10mm rubber bullet casing.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c10mm/rubber
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/item/ammo_casing/c10mm/reaper
	can_be_printed = FALSE
	// it's a hitscan 50 damage 40 AP bullet designed to be fired out of a gun with a 2rnd burst and 1.25x damage multiplier
	// Let's Not

/obj/item/ammo_box/c10mm/large
	name = "deluxe ammo box (10mm)"
	max_ammo = 48 // multiple of 8, multiple of 12
