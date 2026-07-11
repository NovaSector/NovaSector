/obj/vehicle/sealed/mecha/solfed
	desc ="generic solfed mech, should not see this."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS

/obj/vehicle/sealed/mecha/solfed/mouse_drop_receive(atom/dropping, mob/living/enterer, params)
	var/obj/item/card/id/advanced/driver_id_card = enterer.get_idcard()
	if (isnull(driver_id_card) || !istype(driver_id_card.trim, /datum/id_trim/solfed))
		src.say(pick(
			"ACCESS DENIED. SolFed credentials required to initiate cockpit sequence.",
			"Pilot authentication failed. Entry protocol not engaged.",
			"Clearance check negative. This unit is restricted to SolFed personnel.",
			"Authorization rejected. Please contact your commanding officer.",
			"Unrecognized ID signature. Access to SolFed mech chassis denied.",
		))
		return FALSE
	return ..()

//Inserts the sprite used to the spritesheet
/datum/asset/spritesheet_batched/mecha_equipment/create_spritesheets()
	. = ..()
	insert_icon("projectile_dampener", uni_icon('icons/obj/clothing/modsuit/mod_modules.dmi', "projectile_dampener"))
	insert_icon("rotary", uni_icon('modular_nova/modules/solfed_mechs/icons/mecha_equipment.dmi', "rotary"))
	insert_icon("autholathe", uni_icon('icons/obj/machines/lathes.dmi', "autolathe"))
