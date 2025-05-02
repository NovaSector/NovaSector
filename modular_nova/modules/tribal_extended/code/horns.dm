/// Constants for stamina usage and thresholds for both horn types
#define BHORN_STAMINA_MINIMUM 11
#define WHORN_STAMINA_MINIMUM 1
#define BHORN_STAMINA_USE 10
#define WHORN_STAMINA_USE 50

/// Blowing horn item variant (carried by players)
/obj/item/blowing_horn
	name = "Blowing horn"
	desc = "A crude instrument fashioned from a beast’s horn, once used to rally kin during goblin raids — or so the stories go. (Shift+Ctrl+Click to switch tune.)"
	icon = 'modular_nova/modules/tribal_extended/icons/items_and_weapons.dmi'
	icon_state = "blow_horn"
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	var/list/tune_patterns = list("short short long", "long short", "short long short", "long long", "short short short")
	var/current_tune_index = 1

/// Switch horn tune on ctrl+shift click
/obj/item/blowing_horn/click_ctrl_shift(mob/user)
	switch_tune(user)

/// Blows the horn if the user has enough stamina
/obj/item/blowing_horn/attack_self(mob/living/user)
	if (user.getStaminaLoss() > BHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return
	var/bhorn_origin = get_turf(user)
	var/tune_played = tune_patterns[current_tune_index]
	if (user.is_mouth_covered())
		balloon_alert(user, "Something is in the way.")
		return
	else if (isspaceturf(bhorn_origin))
		user.visible_message(
			span_emote("[user] raises the horn and blows into the void of space. Nothing happens."),
			span_notice("You try to blow the horn into the vacuum of space. What did you expect?")
		)
		return
	else
		user.visible_message(
			span_emote("[user] raises the horn and blows it with all their strength."),
			span_notice("You blow the horn as hard as you can.")
		)
		for (var/mob/hearing_player in range(170, bhorn_origin))
			if (!hearing_player.can_hear())
				continue
			var/direction_text = span_bold("[dir2text(get_dir(get_turf(hearing_player), bhorn_origin))]")
			hearing_player.playsound_local(bhorn_origin, 'modular_nova/master_files/sound/items/blow_horn.ogg', 150, TRUE)
			if (hearing_player != user)
				hearing_player.show_message(span_warning("Somewhere to the [direction_text], a horn calls out in a pattern: '[tune_played]'."))
	user.adjustStaminaLoss(BHORN_STAMINA_USE)

/// Switches the current tune of the horn to the next in the list
/obj/item/blowing_horn/proc/switch_tune(mob/user)
	current_tune_index++
	if (current_tune_index > tune_patterns.len)
		current_tune_index = 1
	to_chat(user, span_notice("You prepare to sound the horn with the pattern: '[tune_patterns[current_tune_index]]'."))

/// Adds additional info to horn examination
/obj/item/blowing_horn/examine(mob/user)
	. = ..()
	if (!in_range(user, src)) return
	. += span_notice("Currently selected tune: <b>[tune_patterns[current_tune_index]]</b>")

/// War horn structure variant (stationary object)
/obj/structure/war_horn
	name = "War horn"
	desc = "A horn older than memory, shaped by hands long vanished. When it sounds, the ground listens. The breath of old wars still lingers in its coil. One call, and those who remember will answer. (Alt-Click to switch tune.)"
	icon = 'modular_nova/modules/tribal_extended/icons/items_and_weapons.dmi'
	icon_state = "war_horn"
	resistance_flags = FLAMMABLE
	anchored = TRUE
	var/list/tune_patterns = list("short short long", "long short", "short long short", "long long", "short short short")
	var/current_tune_index = 1

/// Switch war horn tune on alt-click
/obj/structure/war_horn/click_alt(mob/living/user)
	switch_tune(user)
	return CLICK_ACTION_SUCCESS

/// Plays war horn sound globally to all valid players
/obj/structure/war_horn/attack_hand(mob/living/user)
	if (!ishuman(user) || user.getStaminaLoss() > WHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return
	else if (user.is_mouth_covered())
		balloon_alert(user, "Something is in the way.")
	var/location = get_turf(user)
	var/tune_played = tune_patterns[current_tune_index]
	var/loc_text = "the molten wastes of Indecipheres"
	if (SSmapping.level_trait(2, ZTRAIT_ICE_RUINS_UNDERGROUND) && SSmapping.level_trait(3, ZTRAIT_ICE_RUINS_UNDERGROUND))
		loc_text = "the depths of Freyja's caves"
	user.visible_message(
		span_emote("[user] braces and lets out a thunderous blast on the war horn."),
		span_warning("You blow the war horn with all your strength.")
	)
	for (var/mob/hearing_player in GLOB.player_list)
		if (!is_mining_level(hearing_player.z) || !hearing_player.can_hear())
			continue
		hearing_player.show_message(span_big("The sound of a war horn echoes from [loc_text] — its rhythm: '[tune_played]'."))
		hearing_player.playsound_local(location, 'modular_nova/master_files/sound/items/war_horn.ogg', 150, TRUE)
	user.adjustStaminaLoss(WHORN_STAMINA_USE)

/// Switches the current tune of the horn to the next in the list
/obj/structure/war_horn/proc/switch_tune(mob/user)
	current_tune_index++
	if (current_tune_index > tune_patterns.len)
		current_tune_index = 1
	to_chat(user, span_notice("You prepare to sound the horn with the pattern: '[tune_patterns[current_tune_index]]'."))

/// Adds additional info to horn examination
/obj/structure/war_horn/examine(mob/user)
	. = ..()
	if (!in_range(user, src)) return
	. += span_notice("Currently selected tune: <b>[tune_patterns[current_tune_index]]</b>")

/// Cleanup macros
#undef BHORN_STAMINA_MINIMUM
#undef WHORN_STAMINA_MINIMUM
#undef BHORN_STAMINA_USE
#undef WHORN_STAMINA_USE
