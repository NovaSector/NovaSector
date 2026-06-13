// Sabres, including the cargo variety

/obj/item/storage/belt/sheath/sabre/cargo
	name = "authentic shamshir leather sheath"
	desc = "A good-looking sheath that is advertised as being made of real Venusian black leather. It feels rather plastic-like to the touch, and it looks like it's made to fit a British cavalry sabre."
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
	stored_blade = /obj/item/melee/sabre/cargo

/obj/item/melee/sabre
	force = 20 // Original: 15
	wound_bonus = 5 // Original: 10
	exposed_wound_bonus = 20 // Original: 25 Both down slightly, to make up for the damage buff, since it'd get a bit wacky ontop of the armor pen.

/obj/item/melee/sabre/cargo
	name = "authentic shamshir sabre"
	desc = "An expertly crafted historical human sword once used by the Persians which has recently gained traction due to Venusian historal recreation sports. One small flaw, the Taj-based company who produces these has mistaken them for British cavalry sabres akin to those used by high ranking Nanotrasen officials. Atleast it cuts the same way!"
	icon_state = "sabre"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 20
	armour_penetration = 25

// This is here so that people can't buy the Sabres and craft them into powercrepes
/datum/crafting_recipe/food/powercrepe
	blacklist = list(/obj/item/melee/sabre/cargo)

// Prevents our common weapons from being used to easily craft stunswords
// Claymore blacklists can be found in code\datums\components\crafting\melee_weapon.dm
/datum/crafting_recipe/stunswordalt
	blacklist = list(/obj/item/katana/weak/curator)

/datum/crafting_recipe/stunswordalt2
	blacklist = list(/obj/item/melee/sabre/cargo)

/obj/item/melee/baton
	/// For use with jousting. For each usable jousting tile, increase the stamina damage of the jousting hit by this much.
	var/stamina_damage_per_jousting_tile = 2

/obj/item/melee/baton/Initialize(mapload)
	. = ..()

	add_jousting_component()

/// Component adder proc for custom behavior, without needing to add more vars.
/obj/item/melee/baton/proc/add_jousting_component()
	AddComponent(/datum/component/jousting, damage_boost_per_tile = 0, knockdown_chance_per_tile = 6)

/// For jousting. Called when a joust is considered successfully done.
/obj/item/melee/baton/proc/on_successful_joust(mob/living/target, mob/user, usable_charge)
	target.apply_damage(stamina_damage_per_jousting_tile * usable_charge, STAMINA)

/obj/item/melee/baton/nunchaku
	cooldown = 2 SECONDS // Original Melee CD (0.8 sec), weapon deemed too powerful with the throwmode that makes you immune to melee and throw


/obj/item/melee/baton/security/shockwhip
	name = "IC-44 Shock Whip"
	desc = "A highly specialized conductive monofilament wire whip. With the use of a power cell at the handle, the whip can be used to both kill and incapacitate. Due to it's expensive and complex nature, it is only made available to highly specialized users."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	icon_state = "stunbaton"
	inhand_icon_state = "chain"
	base_inhand_state = "chain"
	worn_icon_state = "whip"
	icon_angle = -90
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	force = 20
	throwforce = 7
	wound_bonus = 10
	exposed_wound_bonus = 20
	force_say_chance = 50
	stamina_damage = 60
	armour_type_against_stun = ENERGY
	knockdown_time = 5 SECONDS
	clumsy_knockdown_time = 15 SECONDS
	reach = 2
	active = FALSE
	stun_on_harmbaton = TRUE
	weak_against_armour = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	light_range = 1.5
	light_system = OVERLAY_LIGHT
	light_on = FALSE
	light_color = LIGHT_COLOR_BLUE
	light_power = 0.5
	attack_verb_continuous = list("Slashes", "whips", "lashes", "Lacerates")
	attack_verb_simple = list("Slashes", "whip", "lash", "lacerate")
	hitsound = 'sound/items/weapons/whip.ogg'
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/melee/baton/security/shockwhip/update_icon_state()
	var/base_inhand = base_inhand_state || base_icon_state
	if(active)
		icon_state = "[base_icon_state]_active"
		if(active_changes_inhand)
			inhand_icon_state = base_inhand
	else if(!cell)
		icon_state = "[base_icon_state]"
		inhand_icon_state = base_inhand
	else
		icon_state = base_icon_state
		inhand_icon_state = base_inhand
	return ..()

/obj/item/melee/baton/security/shockwhip/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/bluespace
