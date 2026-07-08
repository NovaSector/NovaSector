/obj/item/petclicker
	name = "training clicker"
	desc = "A handheld clicker for reinforcing good behavior in trained animals. Activate it in-hand to click it. Alt-click to toggle how far the click carries."
	icon = 'modular_nova/master_files/icons/obj/petclicker.dmi'
	icon_state = "petclicker"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	/// The current range of the click sound effect
	var/click_sound_extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE

/obj/item/petclicker/attack_self(mob/living/user)
	. = ..()
	playsound(src, 'sound/items/pen_click.ogg', 30, vary = TRUE, extrarange = click_sound_extrarange)
	balloon_alert(user, "clicked")

/obj/item/petclicker/click_alt(mob/living/user)
	click_sound_extrarange = (click_sound_extrarange == MEDIUM_RANGE_SOUND_EXTRARANGE) ? SHORT_RANGE_SOUND_EXTRARANGE : MEDIUM_RANGE_SOUND_EXTRARANGE
	to_chat(user, span_notice("You set the [src] to [click_sound_extrarange == MEDIUM_RANGE_SOUND_EXTRARANGE ? "normal" : "short"] click range."))
	balloon_alert(user, click_sound_extrarange == MEDIUM_RANGE_SOUND_EXTRARANGE ? "normal range" : "short range")
	return CLICK_ACTION_SUCCESS

/obj/item/petclicker/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.7, 1)
