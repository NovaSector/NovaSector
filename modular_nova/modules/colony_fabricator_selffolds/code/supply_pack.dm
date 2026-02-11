// Supply packs for cargo consoles.

/datum/supply_pack/engineering/colony_buildings
	name = "Prefabricated buildings Kit"
	desc = "Assortment of premade buildings nodes for when anchorage is a matter of time. Nakamura made, civilian version of Solarian Federation colony designs."
	cost = CARGO_CRATE_VALUE * 15 // Its mostly cheap plastic, most of the pack are simple walls, solars make 30kw tops, medical is unpowered and serves as simple first aid room, infrastructure is just basic atmos setup of 5 pipes and some machinery to jumpstart colony powerwise.
	access_view = ACCESS_ENGINEERING
	contains = list(
		/obj/item/survivalcapsule/prefab/airlock,
		/obj/item/survivalcapsule/prefab/airlock,
		/obj/item/survivalcapsule/prefab/medical,
		/obj/item/survivalcapsule/prefab/room_10,
		/obj/item/survivalcapsule/prefab/solarunit,
		/obj/item/survivalcapsule/prefab/infrastructure,
	)
	crate_name = "Prefabricated Structures Kit"

/datum/supply_pack/engineering/colony_blueprints
	name = "Prefabricated Structures Kit"
	desc = "Assortment of premade structural elements, be the maker of your own place - today. Nakamura made, civilian version of Solarian Federation colony designs."
	cost = CARGO_CRATE_VALUE * 5 // This like a stack of plastic, 2 manual airlocks and some hope.
	access_view = ACCESS_ENGINEERING
	contains = list(
		/obj/item/survivalcapsule/prefab/room_7,
		/obj/item/survivalcapsule/prefab/wall5v,
		/obj/item/survivalcapsule/prefab/wall5v,
		/obj/item/survivalcapsule/prefab/wall5v,
		/obj/item/survivalcapsule/prefab/wall5v,
		/obj/item/survivalcapsule/prefab/wall5h,
		/obj/item/survivalcapsule/prefab/wall5h,
		/obj/item/survivalcapsule/prefab/wall5h,
		/obj/item/survivalcapsule/prefab/wall5h,
		/obj/item/flatpacked_machine/airlock_kit_manual,
		/obj/item/flatpacked_machine/airlock_kit_manual,
	)
	crate_name = "Prefabricated Hulls Kit"

/datum/supply_pack/engineering/prefab_room_7_Airlocked
	name = "Nakamura LC-07 Airlocked Setup"
	desc = "Self-folded portative capsule containing a premade structure to suit your needs. 7x7"
	cost = CARGO_CRATE_VALUE * 4 // Because giving people a way to setup a place for personal projects is nice
	contains = list(
	/obj/item/survivalcapsule/prefab/room_7,
	/obj/item/flatpacked_machine/airlock_kit_manual,
	)
	crate_name = "Nakamura LC-07 Airlocked Kit"

/datum/supply_pack/engineering/prefab_solarunit
	name = "Nakamura Heliantus-8"
	desc = "Popular solar platform, easy to deploy, cheap, simple and decent power solution."
	cost = CARGO_CRATE_VALUE * 4 // Main price comes from some materials and convinience. A person buying this, is either desperate, lost, or doing a thing. Also okayish backup plan for the backup plan.
	contains = list(
	/obj/item/survivalcapsule/prefab/solarunit,
	)
	crate_name = "Nakamura Heliantus-8 Solar Node"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/science/prefab_production
	name = "Nakamura Type-45 LEGACY Production and Research kit"
	desc = "Self-folded portative capsule containing a premade structure to suit your needs. This one smells of buttered chicken... and peaches? 5x5"
	cost = CARGO_CRATE_VALUE * 6 // Just a room, but contains interesting and useful technology and DIY xenobio and xenoarch gear. Basically low cost science starter kit. Could be also used as a good resupply pod for events and all.
	access_view = ACCESS_SCIENCE //Because its very specialised and should not be sold to common folk, unless a willing scientist thinks they can be trusted.
	contains = list(
	/obj/item/survivalcapsule/prefab/production,
	)
	crate_name = "Nakamura Type-45 LEGACY Production and Research kit"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/service/prefab_botany
	name = "Nakamura X NT Sustenance Greenhouse"
	desc = "Self-folded portative capsule containing a premade structure to suit your needs. Oh hey, why does it smell of pickles??? 7x7"
	cost = CARGO_CRATE_VALUE * 3 // Its a 7x7 with dirt and hope for some food, cmon, you can get this on 2 minute lavaland trip
	contains = list(
	/obj/item/survivalcapsule/prefab/botany,
	)
	crate_name = "Nakamura X NT Sustenance Greenhouse"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/engineering/prefab_factory
	name = "Nakamura Streamline Basics"
	desc = "Self-folded portative capsule containing a premade structure to suit your needs. Why does it have a green felinid gal and heavy machinery warning stickers? 11x11"
	cost = CARGO_CRATE_VALUE * 10 // By far, its huge, it has machines premade and has decent tools, as well as means to be powered right out of the box. Its publically available however. If price is too low, it could be too spammable.
	contains = list(
	/obj/item/survivalcapsule/prefab/factory,
	)
	crate_name = "Nakamura Streamline Basics Factory"
	crate_type = /obj/structure/closet/crate/engineering

// Cheap alone, fair price when in bulk. Plenty uses - DIY hull patch, project building, maybe even on demand light cover.
/datum/supply_pack/goody/prefab_wall3h
	name = "Horizontal 3x1 Wall"
	desc = "Finally, build your own plastic castle."
	cost = PAYCHECK_CREW * 1.5
	contains = list(/obj/item/survivalcapsule/prefab/wall3h)

/datum/supply_pack/goody/prefab_wall3v
	name = "Vertical 3x1 Wall"
	desc = "Finally, build your own plastic castle."
	cost = PAYCHECK_CREW * 1.5
	contains = list(/obj/item/survivalcapsule/prefab/wall3v)

/datum/supply_pack/goody/prefab_wall5h
	name = "Horizontal 5x1 Wall"
	desc = "Finally, build your own plastic castle."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/survivalcapsule/prefab/wall5h)

/datum/supply_pack/goody/prefab_wall5v
	name = "Vertical 5x1 Wall"
	desc = "Finally, build your own plastic castle."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/survivalcapsule/prefab/wall5v)

/datum/supply_pack/goody/prefab_room_7
	name = "Nakamura LC-07 Template Room"
	desc = "Finally, build your own plastic kingdom."
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/survivalcapsule/prefab/room_7)

/datum/supply_pack/goody/prefab_room_10
	name = "Nakamura LC-10 Template Room"
	desc = "Finally, build your own plastic kingdom."
	cost = PAYCHECK_CREW * 10
	contains = list(/obj/item/survivalcapsule/prefab/room_10)

/datum/supply_pack/security/prefab_defenseplatform
	name = " SINGLE Solarian Federation EXP-40 Reinforced Emplacement"
	desc = "Self-folded portative capsule containing an automated defense countermeasure, desperate pirates crack those open to put turrets on their scrapheaps as DIY ship weapons. 3x3 but needs 1 space away from each other."
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/survivalcapsule/prefab/defenseplatform)

/datum/supply_pack/security/prefab_defenseplatform/bulk
	name = " BULK Solarian Federation EXP-40 Reinforced Emplacement"
	desc = "Self-folded portative capsule containing an automated defense countermeasure, desperate pirates crack those open to put turrets on their scrapheaps as DIY ship weapons. 3x3 but needs 1 space away from each other."
	cost = CARGO_CRATE_VALUE * 12
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/survivalcapsule/prefab/defenseplatform,
					/obj/item/survivalcapsule/prefab/defenseplatform,
					/obj/item/survivalcapsule/prefab/defenseplatform,
	)

/datum/supply_pack/security/prefab_medical
	name = "Deforest Infirmary Pattern Tent"
	desc = "Self-folded portative capsule containing a premade medical tent with basic surgical tools and ability to revivify. Lock those Hem-issues with your skill in the field. 5x5"
	cost = CARGO_CRATE_VALUE * 8 //It has good gear for its price, a skilled person can really make a lot out of this in the field.
	access_view = ACCESS_MEDICAL
	contains = list(/obj/item/survivalcapsule/prefab/medical)
