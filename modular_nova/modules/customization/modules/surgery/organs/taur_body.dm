#define LAYDOWN_COOLDOWN 1 SECONDS

/obj/item/organ/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	external_bodyshapes = BODYSHAPE_TAUR
	use_mob_sprite_as_obj_sprite = TRUE

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL
	mutantpart_key = FEATURE_TAUR
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	bodypart_overlay = /datum/bodypart_overlay/mutant/taur_body

	/// If not null, the left leg limb we add to our mob will have this name.
	var/left_leg_name = "front legs"
	/// If not null, the right leg limb we add to our mob will have this name.
	var/right_leg_name = "back legs"

	/// The mob's old right leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/datum/weakref/old_left_leg
	/// The mob's old left leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/datum/weakref/old_right_leg

	/// If true, our sprite accessory will not render.
	var/hide_self

	/// If true, this taur body allows a saddle to be equipped and used.
	var/can_use_saddle = FALSE

	/// If true, can ride saddled taurs and be ridden by other taurs with this set to TRUE.
	var/can_ride_saddled_taurs = FALSE

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing west or east.
	var/riding_offset_side_x = 12
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing west or east.
	var/riding_offset_side_y = 2

	/// When being ridden via saddle, how much the rider is offset on the x axis when facing north or south.
	var/riding_offset_front_x = 0
	/// When being ridden via saddle, how much the rider is offset on the y axis when facing north or south.
	var/riding_offset_front_y = 5

	/// Lazylist of (TEXT_DIR -> y offset) to be applied to taur-specific clothing that isn't specifically made for this sprite.
	var/list/taur_specific_clothing_y_offsets

	/// When considering how much to offset our rider, we multiply size scaling against this.
	var/riding_offset_scaling_mult = 0.8
	/// If TRUE, this taur body gets the hardened soles trait and doesn't wear shoes
	var/hardened_soles
	/// Did our owner have their feet blocked before we ran on_mob_insert? Used for determining if we should unblock their feet slots on removal.
	var/owner_blocked_feet_before_insert

/obj/item/organ/taur_body/horselike
	can_use_saddle = TRUE

/obj/item/organ/taur_body/horselike/synth
	organ_flags = ORGAN_ROBOTIC | ORGAN_EXTERNAL

/obj/item/organ/taur_body/horselike/deer

/obj/item/organ/taur_body/horselike/deer/Initialize(mapload)
	. = ..()

	taur_specific_clothing_y_offsets = list(
		TEXT_EAST = 3,
		TEXT_WEST = 3,
		TEXT_NORTH = 0,
		TEXT_SOUTH = 0,
	)

/obj/item/organ/taur_body/fishlike
	left_leg_name = "upper body"
	right_leg_name = "lower body"
	hardened_soles = TRUE
	/// Action to toggle on/off mermaid form
	var/datum/action/cooldown/spell/mermaid_toggle/mermaid_toggle

/obj/item/organ/taur_body/fishlike/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	if(isnull(mermaid_toggle))
		mermaid_toggle = new
	if(!(mermaid_toggle in receiver.actions))
		mermaid_toggle.Grant(receiver)

/obj/item/organ/taur_body/fishlike/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(mermaid_toggle && !mermaid_toggle.in_mermaid_form) // Somehow we lost our taur part while in human form--this shouldn't happen.
		mermaid_toggle.transform_to_mermaid(organ_owner)
		mermaid_toggle.Remove(organ_owner)

/obj/item/organ/taur_body/fishlike/Destroy(force)
	if(mermaid_toggle)
		QDEL_NULL(mermaid_toggle)
	return ..()

/datum/action/cooldown/spell/mermaid_toggle
	name = "Grow Legs"
	desc = "Grow legs and walk on land."
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "deactivate_wash"

	cooldown_time = 5 SECONDS
	spell_requirements = NONE

	/// Weakref to the stored mermaid body (when legs are active)
	var/datum/weakref/stored_mermaid_body
	/// Are we currently in mermaid form?
	var/in_mermaid_form = TRUE

/datum/action/cooldown/spell/mermaid_toggle/update_button_name(atom/movable/screen/movable/action_button/button, force)
	if(in_mermaid_form)
		name = initial(name)
		desc = initial(desc)
	else
		name = "Mermaid Transform"
		desc = "Return to your mermaid form."
	return ..()

/datum/action/cooldown/spell/mermaid_toggle/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(in_mermaid_form)
		button_icon_state = initial(button_icon_state)
	else
		button_icon_state = "activate_wash"

	return ..()

/obj/effect/temp_visual/mermaid_transform
	name = "mermaidbubbles"
	icon_state = "bubbles"

/obj/effect/temp_visual/mermaid_transform/Initialize(mapload)
	pixel_z -= 8
	alpha = 128
	return ..()

/datum/action/cooldown/spell/mermaid_toggle/cast(mob/living/carbon/human/user = usr)
	. = ..()

	if(in_mermaid_form)
		transform_to_legs(user)
	else
		transform_to_mermaid(user)
		new /obj/effect/temp_visual/mermaid_transform(get_turf(user))

	in_mermaid_form = !in_mermaid_form
	build_all_button_icons(UPDATE_BUTTON_NAME|UPDATE_BUTTON_ICON)

/datum/action/cooldown/spell/mermaid_toggle/proc/transform_to_legs(mob/living/carbon/human/user)
	var/obj/item/organ/taur_body/fishlike/mermaid_body = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)

	if(!mermaid_body)
		return

	// Store body and remove it
	stored_mermaid_body = WEAKREF(mermaid_body)
	mermaid_body.Remove(user, special = TRUE)
	mermaid_body.moveToNullspace()

/datum/action/cooldown/spell/mermaid_toggle/proc/transform_to_mermaid(mob/living/carbon/human/user)
	var/obj/item/organ/taur_body/fishlike/mermaid_body = stored_mermaid_body?.resolve()

	if(isnull(mermaid_body))
		// Body is gone; reset state so we don't soft-lock
		stored_mermaid_body = null
		in_mermaid_form = TRUE
		return

	mermaid_body.Insert(user)

/obj/item/organ/taur_body/serpentine
	left_leg_name = "upper serpentine body"
	right_leg_name = "lower serpentine body"
	hardened_soles = TRUE

/obj/item/organ/taur_body/serpentine/synth
	organ_flags = ORGAN_ROBOTIC | ORGAN_EXTERNAL

/obj/item/organ/taur_body/spider
	left_leg_name = "left legs"
	right_leg_name = "right legs"

/obj/item/organ/taur_body/tentacle
	left_leg_name = "front tentacles"
	right_leg_name = "back tentacles"

/obj/item/organ/taur_body/blob
	left_leg_name = "outer blob"
	right_leg_name = "inner blob"

/obj/item/organ/taur_body/centipede
	left_leg_name = "dozens of left legs"
	right_leg_name = "dozens of right legs"

/obj/item/organ/taur_body/centipede/synth
	organ_flags = parent_type::organ_flags | ORGAN_ROBOTIC

/obj/item/organ/taur_body/anthro
	left_leg_name = null
	right_leg_name = null

	can_ride_saddled_taurs = TRUE

/obj/item/organ/taur_body/anthro/synth
	organ_flags = ORGAN_ROBOTIC

/datum/bodypart_overlay/mutant/taur_body
	feature_key = FEATURE_TAUR
	layers = ALL_EXTERNAL_OVERLAYS | EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE

	/// If this taur body can lay down
	var/can_lay_down = FALSE
	/// Are we currently laying down?
	var/laying_down = FALSE
	/// The offset we get from laying down. Negative values move us down
	var/laydown_offset = 0

/datum/bodypart_overlay/mutant/taur_body/on_mob_insert(obj/item/organ/parent, mob/living/carbon/receiver)
	. = ..()
	var/datum/sprite_accessory/taur/accessory = sprite_datum
	if(accessory.can_lay_down)
		can_lay_down = TRUE
		laydown_offset = accessory.laydown_offset

/datum/bodypart_overlay/mutant/taur_body/get_base_icon_state()
	return "[sprite_datum.icon_state][laying_down ? "_laying" : ""]"

/datum/bodypart_overlay/mutant/taur_body/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/taur_body/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_TAUR]

/obj/item/organ/taur_body/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_HIDE_SHOES)
		external_bodyshapes |= BODYSHAPE_HIDE_SHOES

	// Only capture the original legs once.
	// on_mob_insert() can run multiple times across transforms; if we overwrite these
	// while taur legs are already present, we'll "save" the taur legs as the originals
	// and restoration will break.
	var/obj/item/bodypart/leg/left/still_have_left = old_left_leg?.resolve()
	if(old_left_leg && QDELETED(still_have_left))
		old_left_leg = null
	var/obj/item/bodypart/leg/left/still_have_right = old_right_leg?.resolve()
	if(still_have_right && QDELETED(still_have_right))
		old_right_leg = null

	if(!old_left_leg)
		var/obj/item/bodypart/leg/left/current_left = receiver.get_bodypart(BODY_ZONE_L_LEG)
		// Never treat taur legs as "old legs"
		if(current_left && !istype(current_left, /obj/item/bodypart/leg/left/taur) && !istype(current_left, /obj/item/bodypart/leg/left/synth/taur))
			old_left_leg = WEAKREF(current_left)

	if(!old_right_leg)
		var/obj/item/bodypart/leg/right/current_right = receiver.get_bodypart(BODY_ZONE_R_LEG)
		// Never treat taur legs as "old legs"
		if(current_right && !istype(current_right, /obj/item/bodypart/leg/right/taur) && !istype(current_right, /obj/item/bodypart/leg/right/synth/taur))
			old_right_leg = WEAKREF(current_right)

	var/obj/item/bodypart/leg/left/taur/new_left_leg
	var/obj/item/bodypart/leg/right/taur/new_right_leg

	if(organ_flags & ORGAN_ORGANIC)
		new_left_leg = new /obj/item/bodypart/leg/left/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/taur()
	else if(organ_flags & ORGAN_ROBOTIC)
		new_left_leg = new /obj/item/bodypart/leg/left/synth/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/synth/taur()

	if(left_leg_name)
		new_left_leg.name = "[left_leg_name] (Left leg)"
		new_left_leg.plaintext_zone = LOWER_TEXT(new_left_leg.name) // weird otherwise
	if(right_leg_name)
		new_right_leg.name = "[right_leg_name] (Right leg)"
		new_right_leg.plaintext_zone = LOWER_TEXT(new_right_leg.name)


	var/obj/item/clothing/shoes/shoe = receiver.get_item_by_slot(ITEM_SLOT_FEET)
	if(shoe && !HAS_TRAIT(shoe, TRAIT_NODROP))
		receiver.dropItemToGround(shoe, force = TRUE)

	var/obj/item/bodypart/leg/left/left_leg_to_remove = receiver.get_bodypart(BODY_ZONE_L_LEG)
	if(left_leg_to_remove)
		left_leg_to_remove.drop_limb(special = TRUE, move_to_floor = FALSE)
		left_leg_to_remove.moveToNullspace()
	new_left_leg.replace_limb(receiver, special = TRUE)
	new_left_leg.bodyshape |= external_bodyshapes

	var/obj/item/bodypart/leg/right/right_leg_to_remove = receiver.get_bodypart(BODY_ZONE_R_LEG)
	if(right_leg_to_remove)
		right_leg_to_remove.drop_limb(special = TRUE, move_to_floor = FALSE)
		right_leg_to_remove.moveToNullspace()
	new_right_leg.replace_limb(receiver, special = TRUE)
	new_right_leg.bodyshape |= external_bodyshapes

	. = ..()

	var/datum/bodypart_overlay/mutant/taur_body/overlay = bodypart_overlay
	if(overlay.can_lay_down)
		add_verb(receiver, /obj/item/organ/taur_body/proc/toggle_laying)

	if(hardened_soles)
		owner_blocked_feet_before_insert = (receiver.dna.species.no_equip_flags & ITEM_SLOT_FEET)
		receiver.dna.species.no_equip_flags |= ITEM_SLOT_FEET
		receiver.dna.species.modsuit_slot_exceptions |= ITEM_SLOT_FEET

		var/use_hardened_soles = FALSE
		var/datum/preferences/prefs = receiver.client?.prefs
		if(prefs)
			use_hardened_soles = !(prefs.read_preference(/datum/preference/toggle/naga_soles))

		if(use_hardened_soles)
			add_hardened_soles(receiver)

	INVOKE_ASYNC(receiver, TYPE_PROC_REF(/mob, update_clothing), ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING|ITEM_SLOT_FEET|ITEM_SLOT_SUITSTORE)

/obj/item/organ/taur_body/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(QDELETED(organ_owner))
		return ..()

	var/obj/item/bodypart/leg/left/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/right/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

	if(left_leg)
		left_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		qdel(left_leg)

	if(right_leg)
		right_leg.drop_limb(special = TRUE, move_to_floor = FALSE)
		qdel(right_leg)

	var/obj/item/bodypart/leg/left/restore_left = old_left_leg?.resolve()
	if(restore_left)
		restore_left.replace_limb(organ_owner, special = TRUE)
	old_left_leg = null

	var/obj/item/bodypart/leg/right/restore_right = old_right_leg?.resolve()
	if(restore_right)
		restore_right.replace_limb(organ_owner, special = TRUE)
	old_right_leg = null

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodyshapes` has a value.
	remove_verb(organ_owner, /obj/item/organ/taur_body/proc/toggle_laying)

	if(hardened_soles)
		if(!owner_blocked_feet_before_insert)
			organ_owner.dna.species.no_equip_flags &= ~ITEM_SLOT_FEET
		owner_blocked_feet_before_insert = FALSE
		organ_owner.dna.species.modsuit_slot_exceptions &= ~ITEM_SLOT_FEET

		REMOVE_TRAIT(organ_owner, TRAIT_HARD_SOLES, ORGAN_TRAIT)

	. = ..()

	// Make sure we update the mob's clothing sprites to reflect their new legs, but ensure we do it after we finish this call chain so everything is updated correctly
	spawn(0)
		organ_owner.update_clothing(ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING|ITEM_SLOT_FEET|ITEM_SLOT_SUITSTORE)

/obj/item/organ/taur_body/Destroy()
	. = ..()
	if(old_left_leg)
		var/obj/item/bodypart/leg/left/left_leg = old_left_leg.resolve()
		if(isnull(left_leg.loc)) // Only delete these if they aren't on the mob at this point
			qdel(left_leg)

	if(old_right_leg)
		var/obj/item/bodypart/leg/right/right_leg = old_right_leg.resolve()
		if(isnull(right_leg.loc))
			qdel(right_leg)

/obj/item/organ/taur_body/proc/get_riding_offset(oversized = FALSE)
	var/size_scaling = (owner.dna.features["body_size"] / BODY_SIZE_NORMAL) - 1
	var/scaling_mult = 1 + (size_scaling * riding_offset_scaling_mult)

	return list(
		TEXT_NORTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_NORTH]) * scaling_mult, 1)),
		TEXT_SOUTH = list(riding_offset_front_x, round((riding_offset_front_y + taur_specific_clothing_y_offsets?[TEXT_SOUTH]) * scaling_mult, 1)),
		TEXT_EAST = list(round(-riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_EAST]) * scaling_mult, 1)),
		TEXT_WEST = list(round(riding_offset_side_x * scaling_mult, 1), round((riding_offset_side_y + taur_specific_clothing_y_offsets?[TEXT_WEST]) * scaling_mult, 1)),
	)

// Following verb 'toggle_laying' toggles the laying down state for a taur-bodied character.
// It manages the visual changes, layer adjustments, and appplys/removes relevant traits during the state change.
// This action has a cooldown period upon apply or removal to prevent rapid toggling.
// Behaviour expectations:
// Only works if the owner is a human with a valid taur body organ. This also can only be triggered if the taur body overlay supports laying down.
// This prevents laying down if the owner is already resting, IE: Prone. Manages the mob's density and adds in a specific sound if laying within gravity.

/obj/item/organ/taur_body/proc/toggle_laying()
	set category = "IC"
	set name = "(Taur) Toggle Laying Down"

	var/mob/living/carbon/human/owner = src
	if(!istype(owner))
		return

	var/obj/item/organ/taur_body/organ = owner.get_organ_by_type(/obj/item/organ/taur_body)
	if(isnull(organ))
		stack_trace("Taur lay down triggered without Taur organ")
		return

	var/datum/bodypart_overlay/mutant/taur_body/overlay = organ.bodypart_overlay
	if(!overlay.can_lay_down)
		return
	if(owner.resting)
		to_chat(owner, span_notice("You have to be standing up in order to lay down properly!"))
	if(overlay.laying_down)
		// Rising up
		to_chat(owner, span_notice("You start lifting your body up."))
		if(!do_after(owner, LAYDOWN_COOLDOWN))
			return
		if(!overlay.laying_down) // Prevent multiple standups at once
			return
		overlay.laying_down = FALSE
		owner.layer = initial(owner.layer)
		owner.pixel_y -= overlay.laydown_offset
		owner.update_body_parts()

		owner.SetImmobilized(0, TRUE)
		REMOVE_TRAIT(owner, TRAIT_UNDENSE, TRAIT_TAUR_LOAF)
		to_chat(owner, span_notice("You stand up."))
	else
		// And laying back down
		overlay.laying_down = TRUE
		owner.layer = LYING_MOB_LAYER
		owner.pixel_y += overlay.laydown_offset
		owner.update_body_parts()

		owner.Immobilize(INFINITY, TRUE)
		ADD_TRAIT(owner, TRAIT_UNDENSE, TRAIT_TAUR_LOAF)
		to_chat(owner, span_notice("You lay down."))
		if(owner.has_gravity())
			playsound(owner, "bodyfall", 50, TRUE)

#undef LAYDOWN_COOLDOWN
