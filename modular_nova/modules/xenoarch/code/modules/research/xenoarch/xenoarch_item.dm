/datum/export/xenoarch
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "broken object"
	export_types = list(/obj/item/xenoarch/broken_item)
	include_subtypes = TRUE
	k_elasticity = 0

/// sediment encased items
/obj/item/xenoarch/broken_item
	name = "sediment encased tech"
	icon_state = "recover_tech"
	desc = "An item caked in layers of sediment and dust. Careful brushing might reveal what lies beneath."
	var/loot = /obj/effect/spawner/random/xenoarch

/obj/item/xenoarch/broken_item/t1
	loot = /obj/effect/spawner/random/xenoarch/t1

/obj/item/xenoarch/broken_item/weapon
	name = "sediment encased weapon"
	icon_state = "recover_weapon"
	loot = /obj/effect/spawner/random/xenoarch/weapon

/obj/item/xenoarch/broken_item/weapon/t3
	loot = /obj/effect/spawner/random/xenoarch/weapon/t3

/obj/item/xenoarch/broken_item/illegal
	name = "sediment encased unknown object"
	icon_state = "recover_illegal"
	loot = /obj/effect/spawner/random/xenoarch/illegal

/obj/item/xenoarch/broken_item/illegal/t3
	loot = /obj/effect/spawner/random/xenoarch/illegal/t3

/obj/item/xenoarch/broken_item/alien
	name = "sediment encased unknown object"
	icon_state = "recover_illegal"
	loot = /obj/effect/spawner/random/xenoarch/alien

/obj/item/xenoarch/broken_item/alien/t3
	loot = /obj/effect/spawner/random/xenoarch/alien/t3

/obj/item/xenoarch/broken_item/plant
	name = "sediment encased seeds"
	desc = "Plant seeds encased in layers of dirt and sediment. Careful brushing might reveal its original form."
	icon_state = "recover_plant"
	loot = /obj/effect/spawner/random/xenoarch/plant

/obj/item/xenoarch/broken_item/animal
	name = "preserved animal carcass"
	desc = "An animal remnant encased in layers of sediment. Careful cleaning could reveal its original form, can be swabbed to recover its original animal's remnant DNA."
	icon_state = "recover_animal"
	loot = /obj/effect/spawner/random/xenoarch/animal

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
	name = "sediment encased clothing"
	desc = "A piece of clothing or protective gear covered in dirt and debris. With careful brushing, its original condition might be restored."
	icon_state = "recover_clothing"
	loot = /obj/effect/spawner/random/xenoarch/clothing

/obj/item/xenoarch/broken_item/clothing/t3
	loot = /obj/effect/spawner/random/xenoarch/clothing/t3

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

/obj/item/coin/silver/ancient
	name = "ancient doubloon"
	override_material_worth = TRUE
	value = CARGO_CRATE_VALUE * 1.25

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

/obj/item/clothing/gloves/color/black/thief/xenoarch
	desc = parent_type::desc + " Their light fabric would make it harder for others to notice their touch."

/obj/item/clothing/shoes/chameleon/noslip/xenoarch
	desc = parent_type::desc + " They seem to have improved traction."

/datum/mood_event/faded_hope_lavaland
	description = "What a peculiar emblem. It makes me feel hopeful for my future."
	mood_change = 4 // two thirds of the original.

/obj/item/clothing/accessory/pandora_hope/faded
	name = "Faded Hope"
	desc = "A worn symbol, its surface scratched by time and buried under layers of sediment. Whatever it once stood for is long forgotten."

/obj/item/clothing/accessory/pandora_hope/faded/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	user.add_mood_event("faded_hope_lavaland", /datum/mood_event/faded_hope_lavaland)

/obj/item/clothing/accessory/pandora_hope/faded/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	user.clear_mood_event("faded_hope_lavaland")

/obj/item/shield/buckler/faded
	name = "faded buckler"
	desc = "A faded wooden buckler, brittle and scarred by age. It carries a strange resilience, as if it can turn aside any strike, until it finally gives in."
	block_chance = 100
	max_integrity = 25
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = null

/// A raptor egg that piggy backs on the watcher podometer and uses a spawn for 
/obj/item/food/egg/watcher/raptor
	name = "cold raptor egg"
	desc = "A lonely egg still pulsing with life, somehow untouched by the corruption of the Necropolis."
	icon = 'icons/mob/simple/lavaland/raptor_baby.dmi'
	icon_state = "raptor_egg"
	chick_throw_prob = 0
	steps_to_hatch = 300
	tastes = list("loneliness" = 5)
	starting_reagent_purity = 1

/obj/item/food/egg/watcher/raptor/on_stepped(atom/movable/egg, atom/mover, atom/old_loc, direction)
	var/new_loc = get_turf(egg)
	if (isnull(new_loc) || new_loc == get_turf(old_loc))
		return // Didn't actually go anywhere
	steps_travelled++
	if (steps_travelled == steps_to_hatch * 0.5)
		jiggle()
		return
	if (steps_travelled < steps_to_hatch)
		return
	visible_message(span_boldnotice("[src] splits and unfurls into a baby Watcher!"))
	playsound(new_loc, 'sound/mobs/non-humanoids/chicken/chick_peep.ogg', 50, TRUE)
	new /obj/effect/spawner/random/lavaland_mob/raptor/baby(new_loc)
	qdel(src)

/obj/item/storage/box/shuttle_construction_kit
	name = "Old Shuttle Construction Starter Kit"
	desc = "An old shuttle construction kit, its contents worn but intact. Inside are faded blueprints and the circuitboards needed to \
			assemble a basic shuttle. The instructions on the side of the box are unreadable though."

/obj/item/storage/box/shuttle_construction_kit/PopulateContents() 
	new /obj/item/circuitboard/computer/shuttle/docker(src)
	new	/obj/item/circuitboard/computer/shuttle/flight_control(src)
	new	/obj/item/circuitboard/machine/engine/propulsion(src)
	new	/obj/item/circuitboard/machine/engine/propulsion(src)
	new	/obj/item/shuttle_blueprints(src)
	new	/obj/item/stack/rods/shuttle/fifty(src)

// This is just a cowboy hat (with minimal armor) that its sole function is to perfectly block a hit to the head and then flip out of the head of the user and away 3-5 tiles. It has a few seconds of cooldown from such, so even if players find a way to quickly reattach it, it wont be a sure protection. 
/obj/item/clothing/head/cowboy/bounty/deadman
	name = "dead man's brim"
	desc = "A wide-brimmed black hat with a polished golden band. It sits just loose enough to be thrown clear at the first sign of trouble, taking the hit with it."
	deflect_chance = 100

// static medibot, heals double like the delerict one you can fetch from the delerict or similar ruins.
/mob/living/basic/bot/medbot/xenoarch
	name = "\improper Dirt Covered Medibot"
	desc = "A medibot whose chasis seems to be still covered with clunks of hardened dirt. Its wheels seem broken."
	skin = "adv"
	medical_mode_flags = MEDBOT_STATIONARY_MODE | MEDBOT_SPEAK_MODE
	damage_type_healer = HEAL_ALL_DAMAGE
	heal_threshold = 0
	heal_amount = 3.5
