/obj/item/storage/backpack/duffelbag/synth_treatment_kit
	name = "synthetic treatment kit"
	desc = "A \"surgical\" duffel bag containing everything you need to treat the worst and <i>best</i> of inorganic wounds."
	icon = 'modular_nova/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_robo"
	inhand_icon_state = "duffel_robo"

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/PopulateContents() // yes, this is all within the storage capacity
	return list(
		// Slash/Pierce wound tools - can reduce intensity of electrical damage (wires can fix generic burn damage)
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/wirecutters,
		// Blunt/Brute tools
		/obj/item/weldingtool/largetank, // Used for repairing blunt damage or heating metal at T3 blunt
		/obj/item/screwdriver, // Used for fixing T1 blunt or securing internals of T2/3 blunt
		/obj/item/bonesetter,
		// Clothing items
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/gloves/color/black, // Protects from T3 mold metal step
		/obj/item/clothing/glasses/hud/diagnostic, // When worn, generally improves wound treatment quality
		// Reagent containers
		/obj/item/reagent_containers/spray/hercuri/chilled, // Highly effective (specifically coded to be) against burn wounds
		/obj/item/reagent_containers/spray/dinitrogen_plasmide, // same
		// Generic medical items
		/obj/item/stack/medical/gauze/twelve,
		/obj/item/healthanalyzer,
		/obj/item/healthanalyzer/simple, // Buffs wound treatment and gives details of wounds it scans
		// "Ghetto" tools, things you shouldnt ideally use but you might have to
		/obj/item/stack/medical/bone_gel, // Ghetto T2/3 option for securing internals
		/obj/item/plunger, // Can be used to mold heated metal at T3
	)

// a treatment kit with extra space and more tools/upgraded tools, like a crowbar, insuls, a reinforced plunger, a crowbar and wrench
/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma
	name = "synthetic trauma kit"
	desc = "A \"surgical\" duffel bag containing everything you need to treat the worst and <i>best</i> of inorganic wounds. This one has extra tools and space \
	for treatment of the WORST of the worst! However, it's highly specialized interior means it can ONLY hold synthetic repair tools."
	storage_type = /datum/storage/duffel/synth_trauma_kit

/datum/storage/duffel/synth_trauma_kit
	exception_max = 6
	max_slots = 28
	max_total_storage = 36

/datum/storage/duffel/synth_trauma_kit/New(atom/parent, max_slots, max_specific_storage, max_total_storage, numerical_stacking, allow_quick_gather, allow_quick_empty, collection_mode, attack_hand_interact)
	. = ..()

	var/static/list/exception_cache = typecacheof(list(
		// Mainly just stacks, with the exception of pill bottles and sprays
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical/gauze,
		/obj/item/reagent_containers/spray,
		/obj/item/stack/medical/bone_gel,
		/obj/item/rcd_ammo,
		/obj/item/storage/pill_bottle,
	))

	var/static/list/can_hold_list = list(
		// Stacks
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical/gauze,
		/obj/item/stack/medical/bone_gel,
		// Reagent containers, for synth medicine
		/obj/item/reagent_containers/spray,
		/obj/item/storage/pill_bottle,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/cup,
		/obj/item/reagent_containers/syringe,
		// Tools, including tools you might not want to use but might have to (hemostat/retractor/etc)
		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/crowbar,
		/obj/item/weldingtool,
		/obj/item/bonesetter,
		/obj/item/wirecutters,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/plunger,
		// RCD stuff - RCDs can easily treat the 1st step of T3 blunt
		/obj/item/construction/rcd,
		/obj/item/rcd_ammo,
		// Clothing items
		/obj/item/clothing/gloves,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/clothing/glasses/hud/diagnostic,
		/obj/item/clothing/glasses/welding,
		/obj/item/clothing/glasses/sunglasses, // still provides some welding protection
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/mask/gas/welding,
		// Generic health items
		/obj/item/healthanalyzer,
	)
	exception_hold = exception_cache

	// We keep the type list and the typecache list separate...
	var/static/list/can_hold_cache = typecacheof(can_hold_list)
	can_hold = can_hold_cache

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/PopulateContents() // yes, this is all within the storage capacity
	return list(
		// Slash/Pierce wound tools - can reduce intensity of electrical damage (wires can fix generic burn damage)
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/wirecutters,
		// Blunt/Brute tools
		/obj/item/weldingtool/hugetank, // Used for repairing blunt damage or heating metal at T3 blunt
		/obj/item/screwdriver, // Used for fixing T1 blunt or securing internals of T2/3 blunt
		/obj/item/wrench, // Same as screwdriver for T2/3
		/obj/item/crowbar, // Ghetto fixing option for T2/3 blunt
		/obj/item/bonesetter,
		// Clothing items
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/gloves/color/black, // Protects from T3 mold metal step
		/obj/item/clothing/gloves/color/yellow, // Protects from electrical damage and crowbarring a blunt wound
		/obj/item/clothing/glasses/hud/diagnostic, // When worn, generally improves wound treatment quality
		// Reagent containers
		/obj/item/reagent_containers/spray/hercuri/chilled, // Highly effective (specifically coded to be) against burn wounds
		/obj/item/reagent_containers/spray/dinitrogen_plasmide, // same
		// Generic medical items
		/obj/item/stack/medical/gauze/twelve,
		/obj/item/healthanalyzer,
		/obj/item/healthanalyzer/simple, // Buffs wound treatment and gives details of wounds it scans
		// "Ghetto" tools, things you shouldnt ideally use but you might have to
		/obj/item/stack/medical/bone_gel, // Ghetto T2/3 option for securing internals
		/obj/item/plunger/reinforced, // Can be used to mold heated metal at T3
	)

// advanced tools, an RCD, chems, etc etc. dont give this one to the crew early in the round
/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced
	name = "advanced synth trauma kit"
	desc = "An \"advanced\" \"surgical\" duffel bag containing <i>absolutely</i> everything you need to treat the worst and <i>best</i> of inorganic wounds. \
	This one has extra tools and space for treatment of the ones even <i>worse</i> than the WORST of the worst! However, its highly specialized interior \
	means it can ONLY hold synthetic repair tools."

	storage_type = /datum/storage/duffel/synth_trauma_kit/advanced

/datum/storage/duffel/synth_trauma_kit/advanced
	exception_max = 10
	max_slots = 33
	max_total_storage = 50

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced/PopulateContents() // yes, this is all within the storage capacity
	return list(
		// Slash/Pierce wound tools - can reduce intensity of electrical damage (wires can fix generic burn damage)
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
		/obj/item/crowbar/power, // jaws of life - wirecutters and crowbar
		// Blunt/Brute tools
		/obj/item/weldingtool/experimental, // Used for repairing blunt damage or heating metal at T3 blunt
		/obj/item/screwdriver/power, // drill - screwdriver and wrench
		/obj/item/construction/rcd/loaded, // lets you instantly heal T3 blunt step 1
		/obj/item/bonesetter,
		// Clothing items
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/gloves/combat, // insulated AND heat-resistant
		/obj/item/clothing/glasses/hud/diagnostic, // When worn, generally improves wound treatment quality
		// Reagent containers
		/obj/item/reagent_containers/spray/hercuri/chilled, // Highly effective (specifically coded to be) against burn wounds
		/obj/item/reagent_containers/spray/hercuri/chilled, // 2 of them
		/obj/item/reagent_containers/spray/dinitrogen_plasmide, // same
		/obj/item/reagent_containers/spray/dinitrogen_plasmide,
		/obj/item/storage/pill_bottle/nanite_slurry, // Heals blunt/burn
		/obj/item/storage/pill_bottle/liquid_solder, // Heals brain damage
		/obj/item/storage/pill_bottle/system_cleaner, // Heals toxin damage and purges chems
		// Generic medical items
		/obj/item/stack/medical/gauze/twelve,
		/obj/item/healthanalyzer/advanced, // advanced, not a normal analyzer
		/obj/item/healthanalyzer/simple, // Buffs wound treatment and gives details of wounds it scans
		// "Ghetto" tools, things you shouldn't ideally use but you might have to
		/obj/item/stack/medical/bone_gel, // Ghetto T2/3 option for securing internals
		/obj/item/plunger/reinforced, // Can be used to mold heated metal at T3 blunt
	)

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced/unzipped
	zipped_up = FALSE

// basetype, do not use
/obj/item/storage/medkit/mechanical
	name = "mechanical medkit"
	desc = "For those mechanical booboos."

	icon = 'modular_nova/modules/medical/code/medkit.dmi'
	icon_state = "medkit_mechanical"
	inhand_icon_state = "medkit_mechanical"
	lefthand_file = 'modular_nova/modules/medical/code/medical_lefthand.dmi'
	righthand_file = 'modular_nova/modules/medical/code/medical_righthand.dmi'

/obj/item/storage/medkit/mechanical/Initialize(mapload)
	. = ..()

	var/item/storage/medkit/temp_storage = new
	var/static/list/list_of_everything_mechanical_medkits_can_hold = list_of_everything_medkits_can_hold + list(
		/obj/item/stack/cable_coil,
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/multitool,
		/obj/item/plunger,
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/glasses/welding,
	)
	qdel(temp_storage)
	var/static/list/exception_cache = typecacheof(
		/obj/item/clothing/head/utility/welding
	)

	atom_storage.set_holdable(list_of_everything_mechanical_medkits_can_hold)
	LAZYINITLIST(atom_storage.exception_hold)
	atom_storage.exception_hold = atom_storage.exception_hold + exception_cache
