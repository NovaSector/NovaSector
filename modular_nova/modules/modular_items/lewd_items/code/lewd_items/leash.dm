/obj/item/clothing/erp_leash
	name = "leash"
	desc = "A guiding hand's best friend; in a sleek, semi-elastic package. Can either clip to a collar or be affixed to the neck on its own."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	icon_state = "neckleash_pink"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	slot_flags = ITEM_SLOT_BELT
	/// Weakref to the leash component we're using, if it exists.
	var/datum/weakref/our_leash_component

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
	/// Get a ref to our own leash component; and if one exists; handle removing it IF the target meets our requirements.
	var/datum/component/resolved_leash_component = our_leash_component?.resolve()
	if(resolved_leash_component?.parent == to_be_leashed)
		remove_leash(resolved_leash_component.parent)
		return
	/// Check if we even CAN leash someone / if we already have someone leashed / if someone is leashing themselves. If so; prevent it.
	if(!istype(to_be_leashed) || resolved_leash_component || user == to_be_leashed)
		return
	/// Check their ERP prefs; if they don't allow sextoys: BTFO
	/* SHOG DEBUG - DO NOT COMMIT
	if(!to_be_leashed.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[to_be_leashed] doesn't want you to do that."))
		return
	*/
	/// Actually start the leashing part here
	to_be_leashed.visible_message(span_warning("[user] raises the [src] to [to_be_leashed]'s neck!"),\
				span_userdanger("[user] starts to bring the [src] to your neck!"),\
				span_hear("You hear a light click as pressure builds in the air around your neck."))
	if(!do_after(user, 2 SECONDS, to_be_leashed))
		return
	create_leash(to_be_leashed)
	to_be_leashed.balloon_alert(user, "leashed!")

/// Leash Initialization
/obj/item/clothing/erp_leash/proc/create_leash(mob/ouppy)
	if(!istype(ouppy))
		return
	ouppy.AddComponent(/datum/component/leash/erp, src, 2)

/// Leash removal
/obj/item/clothing/erp_leash/proc/remove_leash(mob/free_bird)
	free_bird?.balloon_alert_to_viewers("unhooked")
	qdel(our_leash_component.resolve())

/*
	Leash Component
*/

// 'owner' refers the leash item, while 'parent' refers to the one it's affixed to.
/datum/component/leash/erp/RegisterWithParent()
	. = ..()
	RegisterSignal(owner, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_item_attack_self))
	RegisterSignal(owner, COMSIG_ITEM_DROPPED, PROC_REF(on_item_dropped))

/datum/component/leash/erp/UnregisterFromParent()
	. = ..()
	UnregisterSignal(owner, COMSIG_ITEM_ATTACK_SELF, COMSIG_ITEM_DROPPED)
	return ..()

/datum/component/leash/erp/proc/on_item_attack_self(datum/source, mob/user)
	SIGNAL_HANDLER

	if(istype(source, /obj/item/clothing/erp_leash))
		var/obj/item/clothing/erp_leash/leash_hookin = source
		if(!COOLDOWN_FINISHED(leash_hookin, tug_cd))
			return
		if(istype(parent, /mob/living))
			var/mob/living/yoinked = parent
			yoinked.Move(get_step_towards(yoinked,user))
			yoinked.adjustStaminaLoss(10)
			yoinked.visible_message(span_warning("[yoinked] is pulled in as [user] tugs the [source]!"),\
					span_userdanger("[user] suddenly tugs the [source], pulling you closer!"),\
					span_userdanger("A sudden tug against your neck pulls you ahead!"))
			COOLDOWN_START(leash_hookin, tug_cd, 1 SECONDS)

/datum/component/leash/erp/proc/on_item_dropped(datum/source, mob/user)
	SIGNAL_HANDLER

	qdel(src)
