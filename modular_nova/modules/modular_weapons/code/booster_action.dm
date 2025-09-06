/// Component that handles barrel-charger-esque effects, typically increasing damage/projectile speed but reducing firerate
/// Examples: the Laevateinn revolver, the Kolben shotgun
/datum/component/gun_booster
	/// Is our currently attached gun amped?
	var/amped = FALSE

	/// Base damage multiplier of the gun.
	var/base_damage_mult = 1
	/// Base projectile speed multiplier of the gun.
	var/base_speed_mult = 1
	/// Base fire delay of the gun.
	var/base_fire_delay = NONE

	/// Amped damage multiplier of the gun.
	var/amped_damage_mult = 1.2
	/// Amped projectile speed multiplier of the gun.
	var/amped_speed_mult = 1.5
	/// Amped fire delay of the gun.
	var/amped_fire_delay = CLICK_CD_RANGE * 2

	/// Holder for the appropriate action
	var/datum/action/item_action/booster/booster_action

/datum/component/gun_booster/Initialize(
		booster_action,
		base_damage_mult = 1,
		base_speed_mult = 1,
		base_fire_delay = NONE,
		amped_damage_mult = 1.2,
		amped_speed_mult = 1.2,
		amped_fire_delay = CLICK_CD_RANGE*2,
	)
	. = ..()
	src.booster_action = booster_action
	src.base_damage_mult = base_damage_mult
	src.base_speed_mult = base_speed_mult
	src.base_fire_delay = base_fire_delay

	src.amped_damage_mult = amped_damage_mult
	src.amped_speed_mult = amped_speed_mult
	src.amped_fire_delay = amped_fire_delay

	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/gun/gun_parent = parent
	src.booster_action = gun_parent.add_item_action(booster_action)

	update_action_button_state()

/datum/component/gun_booster/Destroy(force)
	if(booster_action)
		QDEL_NULL(booster_action)
	return ..()

/datum/component/gun_booster/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_UI_ACTION_CLICK, PROC_REF(on_action_click))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))

/datum/component/gun_booster/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_UI_ACTION_CLICK)
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS)

/// Calls toggle_booster if the action type for doing so is used
/datum/component/gun_booster/proc/on_action_click(source, user, datum/actiontype)
	SIGNAL_HANDLER

	if(istype(actiontype, booster_action))
		toggle_booster(parent, user)

	return COMPONENT_ACTION_HANDLED

/// Toggles the booster on/off
/datum/component/gun_booster/proc/toggle_booster(obj/item/gun/source, mob/user)
	amped = !amped
	playsound(source, 'sound/items/weapons/empty.ogg', 100, TRUE)

	if(amped)
		source.projectile_damage_multiplier = amped_damage_mult
		source.projectile_speed_multiplier = amped_speed_mult
		source.fire_delay = amped_fire_delay
	else
		source.projectile_damage_multiplier = base_damage_mult
		source.projectile_speed_multiplier = base_speed_mult
		source.fire_delay = base_fire_delay

	// Guns typically also have some unique features tied to boosting, itself, so we also send a signal to the gun to handle
	// individual things, e.g. custom messages, fire sounds, recoil, etc.
	SEND_SIGNAL(source, COMSIG_GUN_BOOSTER_TOGGLED, user, amped)
	source.update_appearance()
	update_action_button_state()

/datum/component/gun_booster/proc/on_update_overlays(obj/item/gun/our_gun, list/overlays)
	SIGNAL_HANDLER
	if(amped)
		overlays += mutable_appearance(our_gun.icon, "[initial(our_gun.icon_state)]_charge")

/datum/component/gun_booster/proc/update_action_button_state()
	if(!booster_action)
		return

	booster_action.button_icon_state = "[initial(booster_action.button_icon_state)][amped ? "1" : "0"]"
	booster_action.build_all_button_icons()

/datum/action/item_action/booster
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	button_icon_state = "hbarrel"
	name = "Toggle Barrel Charger"

/obj/item/gun/ballistic/revolver/c38/super/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38/empty
