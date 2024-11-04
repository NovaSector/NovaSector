/obj/item/holosign_creator/privacy
	name = "personal holosign projector"
	desc = "A holographic projector which creates privacy barriers to inform people that you are looking for privacy. Right-click to switch between pink (lewd advisory) and grey (privacy)."
	icon = 'modular_nova/master_files/icons/obj/devices/tools.dmi'
	icon_state = "signmaker_erp"
	holosign_type = /obj/structure/holosign/privacy
	creation_time = 0
	max_signs = 8
	/// Used to toggle the holosign type between normal privacy and lewd.
	var/erp_mode = FALSE

/obj/item/holosign_creator/privacy/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/holosign_creator/privacy/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_RMB] = "[erp_mode ? "Turn off" : "Turn on"] Lewd Advisory Mode"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/holosign_creator/privacy/attack_self_secondary(mob/user, modifiers)
	if(erp_mode)
		erp_mode = FALSE
		holosign_type = /obj/structure/holosign/privacy
		balloon_alert(user, "turned off Lewd Advisory Mode")
	else
		erp_mode = TRUE
		holosign_type = /obj/structure/holosign/privacy/erp
		balloon_alert(user, "turned on Lewd Advisory Mode")
	return ..()

/obj/structure/holosign/privacy
	name = "privacy holosign"
	desc = "A holographic sign which flickers with the word \"Private\". It would be polite to proceed no further if you aren't invited, even if the door isn't locked."
	icon = 'modular_nova/master_files/icons/effects/holosigns.dmi'
	icon_state = "holosign_privacy"
	base_icon_state = "holosign_privacy"

/obj/structure/holosign/privacy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(tool != projector)
		return
	qdel(src)

/obj/structure/holosign/privacy/erp
	name = "lewd advisory holosign"
	desc = "A holographic sign which flickers with the word \"Lewd\". If you choose to proceed, you can expect sexual activity."
	icon_state = "holosign_erp"
	base_icon_state = "holosign_erp"
