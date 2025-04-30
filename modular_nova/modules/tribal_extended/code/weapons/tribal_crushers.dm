/obj/item/kinetic_crusher/tribal/runic_greatsword
	name = "Runic Greatsword"
	desc = "A greatsword of Hearthkin make. The runes on the blades glows a soft blue."
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_crushers.dmi'
	icon_state = "runic_greatsword"
	worn_icon = 'modular_nova/modules/tribal_extended/icons/back.dmi'
	worn_icon_state = "runic_greatsword"
	lefthand_file = 'modular_nova/modules/tribal_extended/icons/swords_lefthand.dmi'
	righthand_file = 'modular_nova/modules/tribal_extended/icons/swords_righthand.dmi'
	light_color = "#8DEBFF"
	attack_verb_continuous = list("slashes", "stabs", "slices", "cuts", "pierces", "thrusts", "lacerates", "carves")
	attack_verb_simple = list("slash", "stab", "slice", "cut", "pierce", "thrust", "lacerate", "carve")

/obj/item/kinetic_crusher/tribal/runic_greatsword/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)
	else
		. += emissive_appearance(icon_file, "[inhand_icon_state]-emissive", src, alpha = src.alpha)

/obj/item/kinetic_crusher/tribal/runic_greataxe
	name = "Runic Greataxe"
	desc = "A greataxe of Hearthkin make. The runes on the blades glows a soft blue."
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_crushers.dmi' //Modified sprite from Roguetown
	icon_state = "runic_axe"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "crusher"
	light_color = "#8DEBFF"
	attack_verb_continuous = list("chops", "cleaves", "hacks", "slashes", "sunders", "hewes", "splits", "smashes")
	attack_verb_simple = list("chop", "cleave", "hack", "slash", "sunder", "hew", "split", "smash")

/obj/item/kinetic_crusher/spear/tribal/runic_spear
	name = "Runic Spear"
	desc = "A spear of Hearthkin make. The runes on the blades glows a soft blue."
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_crushers.dmi' //Custom sprite, i'm a bad spriter, mhkay?
	icon_state = "runic_spear"
	light_color = "#8DEBFF"

/// Procs used to add the emissive layer (the runes) to the weapons.
/obj/item/kinetic_crusher/proc/adding_glow()
    return emissive_appearance(
        'modular_nova/modules/tribal_extended/icons/tribal_crushers.dmi',
        "[icon_state]-emissive",
        src,
        alpha = src.alpha
    )

/obj/item/kinetic_crusher/tribal/runic_greatsword/update_overlays()
    . = ..()
    . += adding_glow()

/obj/item/kinetic_crusher/tribal/runic_greataxe/update_overlays()
    . = ..()
    . += adding_glow()

/obj/item/kinetic_crusher/spear/tribal/runic_spear/update_overlays()
    . = ..()
    . += adding_glow()

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

//changed compared to kintetic_crusher.dm. We don't fire a projectile and we don't care if the cursor is over the player.
/obj/item/kinetic_crusher/tribal/runic_greatsword/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(src, TRAIT_WIELDED) && !acts_as_if_wielded)
		balloon_alert(user, "wield it first!")
		return ITEM_INTERACT_BLOCKING
	runic_spin()
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS

/// Marks living things in melee of the user if crusher is charged.
/obj/item/kinetic_crusher/tribal/runic_greatsword/proc/runic_spin()
	if(!charged)
		return
	var/spin_radius = 1
	var/spin_center = get_turf(usr)
	new /obj/effect/temp_visual/runic_spin(spin_center)
	var/list/living_targets = range(spin_radius, spin_center)
	for(var/mob/living/living_target in living_targets)
		if((living_target == usr) || (usr in living_target.buckled_mobs))
			continue
		if(!QDELETED(living_target) && living_target.health > 0)
			for(var/obj/item/crusher_trophy/crusher_trophy as anything in trophies)
				crusher_trophy.on_projectile_hit_mob(living_target, usr)
			living_target.apply_status_effect(/datum/status_effect/crusher_mark)
			living_target.update_appearance()
	for(var/turf/open/aoe in living_targets)
		if(aoe != spin_center)
			new /obj/effect/temp_visual/flying_rune(aoe)
	playsound(usr, 'sound/effects/magic/tail_swing.ogg', 100, TRUE)
	charged = FALSE
	attempt_recharge_runes()

//visual feedback on ability use. Supposedly a glint of the sword's metal.
/obj/effect/temp_visual/runic_spin
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "ring_leader_effect"
	duration = 2

//Visual feedback small rune pops where the marked target is.
/obj/effect/temp_visual/flying_rune
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "small_rune_11"
	duration = 6

/// Handles the timer for reloading the projectile (slight edit of kinetic_crusher.dm)
/obj/item/kinetic_crusher/tribal/proc/attempt_recharge_runes(set_recharge_time)
	if(!set_recharge_time)
		set_recharge_time = charge_time
	deltimer(charge_timer)
	charge_timer = addtimer(CALLBACK(src, PROC_REF(recharge_runes)), set_recharge_time, TIMER_STOPPABLE)

/// Recharges the projectile (slight edit of kinetic_crusher.dm)
/obj/item/kinetic_crusher/tribal/proc/recharge_runes()
	if(!charged)
		charged = TRUE
		playsound(src.loc, 'sound/items/weapons/kinetic_reload.ogg', 60, TRUE)

/obj/item/hearthkin_ship_fragment_inactive
	name = "Dormant fragment of the Stjarndrakkr"
	desc = "A dormant piece of ancient tech, carbon-dated to roughly 300 years ago. One side is etched with strange symbols resembling Ættmál runes. Perhaps the natives could uncover its purpose."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "cult_sharpener_used"
	drop_sound = SFX_STONE_DROP
	pickup_sound = SFX_STONE_PICKUP

/obj/item/hearthkin_ship_fragment_active
	name = "Fragment of the Stjarndrakkr"
	desc = "A piece of ancient tech, carbon-dated to roughly 300 years ago. One side is etched with strange glowing symbols resembling Ættmál runes. Perhaps the natives could uncover its purpose."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "cult_sharpener"
	drop_sound = SFX_STONE_DROP
	pickup_sound = SFX_STONE_PICKUP

//Hearthkins can use a chisel on inactive ship fragments to activate them.
/obj/item/hearthkin_ship_fragment_inactive/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	add_fingerprint(user)
	if(!ispath(tool.type, /obj/item/chisel))
		return
	if(user.job != "Icemoon Dweller")
		return
	user.balloon_alert(user, "begins engraving runes...")
	playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
	if(do_after(user, 30 SECONDS, target = src, progress = TRUE))
		user.visible_message(span_notice("[user] completes the engraving — the fragment glows faintly."))
		var/turf/src_turf = get_turf(src)
		new /obj/item/hearthkin_ship_fragment_active(src_turf)
		qdel(src)
	else
		user.visible_message(span_warning("[user]'s engraving was interrupted."))

// Adds a rare xenoarch mat to global list "tech_reward" if the map has the prerequisit for the icecat camp to spawn, this will probably break if someone makes an ice map where the cat camp isn't on Zlevel 2 & 3.
/datum/controller/subsystem/mapping/Initialize()
	. = ..()
	if (SSmapping.level_trait(2, ZTRAIT_ICE_RUINS_UNDERGROUND)&&SSmapping.level_trait(3, ZTRAIT_ICE_RUINS_UNDERGROUND))
		GLOB.tech_reward[/obj/item/hearthkin_ship_fragment_inactive] = 1

// Adds an icon for the hammer in the crafting menu.
/datum/asset/spritesheet_batched/crafting/create_spritesheets()
	. = ..()
	insert_icon(replacetext(TOOL_HAMMER, " ", ""), uni_icon('modular_nova/modules/reagent_forging/icons/obj/forge_items.dmi', "hammer"))
