#define FORMAT_HIVELESS_PROTEIN_MAX_TEXT(charges) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#dd2828'>[round(charges)]</font></div>")
#define FORMAT_HIVELESS_PROTEIN_TEXT(charges) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#c8402f'>[round(charges)]</font></div>")

/// Left-edge HUD element showing current protein reserves.
/atom/movable/screen/hiveless_protein
	name = "protein reserves"
	icon = 'icons/hud/screen_changeling.dmi'
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay
	/// TRUE while the mouse is hovering this element.
	var/hovering = FALSE

/atom/movable/screen/hiveless_protein/Click(location, control, params)
	. = ..()
	to_chat(usr, span_notice("Shows your current protein reserves. Hovering displays your maximum capacity."))

/atom/movable/screen/hiveless_protein/MouseEntered(location, control, params)
	var/mob/user = get_mob()
	if(usr != user)
		return
	. = ..()
	hovering = TRUE
	var/obj/item/organ/stomach/hiveless/bank = user?.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(bank))
		bank.update_protein_hud()

/atom/movable/screen/hiveless_protein/MouseExited(location, control, params)
	var/mob/user = get_mob()
	if(usr != user)
		return
	. = ..()
	hovering = FALSE
	var/obj/item/organ/stomach/hiveless/bank = user?.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(bank))
		bank.update_protein_hud()
