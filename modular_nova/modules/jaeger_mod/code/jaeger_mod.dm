/datum/mod_theme/jaeger_med
	name = "modular infantry"
	desc = "A medium Infantry-pattern Jaeger/MOD power-assisted combat exoskeleton designed for use in non-vacuum environments."
	extended_desc = "A second-and-a-half generation exoskeleton somewhere between unassisted combat exoskeletons and proper modular suits, \
		the Jaeger/MOD series of power-assisted combat exoskeletons is an odd middle child in military-funded pursuits of personal protection. \
		Thanks to continued long-term support, Jaeger/MOD exoskeletons are compatible with most, if not all, MOD modules compliant with \
		current attachment standards, in return for no longer supporting attachments \
		from previous generations of combat exoskeletons... and not being spaceproof.<br><br>\
		The JAEGER/MOD|INFT/M Infantry-pattern exoskeleton features a sealed helmet with \
		integrated ballistic visor and moderate full-body armor. \
		The medium armor load does allow for some supplementary module installation \
		compared to its more heavily armored brethren, but less than lighter models."
	default_skin = "infantry"
	armor_type = /datum/armor/mod_theme_infantry
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	siemens_coefficient = 0.25
	complexity_max = DEFAULT_MAX_COMPLEXITY - 3
	slowdown_deployed = 0.25
	inbuilt_modules = list(/obj/item/mod/module/jaeger_sprint) // future todo: user-settable shoulder stripe
	allowed_suit_storage = list(
		/obj/item/storage/belt/machete,
	)
	variants = list(
		"infantry" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/jaeger_mod/icons/obj/infantry.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/jaeger_mod/icons/mob/infantry.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_CLOTHING = HEADINTERNALS,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_infantry
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 40
	bio = 50
	fire = 50
	acid = 60
	wound = 20

/obj/item/mod/control/pre_equipped/jaeger_med
	theme = /datum/mod_theme/jaeger_med
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/quick_cuff,
	)
	default_pins = list(
		/obj/item/mod/module/jaeger_sprint,
	)

/obj/item/mod/module/jaeger_sprint
	name = "MOD jaeger sprint module"
	desc = "An integrated subsystem that provides extra energy and cooling to the Jaeger/MOD's leg servos, reducing the equipment burden \
		at the non-negligible cost of increased power draw. Use in controlled bursts."
	icon = 'modular_nova/modules/jaeger_mod/icons/obj/infantry.dmi'
	icon_state = "sprint"
	removable = FALSE
	module_type = MODULE_TOGGLE
	incompatible_modules = list(/obj/item/mod/module/jaeger_sprint)
	required_slots = list(ITEM_SLOT_FEET)
	active_power_cost = DEFAULT_CHARGE_DRAIN * 2
	/// How much slowdown does this add when activated?
	var/speed_added = -0.25

/obj/item/mod/module/jaeger_sprint/on_activation()
	mod.update_speed()

/obj/item/mod/module/jaeger_sprint/on_deactivation(display_message = TRUE, deleting = FALSE)
	mod.update_speed()

/obj/item/mod/module/jaeger_sprint/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_MOD_UPDATE_SPEED, PROC_REF(on_update_speed))

/obj/item/mod/module/jaeger_sprint/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, COMSIG_MOD_UPDATE_SPEED)

/obj/item/mod/module/jaeger_sprint/proc/on_update_speed(datum/source, list/module_slowdowns, prevent_slowdown)
	SIGNAL_HANDLER
	if (active)
		module_slowdowns += speed_added
