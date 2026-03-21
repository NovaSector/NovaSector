/datum/export/xenoarch
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "broken object"
	export_types = list(/obj/item/xenoarch/broken_item)
	include_subtypes = TRUE
	k_elasticity = 0

//broken items
/obj/item/xenoarch/broken_item
	name = "broken tech"
	icon_state = "recover_tech"
	desc = "An item that has been damaged, destroyed for quite some time. It is possible to recover it. Some people would pay well for an item like this."
	var/loot = /obj/effect/spawner/random/xenoarch
	var/dig_xp = 7

/obj/item/xenoarch/broken_item/weapon
	name = "broken weapon"
	icon_state = "recover_weapon"
	loot = /obj/effect/spawner/random/xenoarch/weapon
	dig_xp = 10

/obj/item/xenoarch/broken_item/illegal
	name = "broken unknown object"
	icon_state = "recover_illegal"
	loot = /obj/effect/spawner/random/xenoarch/illegal
	dig_xp = 10

/obj/item/xenoarch/broken_item/alien
	name = "broken unknown object"
	icon_state = "recover_illegal"
	loot = /obj/effect/spawner/random/xenoarch/alien
	dig_xp = 10

/obj/item/xenoarch/broken_item/plant
	name = "withered plant"
	desc = "A plant that is long past its prime. It is possible to recover it."
	icon_state = "recover_plant"
	loot = /obj/effect/spawner/random/xenoarch/plant
	dig_xp = 5

/obj/item/xenoarch/broken_item/animal
	name = "preserved animal carcass"
	desc = "An animal that is long past its prime. It is possible to recover it. Can be swabbed to recover its original animal's remnant DNA."
	icon_state = "recover_animal"
	loot = /obj/effect/spawner/random/xenoarch/animal
	dig_xp = 5

/obj/item/xenoarch/broken_item/animal/Initialize(mapload)
	. = ..()
	var/pick_celltype = pick(CELL_LINE_TABLE_BEAR,
							CELL_LINE_TABLE_BLOBBERNAUT,
							CELL_LINE_TABLE_BLOBSPORE,
							CELL_LINE_TABLE_CARP,
							CELL_LINE_TABLE_CAT,
							CELL_LINE_TABLE_CHICKEN,
							CELL_LINE_TABLE_COCKROACH,
							CELL_LINE_TABLE_CORGI,
							CELL_LINE_TABLE_COW,
							CELL_LINE_TABLE_MOONICORN,
							CELL_LINE_TABLE_GELATINOUS,
							CELL_LINE_TABLE_GRAPE,
							CELL_LINE_TABLE_MEGACARP,
							CELL_LINE_TABLE_MOUSE,
							CELL_LINE_TABLE_PINE,
							CELL_LINE_TABLE_PUG,
							CELL_LINE_TABLE_SLIME,
							CELL_LINE_TABLE_SNAKE,
							CELL_LINE_TABLE_VATBEAST,
							CELL_LINE_TABLE_NETHER,
							CELL_LINE_TABLE_GLUTTON,
							CELL_LINE_TABLE_FROG,
							CELL_LINE_TABLE_WALKING_MUSHROOM,
							CELL_LINE_TABLE_QUEEN_BEE,
							CELL_LINE_TABLE_MEGA_ARACHNID)
	AddElement(/datum/element/swabable, pick_celltype, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/xenoarch/broken_item/clothing
	name = "petrified clothing"
	desc = "A piece of clothing that has long since lost its beauty."
	icon_state = "recover_clothing"
	loot = /obj/effect/spawner/random/xenoarch/clothing
	dig_xp = 7

//circuit boards
/obj/item/circuitboard/machine/xenoarch_machine
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2,
	)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	name = "Xenoarch Researcher (Machine Board)"
	build_path = /obj/machinery/xenoarch/researcher

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner
	name = "Xenoarch Scanner (Machine Board)"
	build_path = /obj/machinery/xenoarch/scanner

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger
	name = "Xenoarch Digger (Machine Board)"
	build_path = /obj/machinery/xenoarch/digger

/obj/item/paper/fluff/xenoarch_guide
	name = "xenoarchaeology guide - MUST READ"
	default_raw_text = {"<b><center>Xenoarchaeology Guide</center></b><br> \
			Let's start right from the beginning: what is Xenoarchaeology?<br> \
			Great question! Xenoarchaeology is the study of ancient foreign bodies that are trapped within strange rocks.<br> \
			Your goal as a xenoarchaeologist is to find these strange rocks and unearth the secrets that are held within.<br> \
			You will find that these rocks are plentiful throughout the astronomical bodies that we typically orbit.<br> \
			<br> \
			<b>Tools of the Trade</b><br> \
			<br> \
			There are plenty of tools that are required (and some just for the quality of life for the xenoarchaeologist).<br> \
			There are the hammers, the brushes, the tape, the belt, the bag, the handheld machines, and the machines.<br> \
			In this line of work, the brushes and hammers will be the bread and butter.<br> \
			They will allow you to unearth the foreign bodies held within the strange rocks.<br> \
			The hammers (with varying depths) allow you to reach the depths in a faster manner than the brushes.<br> \
			The brushes allow you to uncover the items within the proper depths without damaging it.<br> \
			The tape will allow you to tag the strange rock with the current depth. Continue to examine the rock for updates.<br> \
			The belt will allow you to store your mobile/handheld tools for easy access.<br> \
			The bag will allow you to store and automatically pickup strange rocks that you find lying on the floor.<br> \
			The handheld machines allow you to not have to be stuck at the machines. There are only handheld scanners and radars.<br> \
			The Scanner is a machine which allows you to tag the strange rock with its max and safe depth, works as an advanced handheld scanner.<br> \
			The Researcher is a machine that allows you to compile/condense relics and items into larger strange artifacts.<br> \
			<br> \
			<b>The Process</b><br> \
			<br> \
			1) Find yourself a strange rock out in the wilderness.<br> \
			1.A) Use the handheld radar and do a deep scan, there is an ALT button for it on the underside. Do this in a mining sector.<br> \
			1.B) Activate the handheld radar in your hands and see where the compass directs you, follow the light, but watch out for dangers!<br> \
			1.C) Use the handheld radar on the ground where you think is the dig site, if you are successful, you will find the rocks!<br> \
			2) Go back to (or stay in) the xenoarchaeology laboratory.<br> \
			3) Process the rock in the scanner (or use the handheld scanner). The Scanner Machine is as good as the advanced handheld scanners they have at Central.<br> \
			4) Use the measuring tape on the rock.<br> \
			5) Subtract the safe depth (SD) from the max depth (MD).<br> \
				5a) QUESTION: What is the depth you dig <i>to</i> when the MD is 50 and the SD is 16?<br> \
					ANSWER: 34. Just make sure to not dig 34 as there will be previous depth involved.<br> \
			6) Subtract the current depth (CD) from the answer to step 5.<br> \
			7) Use the hammers to dig the answer to step 6.<br> \
			8) Once you've reached the answer to step 5, use the brush until you reveal the item.<br> \
			9) Enjoy the use of your unearthed secret!<br> \
				9a) If it is a broken item, sell it or use a brush on it for a surprise.<br> \
			<br> \
			I hope this has been helpful and I wish you great success!<br> \
			<br> \
			<i>- KB</i><br> \
			Director of Xenoarchaeological Studies"}

/obj/item/organ/monster_core/regenerative_core/legion/preserved

/obj/item/organ/monster_core/regenerative_core/legion/preserved/Initialize(mapload)
	. = ..()
	src.preserve()

/obj/item/organ/monster_core/rush_gland/preserved

/obj/item/organ/monster_core/rush_gland/preserved/Initialize(mapload)
	. = ..()
	src.preserve()

/obj/item/organ/monster_core/brimdust_sac/preserved

/obj/item/organ/monster_core/brimdust_sac/preserved/Initialize(mapload)
	. = ..()
	src.preserve()

/obj/item/coin/gold/ancient
	name = "ancient doubloon"
	override_material_worth = TRUE
	value = CARGO_CRATE_VALUE * 2.5

/obj/item/coin/adamantine/ancient
	name = "ancient doubloon"
	override_material_worth = TRUE
	value = CARGO_CRATE_VALUE * 5

/obj/item/coin/mythril/ancient
	name = "ancient doubloon"
	override_material_worth = TRUE
	value = CARGO_CRATE_VALUE * 12.5

/obj/item/stack/sheet/sinew/five
	amount = 5

/obj/item/stack/sheet/bone/ten
	amount = 10

/obj/item/stack/sheet/animalhide/goliath_hide/three
	amount = 3

/obj/item/relic/lavaland/activated
	desc = "A strange relic. This one seems active and calls for a touch to activate its properties."

/obj/item/relic/lavaland/activated/Initialize(mapload)
	. = ..()
	src.reveal()

/obj/item/storage/box/incomplete_chameleon
	name = "Incomplete Chameleon Kit"
	desc = "A set of items that contain chameleon technology allowing you to disguise as pretty much anything on the station, and more! \
			This one seems to have some stuff missing, and clearly put in a box smaller than what it should be."

/obj/item/storage/box/incomplete_chameleon/PopulateContents() 
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)

/obj/item/storage/box/fakesyndiesuit/voskhod
	name = "boxed voskhod replica space suit and helmet"
	desc = "A sleek, sturdy box used to hold toy- wait, this has the real thing!"

/obj/item/storage/box/fakesyndiesuit/voskhod/PopulateContents() 
	new /obj/item/clothing/suit/space/voskhod(src)
	new /obj/item/clothing/head/helmet/space/voskhod(src)

/obj/item/ammo_casing/energy/shrink/faulty
	projectile_type = /obj/projectile/magic/shrink/alien
	select_name = "shrink ray"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)

/obj/item/gun/energy/shrink_ray/faulty
	name = "faulty shrink ray blaster"
	desc = "This is a piece of frightening alien tech that enhances the magnetic pull of atoms in a localized space to temporarily make an object shrink. \
			Seems... haphazardly jury-rigged to work with human tech, but its likely good for shrinking stuff."
	ammo_type = list(/obj/item/ammo_casing/energy/shrink/faulty)
	pin = /obj/item/firing_pin
	w_class = WEIGHT_CLASS_HUGE // so it cannot be stored. 
