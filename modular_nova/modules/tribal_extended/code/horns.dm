/// Constants for stamina usage and thresholds for both horn types
#define BHORN_STAMINA_MINIMUM 11
#define WHORN_STAMINA_MINIMUM 1
#define BHORN_STAMINA_USE 10
#define WHORN_STAMINA_USE 50

/// Blowing horn item variant (carried by players)
/obj/item/blowing_horn
	name = "blowing horn"
	desc = "A crude instrument fashioned from a beast’s horn, once used to rally kin during goblin raids — or so the stories go."
	icon = 'modular_nova/modules/tribal_extended/icons/items_and_weapons.dmi'
	icon_state = "blow_horn"
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_SUITSTORE
	///List of tunes that can be selected when using the item.
	var/list/tune_patterns = list("short short long", "long short", "short long short", "long long", "short short short")
	///Currently selected tune in the previous list.
	var/current_tune = "short short long"
	COOLDOWN_DECLARE(bhorn_cooldown)

/obj/item/blowing_horn/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/blowing_horn/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(!user.is_holding(src))
		return
	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Switch tune"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/blowing_horn/examine(mob/user)
	. = ..()
	. += span_notice("Switch tune with [EXAMINE_HINT("Shift+Ctrl+Click")].")

/// Switch horn tune on ctrl+shift click
/obj/item/blowing_horn/click_ctrl_shift(mob/user)
	switch_tune(user)

/// Blows the horn if the user has enough stamina
/obj/item/blowing_horn/attack_self(mob/living/user)
	if (user.getStaminaLoss() > BHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired!")
		return
	var/bhorn_origin = get_turf(user)
	if (user.is_mouth_covered())
		balloon_alert(user, "Something is in the way!")
		return
	else if (isspaceturf(bhorn_origin))
		user.visible_message(
			span_emote("[user] raises the horn and blows into the void of space. Nothing happens."),
			span_notice("You try to blow the horn into the vacuum of space. What did you expect?")
		)
		return
	if(!COOLDOWN_FINISHED(src, bhorn_cooldown))
		balloon_alert(user, "wait [COOLDOWN_TIMELEFT(src, bhorn_cooldown) / 10] seconds!")
		return
	else
		user.visible_message(
			span_emote("[user] raises the horn and blows it with all their strength."),
			span_notice("You blow the horn as hard as you can.")
		)
		for (var/mob/hearing_player as anything in SSmobs.clients_by_zlevel[user.z])
			if (get_dist(hearing_player, user) >= 170)
				continue
			if (!hearing_player.can_hear())
				continue
			var/direction_text = span_bold("[dir2text(get_dir(get_turf(hearing_player), bhorn_origin))]")
			hearing_player.playsound_local(bhorn_origin, 'modular_nova/master_files/sound/items/blow_horn.ogg', 150, TRUE)
			if (hearing_player != user)
				hearing_player.show_message(span_warning("Somewhere to the [direction_text], a horn calls out in a pattern: '[current_tune]'."))
	user.adjustStaminaLoss(BHORN_STAMINA_USE)
	COOLDOWN_START(src, bhorn_cooldown, 5.5 SECONDS)

/// Switches the current tune of the horn to the next in the list
/obj/item/blowing_horn/proc/switch_tune(mob/user)
	var/selected_tune = tgui_input_list(user, "Select a tune to play", "Tunes available", tune_patterns)
	if(isnull(selected_tune))
		return
	current_tune = selected_tune
	to_chat(user, span_notice("You prepare to sound the horn with the pattern: '[current_tune]'."))

/// Adds additional info to horn examination
/obj/item/blowing_horn/examine(mob/user)
	. = ..()
	if (!in_range(user, src))
		return
	. += span_notice("Currently selected tune: <b>[current_tune]</b>")
	. += span_notice("Switch tune with [EXAMINE_HINT("Shift+Ctrl+Click")].")

/// War horn structure variant (stationary object)
/obj/structure/war_horn
	name = "war horn"
	desc = "A horn older than memory, shaped by hands long vanished. When it sounds, the ground listens. The breath of old wars still lingers in its coil. One call, and those who remember will answer. (Alt-Click to switch tune.)"
	icon = 'modular_nova/modules/tribal_extended/icons/items_and_weapons.dmi'
	icon_state = "war_horn"
	resistance_flags = FLAMMABLE
	anchored = TRUE
	///List of tunes that can be selected when using the structure.
	var/list/tune_patterns = list("short short long", "long short", "short long short", "long long", "short short short")
	///Currently selected tune in the previous list.
	var/current_tune = "short short long"
	COOLDOWN_DECLARE(whorn_cooldown)

/obj/structure/war_horn/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/war_horn/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if (!in_range(user, src))
		return
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Switch tune"
	return CONTEXTUAL_SCREENTIP_SET

/// Adds additional info to horn examination
/obj/structure/war_horn/examine(mob/user)
	. = ..()
	if (!in_range(user, src))
		return
	. += span_notice("Switch tune with [EXAMINE_HINT("Alt+Click")].")
	. += span_notice("Currently selected tune: <b>[current_tune]</b>")

/// Switch war horn tune on alt-click
/obj/structure/war_horn/click_alt(mob/living/user)
	switch_tune(user)
	return CLICK_ACTION_SUCCESS

/// Plays war horn sound globally to all valid players
/obj/structure/war_horn/attack_hand(mob/living/user)
	if (!ishuman(user))
		balloon_alert(user, "you cannot use this!")
		return
	if (user.getStaminaLoss() > WHORN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired!")
		return
	if (user.is_mouth_covered())
		balloon_alert(user, "something is in the way!")
		return
	if(!COOLDOWN_FINISHED(src, whorn_cooldown))
		balloon_alert(user, "wait [COOLDOWN_TIMELEFT(src, whorn_cooldown) / 10] seconds!")
		return
	///This shouldn't happen as the war horn spawns in the natives camps and isn't movable.
	var/location = get_turf(user)
	if (!is_mining_level(user.z))
		user.visible_message(
			span_emote("[user] braces and lets out a weak sound from the instrument, tuned for a different atmosphere."),
			span_warning("You blow the war horn, but it lets out a weak sound, tuned for a different atmosphere.")
		)
		playsound(location, 'modular_nova/modules/admin/sound/duckhonk.ogg', 100, TRUE)
		return
	var/loc_text = "the molten wastes of Indecipheres"
	if (SSmapping.level_trait(user.z, ZTRAIT_ICE_RUINS_UNDERGROUND))
		loc_text = "the depths of Freyja's caves"
	user.visible_message(
		span_emote("[user] braces and lets out a thunderous blast on the war horn."),
		span_warning("You blow the war horn with all your strength.")
	)
	for (var/mob/hearing_player in GLOB.player_list)
		if (!is_mining_level(hearing_player.z) || !hearing_player.can_hear())
			continue
		hearing_player.show_message(span_big("The sound of a war horn echoes from [loc_text] — its rhythm: '[current_tune]'."))
		hearing_player.playsound_local(location, 'modular_nova/master_files/sound/items/war_horn.ogg', 150, TRUE)
	user.adjustStaminaLoss(WHORN_STAMINA_USE)
	COOLDOWN_START(src, whorn_cooldown, 11.5 SECONDS)


/// Switches the current tune of the horn to the next in the list
/obj/structure/war_horn/proc/switch_tune(mob/user)
	var/selected_tune = tgui_input_list(user, "Select a tune to play", "Tunes available", tune_patterns)
	if(isnull(selected_tune))
		return
	current_tune = selected_tune
	to_chat(user, span_notice("You prepare to sound the horn with the pattern: '[current_tune]'."))

/// Cleanup macros
#undef BHORN_STAMINA_MINIMUM
#undef WHORN_STAMINA_MINIMUM
#undef BHORN_STAMINA_USE
#undef WHORN_STAMINA_USE
