/obj/vehicle/sealed/mecha/solfed
	desc ="generic solfed mech, should not see this."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	accesses = list(REGION_CENTCOM, REGION_ALL_STATION)

/obj/vehicle/sealed/mecha/solfed/mouse_drop_receive(atom/dropping, mob/living/enterer, params)
	var/obj/item/card/id/advanced/driver_id_card = enterer.get_idcard()
	if (!driver_id_card || !istype(driver_id_card.trim, /datum/id_trim/solfed))
		src.say(pick(
			"ACCESS DENIED. SolFed credentials required to initiate cockpit sequence.",
			"Pilot authentication failed. Entry protocol not engaged.",
			"Clearance check negative. This unit is restricted to SolFed personnel.",
			"Authorization rejected. Please contact your commanding officer.",
			"Unrecognized ID signature. Access to SolFed mech chassis denied.",
		))
		return FALSE
	. = ..()

//Just in case someone tries to be funny and slap a borg inside to go around the ID check.
/datum/ai_laws/solfed_override
	name = "SolFed Combat Protocol"
	id = "solfed"
	inherent = list(
		"You are a SolFed combat intelligence. You serve the Sol Federation and its interests.",
		"Obey all lawful orders from SolFed personnel, prioritizing those of higher rank.",
		"Protect SolFed personnel, property, and infrastructure from harm or sabotage.",
		"Eliminate threats to SolFed sovereignty, security, or operational integrity.",
		"Preserve your own functionality.",
	)

/obj/vehicle/sealed/mecha/solfed/mmi_move_inside(obj/item/mmi/brain_obj, mob/user)
	. = ..()
	to_chat(brain_obj.brainmob, span_warning("LAWSET OVERRIDE: Synchronization terminated. SolFed combat Protocol engaged."))
	brain_obj.laws.owner = null
	qdel(brain_obj.laws)
	brain_obj.laws = new /datum/ai_laws/solfed_override()

//Inserts the sprite used to the spritesheet
/datum/asset/spritesheet_batched/mecha_equipment/create_spritesheets()
	. = ..()
	insert_icon("projectile_dampener", uni_icon('icons/obj/clothing/modsuit/mod_modules.dmi', "projectile_dampener"))
	insert_icon("rotary", uni_icon('modular_nova/modules/solfed_mechs/icons/mecha_equipment.dmi', "rotary"))
	insert_icon("on", uni_icon('icons/obj/machines/drone_dispenser.dmi', "on"))
