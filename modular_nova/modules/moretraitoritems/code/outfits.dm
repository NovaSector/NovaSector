/datum/outfit/syndicate/stealth
	name = "Syndicate Operative - Stealth Kit"
	uniform = /obj/item/clothing/under/syndicate
	ears = /obj/item/radio/headset/chameleon
	glasses = /obj/item/clothing/glasses/hud/health/night/meson
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/mod/control/pre_equipped/nuclear/chameleon
	l_pocket = null
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/military
	backpack_contents = list(
		/obj/item/tank/jetpack/oxygen/harness = 1,
		/obj/item/gun/ballistic/automatic/pistol = 1,
		/obj/item/knife/combat/survival,
	)
	skillchips = null
	uplink_type = /obj/item/uplink
	tc = 0

/datum/outfit/syndicate/stealth/pre_equip(mob/living/carbon/human/stealth_op, visuals_only)
	stealth_op.faction |= ROLE_SYNDICATE
	stealth_op.faction &= FACTION_NEUTRAL
	stealth_op.fully_replace_character_name(stealth_op.real_name, "[pick(GLOB.operative_aliases)] [syndicate_name()]")
	if(stealth_op.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/syndicate/skirt

/datum/outfit/syndicate/stealth/post_equip(mob/living/carbon/human/stealth_op, visuals_only)
	var/obj/item/radio/headset/radio = stealth_op.ears
	if(radio)
		radio.keyslot = new /obj/item/encryptionkey/syndicate()
		radio.special_channels |= RADIO_SPECIAL_SYNDIE
		radio.set_frequency(FREQ_SYNDICATE)
		radio.recalculateChannels()
	if(ispath(uplink_type, /obj/item/uplink) || tc)
		var/obj/item/uplink = new uplink_type(stealth_op, stealth_op.key, tc)
		stealth_op.equip_to_storage(uplink, ITEM_SLOT_BACK, indirect_action = TRUE, del_on_fail = TRUE)
	SSquirks.AssignQuirks(stealth_op, stealth_op.client)
	stealth_op.update_icons()
