/*
 * The requisition catalogue: what the console will call down, and nothing else. The machinery that
 * ships it lives in home_supply.dm - this file is pure data, so a line can be added without reading
 * a word of the delivery code.
 *
 * Every line hangs off a category parent rather than setting `category` itself. The parents carry no
 * name, so preload_supply_catalogue() skips them, and a whole category can be renamed or reordered
 * in one place. Put a new line under the parent it belongs to and there is nothing else to do.
 *
 * REMEMBER: everything a pod delivers is marked TRAIT_HOME_FURNISHING and can never leave the
 * residence. That is what makes the free tier safe, not restraint in what gets listed here - weigh a
 * new line against that, rather than against how expensive it looks.
 */

/// Raw sheet goods, and the two stacks every build needs.
/datum/home_supply/structural
	category = "Structural"
	category_order = 10

/// The warm materials: timber, textiles, and what you make screens and soft furnishings out of.
/// Kept to one short word because the console renders these as a tab strip - a long label squeezes
/// every other tab.
/datum/home_supply/organic
	category = "Organics"
	category_order = 20

/// Anything that goes down as a floor.
/datum/home_supply/flooring
	category = "Flooring"
	category_order = 30

/// Fixtures and machines that arrive built rather than as material.
/datum/home_supply/appliances
	category = "Appliances"
	category_order = 40

/// Devices for putting the above together.
/datum/home_supply/tools
	category = "Tools"
	category_order = 50

/// Gated on the parent, so anything filed under here needs an admin whether or not whoever added it
/// remembered to say so. Add to this branch rather than setting needs_approval by hand.
/datum/home_supply/restricted
	category = "Restricted"
	category_order = 60
	needs_approval = TRUE

/*
 * Structural.
 */

/datum/home_supply/structural/iron
	name = "Iron sheets"
	desc = "The bones of most things worth building."
	manifest = list(/obj/item/stack/sheet/iron = 50)

/datum/home_supply/structural/glass
	name = "Glass sheets"
	manifest = list(/obj/item/stack/sheet/glass = 50)

/datum/home_supply/structural/reinforced_glass
	name = "Reinforced glass"
	manifest = list(/obj/item/stack/sheet/rglass = 30)

/datum/home_supply/structural/sandstone
	name = "Sandstone blocks"
	manifest = list(/obj/item/stack/sheet/mineral/sandstone = 50)

/datum/home_supply/structural/plastic
	name = "Plastic sheets"
	desc = "Cheap, and it shows."
	manifest = list(/obj/item/stack/sheet/plastic = 50)

/datum/home_supply/structural/plasteel
	name = "Plasteel sheets"
	desc = "Structural alloy, for walls that mean it."
	manifest = list(/obj/item/stack/sheet/plasteel = 30)

/datum/home_supply/structural/titanium
	name = "Titanium sheets"
	manifest = list(/obj/item/stack/sheet/mineral/titanium = 30)

/datum/home_supply/structural/plastitanium
	name = "Plastitanium sheets"
	manifest = list(/obj/item/stack/sheet/mineral/plastitanium = 30)

/datum/home_supply/structural/precious
	name = "Precious metals"
	desc = "Gold and diamond, for the discerning resident."
	manifest = list(
		/obj/item/stack/sheet/mineral/gold = 20,
		/obj/item/stack/sheet/mineral/diamond = 10,
	)

/datum/home_supply/structural/rods
	name = "Metal rods"
	manifest = list(/obj/item/stack/rods = 50)

/datum/home_supply/structural/cable
	name = "Cable coil"
	manifest = list(/obj/item/stack/cable_coil = 30)

/*
 * Timber & Textiles.
 */

/datum/home_supply/organic/wood
	name = "Wooden planks"
	desc = "Warmer underfoot than plating."
	manifest = list(/obj/item/stack/sheet/mineral/wood = 50)

/datum/home_supply/organic/bamboo
	name = "Bamboo cuttings"
	desc = "Builds walls, screens, and a passable set of wind chimes."
	manifest = list(/obj/item/stack/sheet/mineral/bamboo = 50)

/datum/home_supply/organic/paper_frames
	name = "Paper frames"
	desc = "Thin wooden frames with paper stretched over them. Screens, sliding doors, and very \
		little privacy."
	manifest = list(/obj/item/stack/sheet/paperframes = 50)

/datum/home_supply/organic/cloth
	name = "Cloth"
	desc = "For soft furnishings, and anything that would rather not be made of iron."
	manifest = list(/obj/item/stack/sheet/cloth = 50)

/datum/home_supply/organic/leather
	name = "Leather"
	desc = "Hard-wearing, and it improves with age."
	manifest = list(/obj/item/stack/sheet/leather = 30)

/*
 * Flooring.
 */

/datum/home_supply/flooring/floor_tiles
	name = "Floor tiles"
	manifest = list(/obj/item/stack/tile/iron = 60)

/datum/home_supply/flooring/carpet
	name = "Carpet"
	desc = "The plainest of the plain, but still soft and comfy."
	manifest = list(/obj/item/stack/tile/carpet = 60)

/datum/home_supply/flooring/carpet_black
	name = "Carpet - Black"
	manifest = list(/obj/item/stack/tile/carpet/black = 60)

/datum/home_supply/flooring/carpet_blue
	name = "Carpet - Blue"
	manifest = list(/obj/item/stack/tile/carpet/blue = 60)

/datum/home_supply/flooring/carpet_cyan
	name = "Carpet - Cyan"
	manifest = list(/obj/item/stack/tile/carpet/cyan = 60)

/datum/home_supply/flooring/carpet_green
	name = "Carpet - Green"
	manifest = list(/obj/item/stack/tile/carpet/green = 60)

/datum/home_supply/flooring/carpet_orange
	name = "Carpet - Orange"
	manifest = list(/obj/item/stack/tile/carpet/orange = 60)

/datum/home_supply/flooring/carpet_purple
	name = "Carpet - Purple"
	manifest = list(/obj/item/stack/tile/carpet/purple = 60)

/datum/home_supply/flooring/carpet_red
	name = "Carpet - Red"
	manifest = list(/obj/item/stack/tile/carpet/red = 60)

/datum/home_supply/flooring/carpet_royal_black
	name = "Carpet - Royal Black"
	desc = "For a room that means to be taken seriously."
	manifest = list(/obj/item/stack/tile/carpet/royalblack = 60)

/datum/home_supply/flooring/carpet_royal_blue
	name = "Carpet - Royal Blue"
	manifest = list(/obj/item/stack/tile/carpet/royalblue = 60)

/datum/home_supply/flooring/grass
	name = "Grass turf"
	desc = "The sort they lay on space golf courses."
	manifest = list(/obj/item/stack/tile/grass = 60)

/datum/home_supply/flooring/fairygrass
	name = "Fairygrass turf"
	desc = "Odd, glowing, and blue. Lights a room on its own."
	manifest = list(/obj/item/stack/tile/fairygrass = 60)

/datum/home_supply/flooring/astral_carpet
	name = "Astral Carpet"
	desc = "Space without the space."
	manifest = list(/obj/item/stack/tile/fakespace = 60)

/*
 * Appliances. Machines arrive assembled - /obj/machinery/Initialize() fits the default parts off the
 * circuit, so one spawned into a pod is as complete as a mapped-in one. They need no APC either:
 * /area/misc/player_home is requires_power = FALSE
 *
 * The autolathe is restricted and needs approval since it can, y'know, print stuff and should only
 * Really be used for setting up a home. Not for keeping once the home is done. Small TODO.
 */

/datum/home_supply/appliances/compactor
	name = "Waste compactor"
	desc = "A bin that destroys what you put in it. Alt-click to run it."
	manifest = list(/obj/structure/closet/crate/bin/home_compactor = 1)

/datum/home_supply/appliances/microwave
	name = "Microwave"
	desc = "For cooking, and for the noises it makes while cooking."
	manifest = list(/obj/machinery/microwave = 1)

/datum/home_supply/appliances/range
	name = "Range"
	desc = "An oven with a stove on top of it."
	manifest = list(/obj/machinery/oven/range = 1)

/datum/home_supply/appliances/processor
	name = "Food processor"
	desc = "Turns ingredients into other, smaller ingredients."
	manifest = list(/obj/machinery/processor = 1)

/datum/home_supply/appliances/grinder
	name = "All-in-one grinder"
	desc = "Grinds and juices whatever you put in it."
	manifest = list(/obj/machinery/reagentgrinder = 1)

/datum/home_supply/appliances/soda_dispenser
	name = "Soda dispenser"
	desc = "A reservoir of soft drinks, and something to pour them into."
	manifest = list(/obj/machinery/chem_dispenser/drinks = 1)

/datum/home_supply/appliances/booze_dispenser
	name = "Booze dispenser"
	desc = "The same, with the good stuff."
	manifest = list(/obj/machinery/chem_dispenser/drinks/beer = 1)

/datum/home_supply/appliances/boozeomat
	name = "Booze-O-Mat"
	desc = "Bottles and glassware, vended."
	manifest = list(/obj/machinery/vending/boozeomat/cafe = 1)

/datum/home_supply/appliances/condimaster
	name = "CondiMaster 3000"
	desc = "Bottles condiments and cooking supplies."
	manifest = list(/obj/machinery/chem_master/condimaster = 1)

/datum/home_supply/appliances/washing_machine
	name = "Washing machine"
	desc = "Takes the stains out, and the colours if you are careless."
	manifest = list(/obj/machinery/washing_machine = 1)

/datum/home_supply/appliances/freezer
	name = "Freezer"
	desc = "Cold on the inside."
	manifest = list(/obj/structure/closet/secure_closet/freezer/empty/open = 1)

/*
 * Tools.
 */

/datum/home_supply/tools/construction_toolbelt
	name = "Construction Toolbelt"
	desc = "Everything needed to put a wall up and take it down again."
	manifest = list(/obj/item/storage/belt/utility/chief/full = 1)

/datum/home_supply/tools/electrical_tools
	name = "Electrical toolbox"
	manifest = list(/obj/item/storage/toolbox/electrical = 1)

/datum/home_supply/tools/welding_kit
	name = "Welding kit"
	desc = "A welding tool and something to save your eyes with."
	manifest = list(
		/obj/item/weldingtool/electric = 1,
		/obj/item/clothing/glasses/welding = 1,
	)

/datum/home_supply/tools/painter
	name = "Airlock painter"
	manifest = list(/obj/item/airlock_painter = 1)

/datum/home_supply/tools/decal_painter
	name = "Decal painter"
	desc = "Sprays decals onto floor tiles. Ships with an ordinary cartridge; the decals come off with \
		the tiles they are on."
	manifest = list(/obj/item/airlock_painter/decal = 1)

/datum/home_supply/tools/infinite_toner
	name = "Infinite toner cartridge"
	desc = "Never runs dry. Alt-click a painter to pop its cartridge out, then put this one in."
	manifest = list(/obj/item/toner/infinite = 1)

/datum/home_supply/tools/rcd
	name = "Rapid construction device"
	desc = "Builds walls and floors on its own."
	manifest = list(/obj/item/construction/rcd/loaded = 1)

/datum/home_supply/tools/rpd
	name = "Rapid pipe dispenser"
	manifest = list(/obj/item/pipe_dispenser = 1)

/datum/home_supply/tools/rld
	name = "Rapid lighting device"
	desc = "Fits light tubes and glow sticks, in any colour you like."
	manifest = list(/obj/item/construction/rld = 1)

/datum/home_supply/tools/rdd
	name = "Rapid decoration device"
	desc = "Prints plastic replicas of natural scenery."
	manifest = list(/obj/item/construction/rdd/loaded = 1)

/datum/home_supply/tools/rtd
	name = "Rapid tiling device"
	desc = "For when laying tiles by hand is too much work."
	manifest = list(/obj/item/construction/rtd/loaded = 1)

/datum/home_supply/tools/light_replacer
	name = "Bluespace light replacer"
	desc = "Refills off glass sheets."
	manifest = list(/obj/item/lightreplacer/blue = 1)

/datum/home_supply/tools/nvg
	name = "Night Vision Goggles"
	desc = "For when you want to build in the dark. Remember not to weld with them on."
	manifest = list(/obj/item/clothing/glasses/night = 1)

/*
 * Restricted. The parent gates these - do not set needs_approval by hand down here.
 */

/datum/home_supply/restricted/bluespace
	name = "Bluespace crystals"
	desc = "Requires approval."
	manifest = list(/obj/item/stack/sheet/bluespace_crystal = 5)

/**
 * Filed here because it is the one appliance that could break the closed economy, not because it is
 * expensive. An autolathe turns sheets into items, and the items it prints are born WITHOUT
 * TRAIT_HOME_FURNISHING - including sheets. Feed it the plasteel and gold this catalogue hands out
 * free every cooldown and it launders them into unmarked goods that walk out of the front door, which
 * is exactly the free materials printer the module header warns about.
 *
 * Approval only gates getting one. Once it is in a save it reloads every round and prints forever, so
 * an admin signing one off is signing off on that permanently. TODO.
 */
/datum/home_supply/restricted/autolathe
	name = "Autolathe"
	desc = "Requires approval. Prints items from sheets - and what it prints does NOT belong to the \
		residence, so it can be carried out."
	manifest = list(/obj/machinery/autolathe = 1)
