/obj/effect/powerup/health/small
	name = "small health pickup"
	desc = "Restores five (5) health."
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "health_small"
	heal_amount = 5
	respawn_time = 2 MINUTES

/obj/effect/powerup/health/medium
	name = "medium health pickup"
	desc = "Restores thirty (30) health."
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "health_medium"
	heal_amount = 30
	respawn_time = 3 MINUTES

/obj/effect/powerup/health/large
	name = "large health pickup"
	desc = "Restores fifty (50) health."
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "health_large"
	heal_amount = 50
	respawn_time = 4 MINUTES

/obj/effect/powerup/ammo/arena
	name = "ammo box"
	desc = "Replenishes held weaponry."
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "ammo"
	respawn_time = 2 MINUTES

/obj/effect/powerup/armor
	name = "armor"
	desc = "Makes you two times harder to kill."
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "armor"
	respawn_time = 4 MINUTES
	pickup_message = "Your skin becomes seriously hard!"
	pickup_sound = 'sound/effects/rock_break.ogg'

/obj/effect/powerup/armor/trigger(mob/living/target)
	. = ..()
	if(!.)
		return
	target.apply_status_effect(/datum/status_effect/solemn_armor)

/datum/status_effect/solemn_armor
	id = "solemn_armor"
	duration = 2 MINUTES
	tick_interval = -1
	alert_type = /atom/movable/screen/alert/status_effect/solemn_armor

/atom/movable/screen/alert/status_effect/solemn_armor
	icon = 'modular_nova/modules/deathmatch/icons/powerup.dmi'
	icon_state = "armor_effect"
	name = "Solemn Armor"
	desc = "Your skin hardens and nerves numb! You can take on twice as much punishment!"

/datum/status_effect/solemn_armor/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		var/datum/physiology/owner_physiology = human_owner.physiology
		owner_physiology.brute_mod *= 0.5
		owner_physiology.burn_mod *= 0.5
		owner_physiology.tox_mod *= 0.5
		owner_physiology.oxy_mod *= 0.5
		owner_physiology.stamina_mod *= 0.5
	owner.add_filter("armor_glow", 2, list("type" = "outline", "color" = "#eed811c9", "size" = 2))
	owner.add_stun_absorption(source = id, priority = 4)
	owner.playsound_local(get_turf(owner), 'sound/effects/rock_break.ogg', vol = 100, vary = TRUE, use_reverb = TRUE)
	return TRUE

/datum/status_effect/solemn_armor/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		var/datum/physiology/owner_physiology = human_owner.physiology
		owner_physiology.brute_mod *= 2
		owner_physiology.burn_mod *= 2
		owner_physiology.tox_mod *= 2
		owner_physiology.oxy_mod *= 2
		owner_physiology.stamina_mod *= 2
	owner.remove_filter("armor_glow")
	owner.remove_stun_absorption(id)
