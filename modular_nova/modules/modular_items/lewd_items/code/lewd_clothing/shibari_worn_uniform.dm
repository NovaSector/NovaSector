/obj/item/clothing/under/shibari
	strip_delay = 100
	can_adjust = FALSE
	body_parts_covered = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	item_flags = DROPDEL
	greyscale_colors = "#bd8fcf"
	has_sensor = NO_SENSORS
	/// Tightness of the ropes can be low, medium and hard. This var works as multiplier for arousal and pleasure received while wearing this item
	var/tightness = SHIBARI_TIGHTNESS_LOW
	/// Should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/under/shibari/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = alpha)

/obj/item/clothing/under/shibari/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = standing.alpha)

/obj/item/clothing/under/shibari/Destroy(force)
	STOP_PROCESSING(SSobj, src)

	// Safely spill any rope pieces only if both the piece and a turf exist
	var/turf/valid_turf = get_turf(src)
	for(var/obj/item/stack/shibari_rope/rope_piece in contents)
		if(!QDELETED(rope_piece) && rope_piece.loc && valid_turf)
			rope_piece.forceMove(valid_turf)

	if(!ishuman(loc))
		return ..()

	var/mob/living/carbon/human/hooman = loc
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()

/obj/item/clothing/under/shibari/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	// Merge of both previous overrides: register signal + start processing + apply status
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_take_off), user)

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/hooman = user
	if(src == hooman.w_uniform)
		START_PROCESSING(SSobj, src)
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.apply_status_effect(/datum/status_effect/ropebunny)

/obj/item/clothing/under/shibari/dropped(mob/user, slot)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()

/obj/item/clothing/under/shibari/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_take_off_async), user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/shibari/proc/handle_take_off_async(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
		dropped(user)

/obj/item/clothing/under/shibari/click_alt(mob/user)
	if(!ishuman(loc))
		return CLICK_ACTION_BLOCKING
	var/mob/living/carbon/human/hooman = loc
	if(user == hooman)
		return CLICK_ACTION_BLOCKING

	switch(tightness)
		if(SHIBARI_TIGHTNESS_LOW)
			tightness = SHIBARI_TIGHTNESS_MED
		if(SHIBARI_TIGHTNESS_MED)
			tightness = SHIBARI_TIGHTNESS_HIGH
		if(SHIBARI_TIGHTNESS_HIGH)
			tightness = SHIBARI_TIGHTNESS_LOW

	return CLICK_ACTION_SUCCESS

/obj/item/clothing/under/shibari/process(seconds_per_tick)
	if(!ishuman(loc))
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc

	// If our client disables their pref mid "roleplaying"
	if(!hooman?.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		var/turf/valid_turf = get_turf(src)
		if(valid_turf)
			src.forceMove(valid_turf)
		src.dropped(hooman)
		return PROCESS_KILL

	// Only act on current tightness (no multi-check fallthrough)
	if(tightness == SHIBARI_TIGHTNESS_LOW)
		if(hooman.arousal < 15)
			hooman.adjust_arousal(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_MED)
		if(hooman.arousal < 25)
			hooman.adjust_arousal(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_HIGH)
		if(hooman.arousal < 30)
			hooman.adjust_arousal(0.6 * seconds_per_tick)

/obj/item/clothing/under/shibari/torso
	name = "shibari ropes"
	desc = "Nice looking rope bondage."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shibari/torso"
	post_init_icon_state = "shibari_body"
	greyscale_config = /datum/greyscale_config/shibari/body
	greyscale_config_worn = /datum/greyscale_config/shibari/body/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/body/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/body/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/body/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/body/worn/taur_hoof
	greyscale_colors = "#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/torso/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return

	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.pain < 25)
		hooman.adjust_pain(0.6 * seconds_per_tick)

/obj/item/clothing/under/shibari/groin
	name = "crotch rope shibari"
	desc = "A rope that teases the wearer's genitals."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shibari/groin"
	post_init_icon_state = "shibari_groin"
	greyscale_config = /datum/greyscale_config/shibari/groin
	greyscale_config_worn = /datum/greyscale_config/shibari/groin/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/groin/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/groin/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/groin/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/groin/worn/taur_hoof
	greyscale_colors = "#bd8fcf"

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari/groin/equipped(mob/living/user, slot)
	var/mob/living/carbon/human/hooman = user
	slowdown = hooman?.bodyshape & BODYSHAPE_TAUR ? 4 : 0
	return ..()

//processing stuff
/obj/item/clothing/under/shibari/groin/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return

	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW)
		if(hooman.pleasure < 20)
			hooman.adjust_pleasure(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_MED)
		if(hooman.pleasure < 60)
			hooman.adjust_pleasure(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)

/obj/item/clothing/under/shibari/full
	name = "shibari fullbody ropes"
	desc = "Bondage ropes that cover the whole body."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shibari/full"
	post_init_icon_state = "shibari_fullbody"
	greyscale_config = /datum/greyscale_config/shibari/fullbody
	greyscale_config_worn = /datum/greyscale_config/shibari/fullbody/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/fullbody/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/fullbody/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/fullbody/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/fullbody/worn/taur_hoof
	greyscale_colors = "#bd8fcf#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/full/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return

	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW)
		if(hooman.pleasure < 20)
			hooman.adjust_pleasure(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_MED)
		if(hooman.pleasure < 60)
			hooman.adjust_pleasure(0.6 * seconds_per_tick)
	else if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
		if(hooman.pain < 40)
			hooman.adjust_pain(0.6 * seconds_per_tick)
