/datum/outfit/virtual_syndicate
	name = "Virtual Syndie"
	uniform = /obj/item/clothing/under/syndicate/ninja
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/cybersun
	back = /obj/item/mod/control/pre_equipped/contractor/virtual_domain
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne,
		/obj/item/storage/box/nif_ghost_box,
	)
	r_hand = /obj/item/gun/energy/modular_laser_rifle
	l_pocket = /obj/item/storage/pouch/ammo/marksman
	belt = /obj/item/gun/energy/modular_laser_rifle/carbine
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/virtual_operative
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/virtual_syndicate/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/id_trim/chameleon/virtual_operative
	assignment = "Cybersun Counter-Bitrunner"
	trim_state = "trim_bitavatar"
	department_color = COLOR_SYNDIE_RED
	subdepartment_color = COLOR_SYNDIE_RED
	sechud_icon_state = SECHUD_SYNDICATE
