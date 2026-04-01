//PRIDE FLAGS

/obj/structure/sign/flag/pride
	name = "coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_nova/master_files/icons/obj/structures/pride_flags.dmi'
	custom_materials = null
	abstract_type = /obj/structure/sign/flag/pride
	///Whether or not we are currently in the vertical configuration
	var/vertical = FALSE

/obj/structure/sign/flag/pride/click_alt(mob/user)
	vertical = !vertical
	if(vertical)
		icon_state = "[icon_state]_vertical"
	else
		icon_state = initial(icon_state)
	update_appearance(UPDATE_ICON_STATE)
	to_chat(user, span_notice("You make the [name] [vertical ? "vertically" : "horizontally"] prideful"))
	return CLICK_ACTION_SUCCESS

/obj/structure/sign/flag/pride/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(vertical)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Hang horizontally"
	else
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Hang vertically"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sign/flag/pride/gay
	name = "gay pride flag"
	desc = "The flag of gay pride."
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

/obj/structure/sign/flag/pride/ace
	name = "asexual pride flag"
	desc = "The flag of asexual pride."
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

/obj/structure/sign/flag/pride/bi
	name = "bisexual pride flag"
	desc = "The flag of bisexual pride."
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

/obj/structure/sign/flag/pride/lesbian
	name = "lesbian pride flag"
	desc = "The flag of lesbian pride."
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

/obj/structure/sign/flag/pride/pan
	name = "pansexual pride flag"
	desc = "The flag of pansexual pride."
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

/obj/structure/sign/flag/pride/trans
	name = "trans pride flag"
	desc = "The flag of trans pride."
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

// FOLDED

/obj/item/sign/flag/pride
	name = "folded coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_nova/master_files/icons/obj/structures/pride_flags.dmi'
	custom_materials = null
	abstract_type = /obj/item/sign/flag/pride

/obj/item/sign/flag/pride/examine(mob/user)
	. = ..()
	. += span_notice("You can hang it up on a [EXAMINE_HINT("wall")].")

/obj/item/sign/flag/pride/gay
	name = "folded gay pride flag"
	desc = "The folded flag of gay pride."
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay

/obj/item/sign/flag/pride/ace
	name = "folded asexual pride flag"
	desc = "The folded flag of asexual pride."
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace

/obj/item/sign/flag/pride/bi
	name = "folded bisexual pride flag"
	desc = "The folded flag of bisexual pride."
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi

/obj/item/sign/flag/pride/lesbian
	name = "folded lesbian pride flag"
	desc = "The folded flag of lesbian pride."
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian

/obj/item/sign/flag/pride/pan
	name = "folded pansexual pride flag"
	desc = "The folded flag of pansexual pride."
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan

/obj/item/sign/flag/pride/trans
	name = "folded trans pride flag"
	desc = "The folded flag of trans pride."
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans
