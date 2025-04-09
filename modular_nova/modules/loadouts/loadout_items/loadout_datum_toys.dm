/datum/loadout_category/toys
	category_name = "Toys"
	category_ui_icon = FA_ICON_TROPHY
	type_to_generate = /datum/loadout_item/toys
	tab_order = /datum/loadout_category/inhands::tab_order + 1
	/// How many toys are allowed at maximum.
	VAR_PRIVATE/max_allowed = 3


/datum/loadout_category/toys/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/toys/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/toys/other_toys = list()
	for(var/datum/loadout_item/toys/other_toy in all_loadout_items)
		other_toys += other_toy

	if(length(other_toys) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_toys[1])
	return TRUE



/datum/loadout_item/toys
	abstract_type = /datum/loadout_item/toys

/*
*	PLUSHIES
*/

/datum/loadout_item/toys/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)  // these go in the backpack
	return FALSE

/datum/loadout_item/toys/bee
	name = "Bee Plushie"
	item_path = /obj/item/toy/plush/beeplushie

/datum/loadout_item/toys/carp
	name = "Carp Plushie"
	item_path = /obj/item/toy/plush/carpplushie

/datum/loadout_item/toys/shark
	name = "Shark Plushie"
	item_path = /obj/item/toy/plush/shark

/datum/loadout_item/toys/lizard_greyscale
	name = "Greyscale Lizard Plushie"
	item_path = /obj/item/toy/plush/lizard_plushie
	can_be_greyscale = TRUE

/datum/loadout_item/toys/moth
	name = "Moth Plushie"
	item_path = /obj/item/toy/plush/moth

/datum/loadout_item/toys/narsie
	name = "Nar'sie Plushie"
	item_path = /obj/item/toy/plush/narplush

/datum/loadout_item/toys/nukie
	name = "Nukie Plushie"
	item_path = /obj/item/toy/plush/nukeplushie

/datum/loadout_item/toys/peacekeeper
	name = "Peacekeeper Plushie"
	item_path = /obj/item/toy/plush/pkplush

/datum/loadout_item/toys/plasmaman
	name = "Plasmaman Plushie"
	item_path = /obj/item/toy/plush/plasmamanplushie

/datum/loadout_item/toys/ratvar
	name = "Ratvar Plushie"
	item_path = /obj/item/toy/plush/ratplush

/datum/loadout_item/toys/rouny
	name = "Rouny Plushie"
	item_path = /obj/item/toy/plush/rouny

/datum/loadout_item/toys/snake
	name = "Snake Plushie"
	item_path = /obj/item/toy/plush/snakeplushie

/datum/loadout_item/toys/slime
	name = "Slime Plushie"
	item_path = /obj/item/toy/plush/slimeplushie

/datum/loadout_item/toys/bubble
	name = "Bubblegum Plushie"
	item_path = /obj/item/toy/plush/bubbleplush

/datum/loadout_item/toys/goat
	name = "Strange Goat Plushie"
	item_path = /obj/item/toy/plush/goatplushie

/datum/loadout_item/toys/sechound
	name = "Sechound Plushie"
	item_path = /obj/item/toy/plush/nova/sechound

/datum/loadout_item/toys/medihound
	name = "Medihound Plushie"
	item_path = /obj/item/toy/plush/nova/medihound

/datum/loadout_item/toys/engihound
	name = "Engihound Plushie"
	item_path = /obj/item/toy/plush/nova/engihound

/datum/loadout_item/toys/scrubpuppy
	name = "Scrubpuppy Plushie"
	item_path = /obj/item/toy/plush/nova/scrubpuppy

/datum/loadout_item/toys/meddrake
	name = "MediDrake Plushie"
	item_path = /obj/item/toy/plush/nova/meddrake

/datum/loadout_item/toys/secdrake
	name = "SecDrake Plushie"
	item_path = /obj/item/toy/plush/nova/secdrake

/datum/loadout_item/toys/borbplushie
	name = "Borb Plushie"
	item_path = /obj/item/toy/plush/nova/borbplushie

/datum/loadout_item/toys/deer
	name = "Deer Plushie"
	item_path = /obj/item/toy/plush/nova/deer

/datum/loadout_item/toys/fermis
	name = "Medcat Plushie"
	item_path = /obj/item/toy/plush/nova/donator/fermis

/datum/loadout_item/toys/chen
	name = "Securicat Plushie"
	item_path = /obj/item/toy/plush/nova/donator/fermis/chen

/datum/loadout_item/toys/fox
	name = "Fox Plushie"
	item_path = /obj/item/toy/plush/nova/fox

/datum/loadout_item/toys/duffmoff
	name = "Suspicious Moth Plushie"
	item_path = /obj/item/toy/plush/nova/donator/duffmoth

/datum/loadout_item/toys/musicalduffy
	name = "Suspicious Musical moth"
	item_path = /obj/item/instrument/musicalduffy

/datum/loadout_item/toys/leaplush
	name = "Suspicious Deer Plushie"
	item_path = /obj/item/toy/plush/nova/donator/leaplush

/datum/loadout_item/toys/sarmie
	name = "Cosplayer Plushie"
	item_path = /obj/item/toy/plush/nova/donator/sarmieplush

/datum/loadout_item/toys/sharknet
	name = "Gluttonous Shark Plushie"
	item_path = /obj/item/toy/plush/nova/donator/sharknet

/datum/loadout_item/toys/pintaplush
	name = "Smaller Deer Plushie"
	item_path = /obj/item/toy/plush/nova/donator/pintaplush

/datum/loadout_item/toys/szaplush
	name = "Suspicious Spider Plushie"
	item_path = /obj/item/toy/plush/nova/donator/szaplush

/datum/loadout_item/toys/riffplush
	name = "Valid Plushie"
	item_path = /obj/item/toy/plush/nova/donator/riffplush

/datum/loadout_item/toys/ianbastardman
	name = "Ian Plushie"
	item_path = /obj/item/toy/plush/nova/ian

/datum/loadout_item/toys/corgiman
	name = "Corgi Plushie"
	item_path = /obj/item/toy/plush/nova/ian/small

/datum/loadout_item/toys/corgiwoman
	name = "Girly Corgi Plushie"
	item_path = /obj/item/toy/plush/nova/ian/lisa

/datum/loadout_item/toys/cat
	name = "Cat Plushie"
	item_path = /obj/item/toy/plush/nova/cat

/datum/loadout_item/toys/tuxcat
	name = "Tux Cat Plushie"
	item_path = /obj/item/toy/plush/nova/cat/tux

/datum/loadout_item/toys/whitecat
	name = "White Cat Plushie"
	item_path = /obj/item/toy/plush/nova/cat/white

/datum/loadout_item/toys/human
	name = "Human Plushie"
	item_path = /obj/item/toy/plush/human

/datum/loadout_item/toys/seaduplush
	name = "Sneed Plushie"
	item_path = /obj/item/toy/plush/nova/donator/seaduplush

/datum/loadout_item/toys/lizzyplush
	name = "Odd Yoga lizzy Plushie"
	item_path = /obj/item/toy/plush/nova/donator/lizzyplush

/datum/loadout_item/toys/mechanic_fox
	name = "Mechanist Fox Plushie"
	item_path = /obj/item/toy/plush/nova/donator/mechanic_fox

/datum/loadout_item/toys/tribal_salamander
	name = "Tribal Salamander Plushie"
	item_path = /obj/item/toy/plush/nova/donator/tribal_salamander

/datum/loadout_item/toys/commanding_teshari
	name = "Commanding Teshari Plushy"
	item_path = /obj/item/toy/plush/nova/donator/commanding_teshari

/datum/loadout_item/toys/snow_owl
	name = "Snowy Owl Plush"
	item_path = /obj/item/toy/plush/nova/donator/snow_owl

/datum/loadout_item/toys/breakdancing_bird
	name = "Breakdancing Bird Plushie"
	item_path = /obj/item/toy/plush/nova/donator/breakdancing_bird

/datum/loadout_item/toys/skreking_vox
	name = "Skreking Vox Plushie"
	item_path = /obj/item/toy/plush/nova/donator/skreking_vox

/datum/loadout_item/toys/engi_snek
	name = "Engineering Snek Plushie"
	item_path = /obj/item/toy/plush/nova/donator/engi_snek

/datum/loadout_item/toys/glitch_synth
	name = "Glitching Synthetic Plushie"
	item_path = /obj/item/toy/plush/nova/donator/glitch_synth

/datum/loadout_item/toys/boom_bird
	name = "Boom Bird Plushie"
	item_path = /obj/item/toy/plush/nova/donator/boom_bird

/datum/loadout_item/toys/blue_cat
	name = "Blue Cat Plushie"
	item_path = /obj/item/toy/plush/nova/donator/blue_cat

/datum/loadout_item/toys/igneous_synth
	name = "Igneous Synth Plushie"
	item_path = /obj/item/toy/plush/nova/donator/igneous_synth

/datum/loadout_item/toys/edgy_bird
	name = "Edgy Bird Plushie"
	item_path = /obj/item/toy/plush/nova/donator/edgy_bird

/datum/loadout_item/toys/tree_ferret
	name = "Tree Ferret Plushie"
	item_path = /obj/item/toy/plush/nova/donator/tree_ferret

/datum/loadout_item/toys/xixi
	name = "Familiar Harpy Plushie"
	item_path = /obj/item/toy/plush/nova/donator/xixi

/datum/loadout_item/toys/rubi_plush
	name = "Huggable Bee Plushie"
	item_path = /obj/item/toy/plush/nova/donator/rubi

/datum/loadout_item/toys/derg_plushie
	name = "Wingless Dragon Plushie"
	item_path = /obj/item/toy/plush/nova/donator/derg_plushie

/datum/loadout_item/toys/tracy
	name = "Creature Plushie"
	item_path = /obj/item/toy/plush/nova/donator/tracy

/datum/loadout_item/toys/adventurous_synth
	name = "Adventurous Synth Plushie"
	item_path = /obj/item/toy/plush/nova/donator/plushie_synthia

/datum/loadout_item/toys/jecca
	name = "Sexy Snoodle Plushie"
	item_path = /obj/item/toy/plush/nova/donator/jecca

/datum/loadout_item/toys/courier_synth
	name = "Courier Synth Plushie"
	item_path = /obj/item/toy/plush/nova/donator/courier_synth

/datum/loadout_item/toys/plush_janiborg
	name = "Friendly Janiborg Plush"
	item_path = /obj/item/toy/plush/nova/donator/plush_janiborg

/*
*	CARDS
*/

/datum/loadout_item/toys/card_binder
	name = "Card Binder"
	item_path = /obj/item/storage/card_binder

/datum/loadout_item/toys/card_deck
	name = "Playing Card Deck"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/toys/kotahi_deck
	name = "Kotahi Deck"
	item_path = /obj/item/toy/cards/deck/kotahi

/datum/loadout_item/toys/wizoff_deck
	name = "Wizoff Deck"
	item_path = /obj/item/toy/cards/deck/wizoff

/datum/loadout_item/toys/tarot
	name = "Tarot Card Deck"
	item_path = /obj/item/toy/cards/deck/tarot

/*
*	DICE
*/

/datum/loadout_item/toys/d1
	name = "D1"
	item_path = /obj/item/dice/d1

/datum/loadout_item/toys/d2
	name = "D2"
	item_path = /obj/item/dice/d2

/datum/loadout_item/toys/d4
	name = "D4"
	item_path = /obj/item/dice/d4

/datum/loadout_item/toys/d6
	name = "D6"
	item_path = /obj/item/dice/d6

/datum/loadout_item/toys/d6_ebony
	name = "D6 (Ebony)"
	item_path = /obj/item/dice/d6/ebony

/datum/loadout_item/toys/d6_space
	name = "D6 (Space)"
	item_path = /obj/item/dice/d6/space

/datum/loadout_item/toys/d8
	name = "D8"
	item_path = /obj/item/dice/d8

/datum/loadout_item/toys/d10
	name = "D10"
	item_path = /obj/item/dice/d10

/datum/loadout_item/toys/d12
	name = "D12"
	item_path = /obj/item/dice/d12

/datum/loadout_item/toys/d20
	name = "D20"
	item_path = /obj/item/dice/d20

/datum/loadout_item/toys/d100
	name = "D100"
	item_path = /obj/item/dice/d100

/datum/loadout_item/toys/d00
	name = "D00"
	item_path = /obj/item/dice/d00

/datum/loadout_item/toys/dice
	name = "Dice Bag"
	item_path = /obj/item/storage/dice

/*
*	TENNIS BALLS
*/

/datum/loadout_item/toys/tennis
	name = "Tennis Ball (Classic)"
	item_path = /obj/item/toy/tennis

/datum/loadout_item/toys/tennisred
	name = "Tennis Ball (Red)"
	item_path = /obj/item/toy/tennis/red

/datum/loadout_item/toys/tennisyellow
	name = "Tennis Ball (Yellow)"
	item_path = /obj/item/toy/tennis/yellow

/datum/loadout_item/toys/tennisgreen
	name = "Tennis Ball (Green)"
	item_path = /obj/item/toy/tennis/green

/datum/loadout_item/toys/tenniscyan
	name = "Tennis Ball (Cyan)"
	item_path = /obj/item/toy/tennis/cyan

/datum/loadout_item/toys/tennisblue
	name = "Tennis Ball (Blue)"
	item_path = /obj/item/toy/tennis/blue

/datum/loadout_item/toys/tennispurple
	name = "Tennis Ball (Purple)"
	item_path = /obj/item/toy/tennis/purple

/*
*	MISC
*/

/datum/loadout_item/toys/cat_toy
	name = "Cat Toy"
	item_path = /obj/item/toy/cattoy

/datum/loadout_item/toys/crayons
	name = "Box of Crayons"
	item_path = /obj/item/storage/crayons

/datum/loadout_item/toys/spray_can
	name = "Spray Can"
	item_path = /obj/item/toy/crayon/spraycan

/datum/loadout_item/toys/eightball
	name = "Magic Eightball"
	item_path = /obj/item/toy/eightball

/datum/loadout_item/toys/toykatana
	name = "Toy Katana"
	item_path = /obj/item/toy/katana

/datum/loadout_item/toys/red_laser
	name = "Red Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/red

/datum/loadout_item/toys/green_laser
	name = "Green Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/green

/datum/loadout_item/toys/blue_laser
	name = "Blue Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/blue

/datum/loadout_item/toys/purple_laser
	name = "Purple Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/purple
