/obj/item/storage/lockbox/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_TINY //This is to stop people from using the storage inside the lockboxes.
	atom_storage.max_total_storage = WEIGHT_CLASS_BULKY*35 //Assuming full case+manifest
	atom_storage.max_slots = 35 //This is to avoid some instances of lost in shipment. In theory before hitting the limit you get a crate.
	atom_storage.set_holdable(list(
		/obj/item/paper,
	))

// Makes this available to anyone, not just those with ACCESS_AUX_BASE
/datum/supply_pack/goody/shuttle_construction_kit/New()
	. = ..()
	access_view = FALSE
	contains += /obj/item/stack/rods/shuttle/fifty

/*
*	EMERGENCY RACIAL EQUIPMENT
*/

/datum/supply_pack/goody/airsuppliesnitrogen
	name = "Emergency Air Supplies (Nitrogen)"
	desc = "A vox breathing mask and nitrogen tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/nitrogen/belt,
		/obj/item/clothing/mask/breath/vox,
	)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "Emergency Air Supplies (Oxygen)"
	desc = "A breathing mask and emergency oxygen tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/clothing/mask/breath,
	)

/datum/supply_pack/goody/airsuppliesplasma
	name = "Emergency Air Supplies (Plasma)"
	desc = "A breathing mask and plasmaman plasma tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/plasmaman/belt,
		/obj/item/clothing/mask/breath,
	)


/*
*	MISC
*/

/datum/supply_pack/goody/crayons
	name = "Box of Crayons"
	desc = "Colorful!"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/diamondring
	name = "Diamond Ring"
	desc = "Show them your love is like a diamond: unbreakable and everlasting. No refunds."
	cost = PAYCHECK_CREW * 50
	contains = list(/obj/item/storage/fancy/ringbox/diamond)
	crate_name = "diamond ring crate"

/datum/supply_pack/goody/paperbin
	name = "Paper Bin"
	desc = "Pushing paperwork is always easier when you have paper to push!"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/paper_bin)

/datum/supply_pack/goody/xenoarch_intern
	name = "Xenoarchaeology Intern Skillchip Set"
	desc = "A skillchip with all the information required to start dabbling in the fine art of interpreting xenoarchaeological finds, \
			and a magnifying glass for actually analyzing your finds. \
			Does not come with actual excavation tools, nor the ability to actually make anyone pay attention to one's \
			attempts at intellectual posturing, nor any actual job experience as a curator."
	cost = PAYCHECK_CREW * 15 // 750 credits but you also theoretically print a lot of money if you consistently get/scan relics
	contains = list(/obj/item/skillchip/xenoarch_magnifier,
				/obj/item/glassblowing/magnifying_glass,
			)

/datum/supply_pack/goody/scratching_stone
	name = "Scratching Stone"
	desc = "A high-grade sharpening stone made of specialized alloys, meant to sharpen razor-claws. Unfortunately, this particular one has by far seen better days."
	cost = CARGO_CRATE_VALUE * 4 //800 credits
	contains = list(/obj/item/scratching_stone)
	order_flags = ORDER_CONTRABAND

/*
*	CARPET PACKS
*/

/datum/supply_pack/goody/carpet
	name = "Classic Carpet Single-Pack"
	desc = "Plasteel floor tiles getting on your nerves? This 50 units stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/stack/tile/carpet/fifty)

/datum/supply_pack/goody/carpet/black
	name = "Black Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/black/fifty)

/datum/supply_pack/goody/carpet/premium
	name = "Royal Black Carpet Single-Pack"
	desc = "Exotic carpets for all your decorating needs. This 50 unit stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_CREW * 3.5
	contains = list(/obj/item/stack/tile/carpet/royalblack/fifty)

/datum/supply_pack/goody/carpet/premium/royalblue
	name = "Royal Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/royalblue/fifty)

/datum/supply_pack/goody/carpet/premium/red
	name = "Red Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/red/fifty)

/datum/supply_pack/goody/carpet/premium/purple
	name = "Purple Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/purple/fifty)

/datum/supply_pack/goody/carpet/premium/orange
	name = "Orange Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/orange/fifty)

/datum/supply_pack/goody/carpet/premium/green
	name = "Green Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/green/fifty)

/datum/supply_pack/goody/carpet/premium/cyan
	name = "Cyan Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/cyan/fifty)

/datum/supply_pack/goody/carpet/premium/blue
	name = "Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/blue/fifty)

/datum/supply_pack/service/carpet_kinaris
	name = "Kinaris Carpet Crate"
	desc = "Plasteel floor tiles getting on your nerves? This 100 units stack of each soft carpet will tie any room together."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(
		/obj/item/stack/tile/carpet/kinaris/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/red/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/orange/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/yellow/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/green/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/purple/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/blacktrim/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/red/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/orange/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/yellow/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/green/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/purple/fifty = 2,
		/obj/item/stack/tile/carpet/kinaris/black/whitetrim/fifty = 2,
	)

/datum/supply_pack/goody/carpet/kinaris
	name = "Kinaris Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/fifty)

/datum/supply_pack/goody/carpet/kinaris/red
	name = "Kinaris Red Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/red/fifty)

/datum/supply_pack/goody/carpet/kinaris/orange
	name = "Kinaris orange Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/orange/fifty)

/datum/supply_pack/goody/carpet/kinaris/yellow
	name = "Kinaris Yellow Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/yellow/fifty)

/datum/supply_pack/goody/carpet/kinaris/green
	name = "Kinaris Green Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/green/fifty)

/datum/supply_pack/goody/carpet/kinaris/purple
	name = "Kinaris Purple Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/purple/fifty)

/datum/supply_pack/goody/carpet/kinaris/blacktrim
	name = "Kinaris Blacktrim Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/blacktrim/fifty)

/datum/supply_pack/goody/carpet/kinaris/black
	name = "Kinaris Black Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/red
	name = "Kinaris Black & Red Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/red/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/orange
	name = "Kinaris Black & orange Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/orange/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/black/yellow
	name = "Kinaris Black & Yellow Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/yellow/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/green
	name = "Kinaris Black & Green Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/green/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/purple
	name = "Kinaris Black & Purple Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/purple/fifty)

/datum/supply_pack/goody/carpet/kinaris/black/whitetrim
	name = "Kinaris White Trim Regal Carpet"
	contains = list(/obj/item/stack/tile/carpet/kinaris/black/whitetrim/fifty)

/datum/supply_pack/goody/carpet/polite
	name = "Polite Black Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/fifty)
	cost = CARGO_CRATE_VALUE * 3.5

/datum/supply_pack/goody/carpet/polite/red
	name = "Polite Red Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/red/fifty)

/datum/supply_pack/goody/carpet/polite/orange
	name = "Polite Orange Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/orange/fifty)

/datum/supply_pack/goody/carpet/polite/yellow
	name = "Polite Yellow Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/yellow/fifty)

/datum/supply_pack/goody/carpet/polite/green
	name = "Polite Green Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/green/fifty)

/datum/supply_pack/goody/carpet/polite/blue
	name = "Polite Blue Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/blue/fifty)

/datum/supply_pack/goody/carpet/polite/purple
	name = "Polite Purple Carpet"
	contains = list(/obj/item/stack/tile/carpet/polite/purple/fifty)

/datum/supply_pack/goody/carpet/polite/crate
	name = "Polite Carpet Crate"
	desc = "Plasteel floor tiles getting on your nerves? This 100 units stack of each soft carpet will tie any room together."
	contains = list(
		/obj/item/stack/tile/carpet/polite/fifty = 2,
		/obj/item/stack/tile/carpet/polite/red/fifty = 2,
		/obj/item/stack/tile/carpet/polite/orange/fifty = 2,
		/obj/item/stack/tile/carpet/polite/yellow/fifty = 2,
		/obj/item/stack/tile/carpet/polite/green/fifty = 2,
		/obj/item/stack/tile/carpet/polite/blue/fifty = 2,
		/obj/item/stack/tile/carpet/polite/purple/fifty = 2,
	)
	cost = CARGO_CRATE_VALUE * 12

/*
* NIF STUFF
*/
/datum/supply_pack/goody/standard_nif
	name = "Standard Type NIF"
	desc = "Contains a single standard NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(
		/obj/item/organ/cyberimp/brain/nif/standard,
	)

/datum/supply_pack/goody/cheap_nif
	name = "Econo-Deck Type NIF"
	desc = "Contains a single Econo-Deck NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/item/organ/cyberimp/brain/nif/roleplay_model,
	)

/datum/supply_pack/goody/nif_repair_kit
	name = "Cerulean NIF Regenerator"
	desc = "Contains a single container of NIF repair fluid, good for up to 5 uses."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/nif_repair_kit,
	)

/datum/supply_pack/goody/money_sense_nifsoft
	name = "Automatic Appraisal NIFSoft"
	desc = "Contains a single Automatic Appraisal NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/job/money_sense,
	)

/datum/supply_pack/goody/shapeshifter_nifsoft
	name = "Polymorph NIFSoft"
	desc = "Contains a single Polymorph NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/shapeshifter,
	)

/datum/supply_pack/goody/hivemind_nifsoft
	name = "Hivemind NIFSoft"
	desc = "Contains a single Hivemind NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/hivemind,
	)

/datum/supply_pack/goody/summoner_nifsoft
	name = "Grimoire Caeruleam NIFSoft"
	desc = "Contains a single Grimoire Caeruleam NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 0.75
	contains = list(
		/obj/item/disk/nifsoft_uploader/summoner,
	)

/datum/supply_pack/goody/firstaid_pouch
	name = "Mini-Medkit First Aid Pouch"
	desc = "Contains a single surplus first-aid pouch, complete with pocket clip. Repackaged with station-standard medical supplies, \
	but nothing's stopping you from repacking it yourself, though."
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/loaded,
	)

/datum/supply_pack/goody/stabilizer_pouch
	name = "Stabilizer First Aid Pouch"
	desc = "Contains a single surplus first-aid pouch, complete with pocket clip. Repackaged with a wound stabilizing-focused loadout, \
	but nothing's stopping you from repacking it yourself, though."
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/stabilizer,
	)

/datum/supply_pack/goody/wetmaker
	name = "Stardress hydro-vaporizer"
	desc = "Interesting Azulean technology, allowing the wearer to stay relatively moisturized at all times."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/clothing/accessory/vaporizer,
	)

/*
* NEUROWARE CHIPS
*/
/datum/supply_pack/goody/brass_neuroware
	name = "Brass/Wind Instruments Neuroware Chip"
	desc = "Contains a single neuroware chip with wind and brass synthesizer instruments, for synthetic persons with persocom units."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/disk/neuroware/synthesizer/brass)

/datum/supply_pack/goody/guitar_neuroware
	name = "Guitar/Strings Instruments Neuroware Chip"
	desc = "Contains a single neuroware chip with guitar and string synthesizer instruments, for synthetic persons with persocom units."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/disk/neuroware/synthesizer/guitar)

/datum/supply_pack/goody/percussion_neuroware
	name = "Percussion Instruments Neuroware Chip"
	desc = "Contains a single neuroware chip with percussion synthesizer instruments, for synthetic persons with persocom units."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/disk/neuroware/synthesizer/percussion)

/datum/supply_pack/goody/piano_neuroware
	name = "Piano Instruments Neuroware Chip"
	desc = "Contains a single neuroware chip with piano synthesizer instruments, for synthetic persons with persocom units."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/disk/neuroware/synthesizer/piano)
