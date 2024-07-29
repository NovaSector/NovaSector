/datum/outfit/sapper
	name = "Space Sapper"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/sapper

	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/sapper
	neck = /obj/item/clothing/neck/security_cape/sapper
	belt = /obj/item/storage/belt/utility/sapper
	gloves = /obj/item/clothing/gloves/color/yellow
	shoes = /obj/item/clothing/shoes/workboots/sapper

	box = /obj/item/storage/box/survival/engineer
	back = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/empty
	backpack_contents = list(
		/obj/item/storage/box/smart_metal_foam = 1,
		/obj/item/mod/control/pre_equipped/frontier_colonist = 1,
		/obj/item/fireaxe = 1,
		/obj/item/stack/cable_coil/thirty = 2,
		)

	l_pocket = /obj/item/paper/fluff/sapper_intro
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/sapper/pre_equip(mob/living/carbon/human/equipped)
	if(equipped.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/sapper/skirt

/datum/outfit/sapper/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= FACTION_SAPPER

	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.keyslot = new /obj/item/encryptionkey/syndicate()
		outfit_radio.set_frequency(FREQ_SYNDICATE)

	var/obj/item/card/id/outfit_id = equipped.wear_id
	if(outfit_id)
		outfit_id.registered_name = equipped.real_name
		outfit_id.update_label()
		outfit_id.update_icon()

	var/obj/item/clothing/under/outfit_uniform = equipped.w_uniform
	if(outfit_uniform)
		outfit_uniform.has_sensor = NO_SENSORS
		outfit_uniform.sensor_mode = SENSOR_OFF
		equipped.update_suit_sensors()

	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)


/obj/item/clothing/mask/gas/sapper_one
	name = "sapper gas mask"
	desc = ""
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "mask_one"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'

/obj/item/clothing/mask/gas/sapper_two
	name = "sapper gas mask"
	desc = ""
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "mask_two"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'

/obj/item/clothing/under/sapper
	name = "sapper outfit"
	desc = ""
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "suit_pants"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'
	inhand_icon_state = "engi_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/sapper
	can_adjust = FALSE

/obj/item/clothing/under/sapper/skirt
	icon_state = "suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/datum/armor/clothing_under/sapper
	melee = 25
	wound = 20
	bullet = 5
	laser = 45
	fire = 95
	acid = 35

/obj/item/clothing/shoes/workboots/sapper
	name = "\improper black Work boots"
	desc = "Lace-up steel-tipped shiny black workboots, nice."
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "boots"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'
	inhand_icon_state = "jackboots"
	armor_type = /datum/armor/shoes_combat

/obj/item/clothing/shoes/workboots/sapper/Initialize(mapload)
	. = ..()
	contents += new /obj/item/screwdriver

/obj/item/storage/belt/utility/sapper
	name = "\improper black Toolbelt"
	desc = "A tactical toolbelt."
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "belt"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'
	inhand_icon_state = "security"
	worn_icon_state = "belt"
	preload = FALSE

/obj/item/storage/belt/utility/sapper/PopulateContents() //its just a complete mishmash
	new /obj/item/forcefield_projector(src)
	new /obj/item/multitool(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/construction/rcd(src)
	new /obj/item/screwdriver/caravan(src)
	new /obj/item/inducer/syndicate(src)
	new /obj/item/weldingtool/abductor(src)

/obj/item/clothing/neck/security_cape/sapper
	name = "ablative cloak"
	desc = ""
	icon = 'modular_nova/modules/sapper_gang/icon/obj/sapper.dmi'
	icon_state = "cloak"
	worn_icon = 'modular_nova/modules/sapper_gang/icon/mob/sapper.dmi'
	inhand_icon_state = null
	uses_advanced_reskins = FALSE
	unique_reskin = null
	var/hit_reflect_chance = 50

/obj/item/clothing/neck/security_cape/sapper/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE


/datum/id_trim/sapper
	assignment = "Sapper"
	trim_state = "trim_sapper"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ORANGE
	subdepartment_color = COLOR_ORANGE
	sechud_icon_state = SECHUD_SAPPER
	access = list(ACCESS_SAPPER_SHIP)
	threat_modifier = 10 //gangs are illegal

/datum/job/space_sapper
	title = ROLE_SPACE_SAPPER
	policy_index = ROLE_SPACE_SAPPER
