//Debug & Admin Internals Tanks
//code\game\objects\items\tanks\tank_types.dm
//todo:variant icons
//define TANK_LEAK_PRESSURE (30.*ONE_ATMOSPHERE) = The internal pressure in kPa at which a handheld gas tank begins to take damage.
//So our magic multiplier should be 29! Right. Right???
//Base Debug Tank, probably fucks hard when used with ordnance, I haven't tried and you probably shouldn't try on prod either.
/obj/item/tank/internals/admin
	name = "subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. The longer your gaze lingers, the more unsettled you feel. Somewhere, a scientist yearns to print these. "
	icon_state = "emergency_double"
	inhand_icon_state = "emergency_tank"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	worn_icon = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	force = 10
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 490//default tanks are 70, and this is a multiple for some scaling and mixing formulae

/obj/item/tank/internals/admin/populate_gas()
	return//spawns empty

//Normal Internals
//Oxygen - Most things breathe this
/obj/item/tank/internals/admin/oxygen
	name = "oxygen subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain oxygen."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/admin/oxygen/populate_gas()
	air_contents.assert_gas(/datum/gas/oxygen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Pluoxium - The cooler oxygen
/obj/item/tank/internals/admin/pluoxium
	name = "pluoxium subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain pluoxium."
	distribute_pressure = 3

/obj/item/tank/internals/admin/pluoxium/populate_gas()
	air_contents.assert_gas(/datum/gas/pluoxium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Plasma - Plasmama, where have you gone, we miss you
/obj/item/tank/internals/admin/plasma
	name = "plasma subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain plasma."
	distribute_pressure = TANK_PLASMAMAN_RELEASE_PRESSURE

/obj/item/tank/internals/admin/plasma/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Nitrogen - Criminal cats breathe this.
/obj/item/tank/internals/admin/nitrogen
	name = "nitrogen subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain nitrogen."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/admin/nitrogen/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.gases[/datum/gas/nitrogen][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//'Ooops, lots of dust. Dont breathe this!'
//Tritium - Just fuckin' straight radiation.
/obj/item/tank/internals/admin/tritium
	name = "tritium subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a warning label indicating the tank should contain tritium."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/admin/tritium/populate_gas()
	air_contents.assert_gas(/datum/gas/tritium)
	air_contents.gases[/datum/gas/tritium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Freon - Funny ice-cycle tank
/obj/item/tank/internals/admin/freon
	name = "freon subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a warning label indicating the tank should contain freon."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/admin/freon/populate_gas()
	air_contents.assert_gas(/datum/gas/freon)
	air_contents.gases[/datum/gas/freon][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Now we get into some gas mixes
//Mixes containing nitrium can be poisonous. The higher the output pressure of a mix with nitrium, the higher the likelihood or rate of poisoning, but the more impactful the boon.
//Robust Mix, courtesy of Zul.
//This will kill you if you leave it running, but it's like stims on demand if you mind the toxin cycle.
/obj/item/tank/internals/admin/mix/juggermol
	name = "'JUGGERMOL' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There's a cute sticker applied of a red-haired neko warning you about 'Nitrosyl Plasmide Poisoning', whatever that means."
	distribute_pressure = 23

/obj/item/tank/internals/admin/mix/juggermol/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/healium, /datum/gas/nitrium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.112
	air_contents.gases[/datum/gas/healium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.333
	air_contents.gases[/datum/gas/nitrium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.555

//Anti-conflagratory. Good for firebugs. Doesn't save your clothing.
/obj/item/tank/internals/admin/mix/fusionfur
	name = "'Fusion-Fur' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. A partially-peeled sticker of a grey-furred anthromorph advertises how well this mix keeps her fur from burning."
	distribute_pressure = 8

/obj/item/tank/internals/admin/mix/fusionfur/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/halon, /datum/gas/hypernoblium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.95
	air_contents.gases[/datum/gas/halon][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05

//Stupid in a tank. Give one to the clown.
//if you say it bee-zed, the name makes slightly more sense. Feel free to rename this one if you're funnier than me, dear reader.
/obj/item/tank/internals/admin/mix/beeshead
	name = "'Bee's Head' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. It's covered in stickers of butt-bots."
	icon_state = "emergency_clown"
	inhand_icon_state = "emergency_clown"
	tank_holder_icon_state = "holder_emergency_clown"
	distribute_pressure = 23

/obj/item/tank/internals/admin/mix/beeshead/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/nitrous_oxide, /datum/gas/bz, /datum/gas/helium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.75
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05
	air_contents.gases[/datum/gas/bz][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05
	air_contents.gases[/datum/gas/helium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.15
