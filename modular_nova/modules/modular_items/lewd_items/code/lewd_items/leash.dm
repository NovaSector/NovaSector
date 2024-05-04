/obj/item/clothing/erp_leash
	name = "leash"
	desc = "A guiding hand's best friend; in a sleek, semi-elastic package. Can either clip to a collar or be affixed to the neck on its own."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	icon_state = "neckleash_pink"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	slot_flags = ITEM_SLOT_BELT
	/// Who's this attached to?
	var/mob/living/currently_leashed

	unique_reskin = list(
		"Pink" = "neckleash_pink",
		"Teal" = "neckleash_teal",
	)

	COOLDOWN_DECLARE(tug_cd)

/// HERE BE DRAGONS ///

/// Checks; leashing start
/obj/item/clothing/erp_leash/attack(mob/living/carbon/human/to_be_leashed, mob/living/user, params)
	/// Are they already leashed by another leash? If so; don't go further.
	for(var/datum/component/leash/leash_component in to_be_leashed.GetComponents(/datum/component/leash))
		if(leash_component.owner != src)
			to_chat(user, span_danger("There's a leash attached to [to_be_leashed] already!"))
			return
	/// Do we have the target already leashed? If so; proceed to remove the leash.
	if(to_be_leashed == currently_leashed)
		remove_leash(currently_leashed)
		return
	/// Check if we even CAN leash someone / if we already have someone leashed / if someone is leashing themselves. If so; prevent it.
	if(!istype(to_be_leashed) || currently_leashed != null || user == to_be_leashed)
		return
	/// Check their ERP prefs; if they don't allow sextoys: BTFO
	if(!to_be_leashed.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[to_be_leashed] doesn't want you to do that."))
		return
	/// Actually start the leashing part here
	to_be_leashed.visible_message(span_warning("[user] raises the [src] to [to_be_leashed]'s neck!"),\
				span_userdanger("[user] starts to bring the [src] to your neck!"),\
				span_hear("You hear a light click as pressure builds in the air around your neck."))
	if(!do_after(user, 2 SECONDS, to_be_leashed))
		return
	currently_leashed = to_be_leashed
	create_leash(currently_leashed)
	currently_leashed.balloon_alert(user, "leashed!")

/obj/item/clothing/erp_leash/attack_self(mob/user, modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, tug_cd))
		return
	if(istype(currently_leashed, /mob/living))
		var/mob/living/yoinked = currently_leashed
		yoinked.Move(get_step_towards(yoinked,user))
		yoinked.adjustStaminaLoss(10)
		yoinked.visible_message(span_warning("[yoinked] is pulled in as [user] tugs the [src]!"),\
				span_userdanger("[user] suddenly tugs the [src], pulling you closer!"),\
				span_userdanger("A sudden tug against your neck pulls you ahead!"))
	COOLDOWN_START(src, tug_cd, 1 SECONDS)

/// Leash Initialization
/obj/item/clothing/erp_leash/proc/create_leash(mob/ouppy)
	if(!istype(ouppy))
		return
	ouppy.AddComponent(/datum/component/leash, src, 2)

/// Leash Removal
/obj/item/clothing/erp_leash/proc/remove_leash(mob/free_bird)
	if(!istype(free_bird))
		return
	free_bird.balloon_alert_to_viewers("unhooked")
	for(var/datum/component/leash/leash_component in free_bird.GetComponents(/datum/component/leash))
		if(leash_component.owner == src) // We don't want to remove any other possible leash components - not that they'd play nice regardless.
			qdel(leash_component)
		currently_leashed = null

/// Dropped it
/obj/item/clothing/erp_leash/dropped(mob/user, silent)
	. = ..()
	remove_leash(currently_leashed)

/// Clean up when destroyed
/obj/item/clothing/erp_leash/Destroy()
	remove_leash(currently_leashed)
	. = ..()
