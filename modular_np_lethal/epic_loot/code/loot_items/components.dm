/datum/export/epic_loot_components
	cost = PAYCHECK_COMMAND
	unit_name = "components"
	export_types = list(
		/obj/item/epic_loot/grenade_fuze,
		/obj/item/epic_loot/nail_box,
		/obj/item/epic_loot/cold_weld,
		/obj/item/epic_loot/signal_amp,
		/obj/item/epic_loot/fuel_conditioner,
		/obj/item/epic_loot/aramid,
		/obj/item/epic_loot/cordura,
		/obj/item/epic_loot/ripstop,
	)

/datum/export/epic_loot_components_super
	cost = PAYCHECK_COMMAND * 2
	unit_name = "valuable components"
	export_types = list(
		/obj/item/epic_loot/water_filter,
		/obj/item/epic_loot/thermometer,
		/obj/item/epic_loot/current_converter,
		/obj/item/epic_loot/electric_motor,
		/obj/item/epic_loot/thermal_camera,
		/obj/item/epic_loot/shuttle_gyro,
		/obj/item/epic_loot/phased_array,
		/obj/item/epic_loot/shuttle_battery,
	)

// Grenade fuze, an old design from an old time past. You can still make a pretty good grenade with it though
/obj/item/epic_loot/grenade_fuze
	name = "grenade fuze"
	desc = "The fuze of an older grenade type that used to see common use around known space."
	icon_state = "fuze"
	inhand_icon_state = "pen"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

// The filter part of a water filter machine, though these machines are insanely rare due to modern synthesis technology
/obj/item/epic_loot/water_filter
	name = "water filter cartridge"
	desc = "A blue polymer tube filled with filter medium for use in an industrial water filtration unit."
	icon_state = "water_filter"
	inhand_icon_state = "miniFE"
	drop_sound = 'sound/items/handling/weldingtool_drop.ogg'
	pickup_sound = 'sound/items/handling/weldingtool_pickup.ogg'

// Analog thermometer, how to tell temperature before gas analyzers were cool
/obj/item/epic_loot/thermometer
	name = "analog thermometer"
	desc = "A highly outdated, and likely broken, analog thermometer."
	icon_state = "thermometer"
	inhand_icon_state = "razor"
	drop_sound = 'sound/items/handling/multitool_drop.ogg'
	pickup_sound = 'sound/items/handling/multitool_pickup.ogg'

// A box of nails, impossible tech on a space station
/obj/item/epic_loot/nail_box
	name = "box of nails"
	desc = "A pristine box of nails, a method of keeping things together that happens to be insanely rare in space."
	icon_state = "nails"
	inhand_icon_state = "rubberducky"
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

// Used for joining together plastics, ideally.
/obj/item/epic_loot/cold_weld
	name = "tube of cold weld"
	desc = "A tube of cold weld, used to join together plastics, usually for repair."
	icon_state = "cold_weld"
	inhand_icon_state = "razor"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

// An electronic motor
/obj/item/epic_loot/electric_motor
	name = "electric motor"
	desc = "An electrically driven motor for industrial applications."
	icon_state = "motor"
	inhand_icon_state = "miniFE"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound = 'sound/items/handling/cardboardbox_pickup.ogg'

// Current converters, these change one rating of current into another in a mostly safe manner
/obj/item/epic_loot/current_converter
	name = "current converter"
	desc = "A device for regulating electric current that passes through it."
	icon_state = "current_converter"
	inhand_icon_state = "miniFE"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/weldingtool_drop.ogg'
	pickup_sound = 'sound/items/handling/weldingtool_pickup.ogg'

// Signal amplifiers, used to take a faint signal and return it stronger than before
/obj/item/epic_loot/signal_amp
	name = "signal amplifier"
	desc = "A device for taking weakened input signals and strengthening them for use or listening."
	icon_state = "signal_amp"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

// Thermal camera modules
/obj/item/epic_loot/thermal_camera
	name = "thermal camera module"
	desc = "An infrared sensing device used for the production of thermal camera systems."
	icon_state = "thermal"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

// Shuttle gyroscopes, AKA how a shuttle realizes which way it's pointing
/obj/item/epic_loot/shuttle_gyro
	name = "shuttle gyroscope"
	desc = "A bulky device used by shuttles and other space faring vessels to find the direction they are facing."
	icon_state = "shuttle_gyro"
	inhand_icon_state = "miniFE"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

/obj/item/epic_loot/shuttle_gyro/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

// Phased array elements, combine a bunch together to get god's strongest radar, or whatever else you can think of
/obj/item/epic_loot/phased_array
	name = "phased array element"
	desc = "An element of a larger phased array. These combine together to produce sensing and scanning devices used on most common space-faring vessels."
	icon_state = "phased_array"
	inhand_icon_state = "blankplaque"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

// Shuttle batteries, used to power electronics while the engines are off
/obj/item/epic_loot/shuttle_battery
	name = "shuttle battery"
	desc = "A massive shuttle-grade battery, used to keep the electronics of space-faring vessel powered while the main engines are de-activated."
	icon_state = "ship_battery"
	inhand_icon_state = "blankplaque"
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound = 'sound/items/handling/cardboardbox_pickup.ogg'

/obj/item/epic_loot/shuttle_battery/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

// Industrial fuel conditioner, used to keep most fuel-burning machines within regulations for waste emissions
/obj/item/epic_loot/fuel_conditioner
	name = "fuel conditioner"
	desc = "A polymer canister of advanced fuel conditioner, used to keep fuel burning vehicles and machines burning relatively clean."
	icon_state = "fuel_conditioner"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound = 'sound/items/handling/cardboardbox_pickup.ogg'

// Bullet and stab resistant fabric, use lots to make something stop bullets a bit better
/obj/item/epic_loot/aramid
	name = "high-resistance fabric"
	desc = "A yellow weaved fabric that has exceptional resistance to piercing and slashing, as well as a number of other common damage sources."
	icon_state = "aramid"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'

// You know they make your pouches and such out of this stuff?
/obj/item/epic_loot/cordura
	name = "polymer weave fabric"
	desc = "Common high-strength fabric used in the production of a large amount of equipment."
	icon_state = "cordura"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'

// It's like the one above but for different stuff
/obj/item/epic_loot/ripstop
	name = "tear-resistant fabric"
	desc = "A reinforced fabric made to be highly resistant to tearing, and to have a limited ability to repair itself."
	icon_state = "ripstop"
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'
