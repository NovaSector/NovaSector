#define BHORN_STAMINA_MINIMUM 10 //What is the amount of stam damage that we prevent blowing horn use at
#define WHORN_STAMINA_MININMUM 50 //What is the amount of stam damage that we prevent war horn use at
#define BHORN_STAMINA_USE 10 //How much stam damage is given to people when the blowing horn is used
#define WHORN_STAMINA_USE 50 //How much stam damage is given to people when the war horn is used

/obj/item/blowing_horn
	name = "Blowing horn"
	desc = "A crude instrument fashioned from a beast’s horn, once used to rally kin during goblin raids — or so the stories say."
	icon = 'icons/obj/art/musician.dmi'// Need to make a sprite
	icon_state = "trumpet"//need to make a sprite
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
//carryable, limited range

/obj/machinery/
//static, makes a server wide annoucement.

/obj/item/blowing_horn/attack_self(mob/living/user)
	if (user.getStaminaLoss() > BHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return
	var/bhorn_range = 85
	var/bhorn_origin = get_turf(user)
	user.show_message(span_notice("You blow the horn as hard as you can."))
	for (var/mob/living/hearing_player in range(bhorn_range, bhorn_origin))
		if (!hearing_player.can_hear())
			continue
		else if (hearing_player != user)
			var/hearer_turf = get_turf(hearing_player)
			var/direction_text = span_bold("[dir2text(get_dir(hearer_turf, bhorn_origin))]")
			hearing_player.show_message(span_notice("Somewhere to the [direction_text], a horn calls out."))
		hearing_player.playsound_local(bhorn_origin,'modular_nova/master_files/sound/items/blow_horn.ogg' , 100, TRUE)
	user.adjustStaminaLoss(BHORN_STAMINA_USE)

#undef BHORN_STAMINA_MINIMUM
#undef WHORN_STAMINA_MININMUM
#undef BHORN_STAMINA_USE
#undef WHORN_STAMINA_USE
