#define BHORN_STAMINA_MINIMUM 10 //What is the amount of stam damage that we prevent blowing horn use at
#define WHORN_STAMINA_MINIMUM 1 //What is the amount of stam damage that we prevent war horn use at
#define BHORN_STAMINA_USE 10 //How much stam damage is given to people when the blowing horn is used
#define WHORN_STAMINA_USE 50 //How much stam damage is given to people when the war horn is used

/obj/item/blowing_horn
	name = "Blowing horn"
	desc = "A crude instrument fashioned from a beast’s horn, once used to rally kin during goblin raids — or so the stories say."
	icon = 'icons/obj/art/musician.dmi'// Need to make a sprite
	icon_state = "trumpet"//need to make a sprite
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

/obj/structure/war_horn
	name ="War horn"
	desc ="A horn older than memory, shaped by hands long vanished. When it sounds, the ground listens. The breath of old wars still lingers in its coil. One call, and those who know will answer."
	icon = 'icons/obj/smooth_structures/table.dmi'//need to make a sprite
	icon_state = "table-0"//need to make a sprite
	resistance_flags = FLAMMABLE

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
			hearing_player.show_message(span_warning("Somewhere to the [direction_text], a horn calls out."))
		hearing_player.playsound_local(bhorn_origin,'modular_nova/master_files/sound/items/blow_horn.ogg' , 100, TRUE)
	user.adjustStaminaLoss(BHORN_STAMINA_USE)

/obj/structure/war_horn/attack_hand(mob/living/user)
	var/location = get_turf(user)
	if(!ishuman(user))
		return
	if (user.getStaminaLoss() > WHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return
	var/loc_text = "the molten wastes of Indecipheres"
	if (SSmapping.level_trait(2, ZTRAIT_ICE_RUINS_UNDERGROUND)&&SSmapping.level_trait(3, ZTRAIT_ICE_RUINS_UNDERGROUND))
		loc_text = "the depths of Freyja's caves"
	user.show_message(span_warning("You blow the war horn as hard as you can."))
	for (var/mob/living/hearing_player in GLOB.player_list)
		if (!is_mining_level(hearing_player.z) || !hearing_player.can_hear())
			continue
		else if (hearing_player != user)
			hearing_player.show_message(span_notice("The sounds of a war horn echoes from [loc_text]"))
		hearing_player.playsound_local(location,'modular_nova/master_files/sound/items/blow_horn.ogg' , 100, TRUE)
	user.adjustStaminaLoss(WHORN_STAMINA_USE)

#undef BHORN_STAMINA_MINIMUM
#undef WHORN_STAMINA_MINIMUM
#undef BHORN_STAMINA_USE
#undef WHORN_STAMINA_USE


//todo, no BHORN use in space, add sprites, whorn attached to the floor, check WHORN usescases, check serenity station.
