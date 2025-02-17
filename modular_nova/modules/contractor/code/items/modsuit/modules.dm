/obj/item/mod/module/baton_holster
	name = "MOD baton holster module"
	desc = "A module installed into the forearm and palm of a MODsuit, this allows you \
		to retrieve an inserted baton from the suit at will, and provides the benefit of being \
		magnetically locked, making it near-impossible to force out of a user's hands. \
		Insert a baton by hitting the module, while it is removed from the suit, with the baton."
	icon_state = "holster"
	icon = 'modular_nova/modules/contractor/icons/modsuit_modules.dmi'
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/melee/baton/telescopic/contractor_baton
	incompatible_modules = list(/obj/item/mod/module/baton_holster)
	cooldown_time = 0.5 SECONDS
	allow_flags = MODULE_ALLOW_INACTIVE
	/// Have they sacrificed a baton to actually be able to use this?
	var/eaten_baton = FALSE

/obj/item/mod/module/baton_holster/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/melee/baton/telescopic/contractor_baton) || eaten_baton)
		return
	balloon_alert(user, "[attacking_item] inserted")
	eaten_baton = TRUE
	qdel(attacking_item)

/obj/item/mod/module/baton_holster/on_activation()
	if(!eaten_baton)
		balloon_alert(mod.wearer, "no baton inserted")
		return
	return ..()

/obj/item/mod/module/baton_holster/preloaded
	eaten_baton = TRUE

/obj/item/mod/module/chameleon/contractor // zero complexity module to match pre-TGification
	removable = FALSE
	complexity = 0

/obj/item/mod/module/armor_booster/contractor // Much flatter distribution because contractor suit gets a shitton of armor already
	armor_mod = /datum/armor/contract_booster
	desc = "An integrated set of auxiliary armor plates, allowing the suit's modest protection to be increased further. \
	However, the plating cannot deploy with the suit's vacuum sealing components, and thus provides zero ability for extravehicular activity while deployed."

// 35 melee 40 bullet 35 laser 35 energy when deployed
// compare/contrast w/ syndicate mod:
// 40 melee 50 bullet 30 laser 30 energy
/datum/armor/contract_booster
	melee = 20
	bullet = 20
	laser = 20
	energy = 20

/obj/item/mod/module/springlock/contractor
	name = "MOD magnetic deployment module"
	desc = "A much more modern version of a springlock system, utilizing magnets to speed up the deployment and retraction time of a MODsuit \
	with a distinct lack of ability to snap into place when exposed to moisture."
	icon_state = "magnet"
	icon = 'modular_nova/modules/contractor/icons/modsuit_modules.dmi'

/obj/item/mod/module/springlock/contractor/on_part_activation() // This module is actually *not* a death trap
	return

/obj/item/mod/module/springlock/contractor/on_part_deactivation(deleting = FALSE)
	return

/// This exists for the adminbus contractor modsuit. Do not use otherwise
/obj/item/mod/module/springlock/contractor/no_complexity
	complexity = 0

/obj/item/mod/module/scorpion_hook
	name = "MOD SCORPION hook module"
	desc = "A module installed in the wrist of a MODSuit, this highly \
			illegal module uses a hardlight hook to forcefully pull \
			a target towards you at high speed, knocking them down and \
			partially exhausting them."
	icon_state = "hook"
	icon = 'modular_nova/modules/contractor/icons/modsuit_modules.dmi'
	incompatible_modules = list(/obj/item/mod/module/scorpion_hook)
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/gun/magic/hook/contractor
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
