/// LUNA ///
// The sword itself
/obj/item/claymore/cutlass/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'modular_nova/modules/mapping/icons/obj/weapons/sword.dmi'
	lefthand_file = 'modular_nova/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"
	slot_flags = null // Let's not.
	w_class = WEIGHT_CLASS_HUGE // This is a SWORD, coward
	light_color = LIGHT_COLOR_LIGHT_CYAN
	light_system = OVERLAY_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	force = 15
	throwforce = 10
	bare_wound_bonus = 35 // If your target's unarmored; lol. Lmao
	armour_penetration = 10 // Sharp enough to poke by default; but not exactly cleaving through any armor without the energy upgrade
	block_chance = 20 // Definitely agile enough to block; but keep in mind it's a rapier and not a bulkier sword
	sharpness = SHARP_POINTY // RAPIER. RAPIER. RAPIER!!!!
	special_desc = "Corporate has this thing earmarked - someone pitched them that it's existence heralded an external dissident, and they've been quaking in their boots since. \
	In contrast; local reaction is much more... muted - most involved with today's deployment already used to it being nearby."
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_DETECTIVE)
	var/list/fragments = list()
	var/can_bloodbeam = FALSE

/obj/item/claymore/cutlass/luna/examine(mob/living/user)
	. = ..()
	. += span_notice("The design looks modular - it's possible you might be able to find additional pieces to attach.")
	for(var/f in fragments)
		var/obj/item/luna_fragment/fragment = f
		. += span_notice("\a [fragment] has been attached, allowing for Luna to [fragment.effect_desc]")

/obj/item/claymore/cutlass/luna/Destroy()
	QDEL_LIST(fragments)
	return ..()

/obj/item/claymore/cutlass/luna/Exited(atom/movable/gone, direction)
	. = ..()
	fragments -= gone

/obj/item/claymore/cutlass/luna/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(fragments))
			to_chat(user, span_notice("You remove [src]'s array of addons."))
			I.play_tool_sound(src)
			for(var/f in fragments)
				var/obj/item/luna_fragment/Fragment = f
				Fragment.remove_upgrade(src, user)
		else
			to_chat(user, span_warning("[src] is bare of any additional baubles."))
	else if(istype(I, /obj/item/luna_fragment))
		var/obj/item/luna_fragment/F = I
		F.apply_upgrade(src, user)
	else
		return ..()

/obj/item/claymore/cutlass/luna/attack_secondary(atom/target, mob/living/user, clickparams)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/claymore/cutlass/luna/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!can_bloodbeam)
		return
	if(interacting_with == user)
		balloon_alert(user, "can't aim at yourself!")
		return ITEM_INTERACT_BLOCKING
	send_sword_laser(interacting_with, user, modifiers)
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS

/obj/item/claymore/cutlass/luna/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom_secondary(interacting_with, user, modifiers)

/obj/item/claymore/cutlass/luna/proc/send_sword_laser(atom/target, mob/living/user, list/modifiers)
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return
	var/obj/projectile/beam/weak/penetrator/sord_beam = new(proj_turf)
	sord_beam.aim_projectile(target, user, modifiers)
	sord_beam.firer = user
	sord_beam.fired_from = src
	playsound(user, 'sound/items/weapons/resonator_blast.ogg', 90, TRUE)
	sord_beam.fire()
	user.apply_damage(25, STAMINA, BODY_ZONE_CHEST) // Spam these and pay the price of self-ownage
	user.blood_volume -= 10 // 560 is normal blood volume

/// Upgrades ///

/obj/item/luna_fragment
	name = "coder's bane"
	desc = "report this on github! unless you got this from a christmas present!"
	icon = 'modular_nova/modules/mapping/icons/obj/items/jungle_items.dmi'
	var/effect_desc = "Does literally nothing."
	var/has_spoken = FALSE
	var/hallucination_sound = 'sound/effects/hallucinations/im_here1.ogg'
	var/hallucination_text = "Why.. do those stupid smelly nerds... not put an EXE file.. on the github..."

/obj/item/luna_fragment/proc/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	for(var/obj/item/luna_fragment/trophy as anything in upgrade_appliable.fragments)
		if(istype(src, trophy))
			to_chat(user, span_warning("You can't seem to attach [src] to [upgrade_appliable]."))
			return FALSE
	if(!user.transferItemToLoc(src, upgrade_appliable))
		return
	upgrade_appliable.fragments += src
	balloon_alert(user, "upgrade applied")
	to_chat(user, span_notice("You attach [src] to [upgrade_appliable]."))
	if(!has_spoken)
		var/mob/taylor = user
		taylor.playsound_local(src.loc, hallucination_sound, 30, FALSE, 3)
		to_chat(user, span_blue(hallucination_text))
	return

/obj/item/luna_fragment/proc/remove_upgrade(our_sord, mob/living/user)
	return

/obj/item/luna_fragment/examine(mob/living/user)
	. = ..()
	. += span_notice("This device looks rather.. \"home cooked\". You'll likely need a specific sword in order to make use of it.")
	if(has_spoken)
		. += span_blue(hallucination_text) // If you're gonna take it back outta the sword, you should at least be able to revisit the text.

/// Blood Beam
/obj/item/luna_fragment/blood_beam
	name = "\improper H.P.A."
	desc = "A \"hemophilic projectile apparatus\". In practice; it trades some of the electrical activity in the user's brain and some of their blood to fire off an armor-piercing laser, to be attached \
	conveinently under cross-guard of a blade. Science CAN be metal!"
	icon_state = "hpa"
	effect_desc = "shoot a laser beam when right-clicking, in exchange for your stamina - and some blood."
	hallucination_text = "Calm. Safe - A clearing. Trees that stretched on up unto the sky itself; covered in constant falls of new snowflakes on my skin. I wasn't cold."

/obj/item/luna_fragment/blood_beam/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.can_bloodbeam = TRUE // This sucks and I'd love to refactor it but I have to brush up a bit more before I'm ready for components;
	return ..()

/obj/item/luna_fragment/blood_beam/remove_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.can_bloodbeam = FALSE
	return ..()

/// Energy Retrofit
/// Sets LUNA's stats to be on par with a standard energy blade - for better and worse.
/obj/item/luna_fragment/energy_retrofit
	name = "\improper energy projection matrix"
	desc = "A small; egg-shaped device - kitbashed from a hardlight projector, a x-ray focused laser diode, and, of all things - a flashlight; to be applied directly against the grip of a sword - trading \
	the comfort of your thumb for a hardlight blade."
	icon_state = "energy_retrofit"
	effect_desc = "use a hardlight blade as a coating over it's own; trading it's strengths and weaknesses for that of an energy sword."
	hallucination_sound = 'sound/effects/hallucinations/im_here2.ogg'
	hallucination_text = "The lightest, most beautiful snowflakes I'd ever seen raining down upon me. I wasn't cold. I couldn't be. It couldn't overcome the warmth of my beating heart."

/obj/item/luna_fragment/energy_retrofit/apply_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.icon_state = "luna_energy"
	upgrade_appliable.inhand_icon_state = "luna_energy"
	update_inhand_icon(user)
	upgrade_appliable.set_light_on(TRUE)
	playsound(upgrade_appliable, 'sound/items/weapons/saberon.ogg', 35, TRUE)
	upgrade_appliable.force = /obj/item/melee/energy/sword::active_force
	upgrade_appliable.throwforce = /obj/item/melee/energy/sword::active_throwforce
	upgrade_appliable.bare_wound_bonus = /obj/item/melee/energy/sword::bare_wound_bonus
	upgrade_appliable.demolition_mod = /obj/item/melee/energy/sword::demolition_mod
	upgrade_appliable.armour_penetration = /obj/item/melee/energy/sword::armour_penetration
	upgrade_appliable.block_chance = /obj/item/melee/energy/sword::block_chance
	return ..()

/obj/item/luna_fragment/energy_retrofit/remove_upgrade(our_sord, mob/living/user)
	var/obj/item/claymore/cutlass/luna/upgrade_appliable = our_sord
	upgrade_appliable.icon_state = "luna"
	upgrade_appliable.inhand_icon_state = "luna"
	update_inhand_icon(user)
	upgrade_appliable.set_light_on(FALSE)
	playsound(upgrade_appliable, 'sound/items/weapons/saberoff.ogg', 35, TRUE)
	upgrade_appliable.force = initial(force)
	upgrade_appliable.throwforce = initial(throwforce)
	upgrade_appliable.bare_wound_bonus = initial(bare_wound_bonus)
	upgrade_appliable.demolition_mod = initial(demolition_mod)
	upgrade_appliable.armour_penetration = initial(armour_penetration)
	upgrade_appliable.block_chance = initial(block_chance)
	return ..()



/obj/item/mod/module/armor_booster/retractplates
	name = "MOD retractive plates module"
	desc = "A complex set of actuators, micro-seals and a simple guide on how to install it, This... \"Modification\" allows the plating around the joints to retract, giving minor protection and a bit better mobility."
	removable = TRUE
	complexity = 1
	space_slowdown = 0.25
	armor_mod = /datum/armor/retractive_plates

/datum/armor/retractive_plates
	melee = 20
	bullet = 25
	laser = 15
	energy = 20

/obj/machinery/vending/security/noaccess
	req_access = null

/obj/structure/closet/secure_closet/medical2/unlocked/Initialize(mapload)
	. = ..()
	locked = FALSE
	update_appearance()
