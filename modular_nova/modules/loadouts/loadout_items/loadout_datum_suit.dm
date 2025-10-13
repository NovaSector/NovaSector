// LOADOUT ITEM DATUMS FOR THE SHOE SLOT

/datum/loadout_category/suit
	category_name = "Suit"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/neck::tab_order + 1

/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE) // don't bother storing in backpack, can't fit
	if(initial(outfit_important_for_life.suit))
		return TRUE

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.suit)
			LAZYADD(outfit.backpack_contents, outfit.suit)
		outfit.suit = item_path
	else
		outfit.suit = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/suit/dagger_mantle
	name = "'Dagger' Designer Mantle"
	item_path = /obj/item/clothing/suit/dagger_mantle

/datum/loadout_item/suit/croptop
	name = "Crop Top Turtleneck"
	item_path = /obj/item/clothing/suit/jacket/croptop

/datum/loadout_item/suit/czech
	name = "Czech Coat"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/datum/loadout_item/suit/korea
	name = "Eastern Coat"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/hawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/costume/hawaiian

/datum/loadout_item/suit/overcoat
	name = "Overcoat (Colorable)"
	item_path = /obj/item/clothing/suit/nova/overcoat

/datum/loadout_item/suit/wellwornshirt
	name = "Oversized Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt

/datum/loadout_item/suit/wellworn_graphicshirt
	name = "Oversized Shirt (Graphic)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic

/datum/loadout_item/suit/ianshirt
	name = "Oversized Shirt (Ian)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian

/datum/loadout_item/suit/wornoutshirt
	name = "Oversized Shirt - Worn-out"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout

/datum/loadout_item/suit/wornout_graphicshirt
	name = "Oversized Shirt - Worn-out (Graphic)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic

/datum/loadout_item/suit/wornout_ianshirt
	name = "Oversized Shirt - Worn-out (Ian)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian

/datum/loadout_item/suit/messyshirt
	name = "Oversized Shirt - Messy"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy

/datum/loadout_item/suit/messy_graphicshirt
	name = "Oversized Shirt - Messy (Graphic)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic

/datum/loadout_item/suit/messy_ianshirt
	name = "Oversized Shirt - Messy (Ian)"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian

/datum/loadout_item/suit/wornshirt
	name = "Oversized Shirt - Wrinkled"
	item_path = /obj/item/clothing/suit/wornshirt

/datum/loadout_item/suit/suspenders
	name = "Suspenders (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/datum/loadout_item/suit/big_sweater
	name = "Big Sweater (Colorable)"
	item_path = /obj/item/clothing/suit/nova/sweater

/*
*	WINTER COATS
*/

/datum/loadout_item/suit/winter_coat
	name = "Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/gags_wintercoat
	name = "Winter Coat (Colorable)"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/colourable

/datum/loadout_item/suit/aformal
	name = "Winter Coat - Assistant's Formal"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova

/datum/loadout_item/suit/brass
	name = "Winter Coat - Brass"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/ratvar

/datum/loadout_item/suit/winter_coat/christmas
	name = "Winter Coat - Christmas"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/christmas

/datum/loadout_item/suit/winter_coat/christmas/green
	name = "Winter Coat - Christmas (Green)"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/christmas/green

/datum/loadout_item/suit/runed
	name = "Winter Coat - Runed"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/narsie

/datum/loadout_item/suit/winter_coat_greyscale
	name = "Winter Coat - Tailored (Colorable)"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/winter_coat_fancy
	name = "Winter Coat - Trenchcoat (Colorable)"
	item_path = /obj/item/clothing/suit/nova/furred_trenchcoat

//Job Winter Coats (Don't want to alphabetize these mixed with the other wintercoats)
/datum/loadout_item/suit/coat_atmos
	name = "Winter Coat - Atmospherics"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos

/datum/loadout_item/suit/coat_bar
	name = "Winter Coat - Bartender"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/bartender

/datum/loadout_item/suit/coat_cargo
	name = "Winter Coat - Cargo"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo

/datum/loadout_item/suit/coat_eng
	name = "Winter Coat - Engineering"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering

/datum/loadout_item/suit/coat_hydro
	name = "Winter Coat - Hydroponics"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro

/datum/loadout_item/suit/coat_med
	name = "Winter Coat - Medical"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical

/datum/loadout_item/suit/coat_miner
	name = "Winter Coat - Mining"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner

/datum/loadout_item/suit/coat_paramedic
	name = "Winter Coat - Paramedic"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic

/datum/loadout_item/suit/coat_robotics
	name = "Winter Coat - Robotics"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/robotics

/datum/loadout_item/suit/coat_sci
	name = "Winter Coat - Science"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science

/*
*	SUITS / SUIT JACKETS
*/

/datum/loadout_item/suit/recolorable
	name = "Suit Jacket  (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/lawyer/greyscale

/datum/loadout_item/suit/black_suit_jacket
	name = "Suit Jacket (Black)"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "Suit Jacket (Blue)"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "Suit Jacket (Purple)"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/suitwhite
	name = "Suit Jacket - Texan"
	item_path = /obj/item/clothing/suit/texas

/datum/loadout_item/suit/dutchjacket
	name = "Suit Jacket - Western"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/*
*	JACKETS
*/

/datum/loadout_item/suit/big_jacket
	name = "Alpha Atelier Pilot Jacket"
	item_path = /obj/item/clothing/suit/big_jacket

/datum/loadout_item/suit/blazer_jacket
	name = "Blazer (Colorable)"
	item_path = /obj/item/clothing/suit/jacket/blazer

/datum/loadout_item/suit/discojacket
	name = "Blazer - Disco"
	item_path = /obj/item/clothing/suit/jacket/discoblazer

/datum/loadout_item/suit/bomber_jacket
	name = "Bomber Jacket"
	item_path = /obj/item/clothing/suit/jacket/bomber

/datum/loadout_item/suit/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova

/datum/loadout_item/suit/kimjacket
	name = "Bomber Jacket, Aerostatic"
	item_path = /obj/item/clothing/suit/kimjacket

/datum/loadout_item/suit/cardigan
	name = "Cardigan"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/cardigan

/datum/loadout_item/suit/sports_jacket
	name = "Customizable Jacket (Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket/long

/datum/loadout_item/suit/shortsleeve_sports_jacket
	name = "Customizable Jacket (Short-Sleeved, Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve/long

/datum/loadout_item/suit/sleeveless_sports_jacket
	name = "Customizable Jacket (Sleeveless, Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless/long

/datum/loadout_item/suit/crop_jacket
	name = "Customizable Jacket - Crop Top (Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket

/datum/loadout_item/suit/shortsleeve_crop_jacket
	name = "Customizable Jacket - Crop-Top (Short-Sleeved, Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve

/datum/loadout_item/suit/sleeveless_crop_jacket
	name = "Customizable Jacket - Crop-Top (Sleeveless, Colorable)"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless

/datum/loadout_item/suit/colourable_leather_jacket
	name = "Leather Jacket (Colorable)"
	item_path = /obj/item/clothing/suit/jacket/leather/colourable

/datum/loadout_item/suit/duster
	name = "Duster (Colorable)"
	item_path = /obj/item/clothing/suit/duster

/datum/loadout_item/suit/parka
	name = "Falls Parka"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/jacket_fancy
	name = "Fancy Fur Coat  (Colorable)"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/flannel_gags
	name = "Flannel  (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/flannel/gags

/datum/loadout_item/suit/flannel_aqua
	name = "Flannel (Aqua)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/flannel/aqua

/datum/loadout_item/suit/flannel_black
	name = "Flannel (Black)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/flannel

/datum/loadout_item/suit/flannel_brown
	name = "Flannel (Brown)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/flannel/brown

/datum/loadout_item/suit/flannel_red
	name = "Flannel (Red)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/flannel/red

/datum/loadout_item/suit/frontierjacket
	abstract_type = /datum/loadout_item/suit/frontierjacket

/datum/loadout_item/suit/frontierjacket/short
	name = "Frontier Jacket (Short)"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/short

/datum/loadout_item/suit/maxson
	name = "Furred Coat (Brown)"
	item_path = /obj/item/clothing/suit/brownbattlecoat

/datum/loadout_item/suit/bossu
	name = "Furred Coat (Black)"
	item_path = /obj/item/clothing/suit/blackfurrich

/datum/loadout_item/suit/leather_jacket
	name = "Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/leather_jacket/hooded
	name = "Leather Jacket with Hoodie"
	item_path = /obj/item/clothing/suit/hooded/leather

/datum/loadout_item/suit/leather_jacket/biker
	name = "Leather Jacket with Zipper"
	item_path = /obj/item/clothing/suit/jacket/leather/biker

/datum/loadout_item/suit/woolcoat
	name = "Leather Overcoat"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/military_jacket
	name = "Military Jacket"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket_oversized
	name = "Oversized Jacket (Colorable)"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/peacoat
	name = "Peacoat (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/peacoat

/datum/loadout_item/suit/puffer_jacket
	name = "Puffer Jacket"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/puffer_vest
	name = "Puffer Vest"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/jacket_sweater
	name = "Sweater Jacket (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/jacket/sweater

/datum/loadout_item/suit/tailored_jacket
	name = "Tailored Jacket (Colorable)"
	item_path = /obj/item/clothing/suit/tailored_jacket

/datum/loadout_item/suit/tailored_short_jacket
	name = "Tailored Jacket, Short (Colorable)"
	item_path = /obj/item/clothing/suit/tailored_jacket/short

/datum/loadout_item/suit/trackjacket
	name = "Track Jacket"
	item_path = /obj/item/clothing/suit/toggle/trackjacket

/datum/loadout_item/suit/jacket_trenchcoat
	name = "Trenchcoat  (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/jacket/trenchcoat

/datum/loadout_item/suit/bltrench
	name = "Trenchcoat (Black)"
	item_path = /obj/item/clothing/suit/trenchblack

/datum/loadout_item/suit/frenchtrench
	name = "Trenchcoat (Blue)"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/brtrench
	name = "Trenchcoat (Brown)"
	item_path = /obj/item/clothing/suit/trenchbrown

/datum/loadout_item/suit/frontiertrench
	name = "Trenchcoat - Frontier"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist

/datum/loadout_item/suit/cossak
	name = "Ukrainian Coat"
	item_path = /obj/item/clothing/suit/cossack

/datum/loadout_item/suit/urban
	name = "Urban Coat"
	item_path = /obj/item/clothing/suit/urban

/datum/loadout_item/suit/warm_coat
	name = "Warm Coat (Colorable)"
	item_path = /obj/item/clothing/suit/warm_coat

/datum/loadout_item/suit/warm_sweater
	name = "Warm Sweater (Colorable)"
	item_path = /obj/item/clothing/suit/warm_sweater

/datum/loadout_item/suit/heart_sweater
	name = "Warm Sweater (Colorable, Heart)"
	item_path = /obj/item/clothing/suit/heart_sweater

/datum/loadout_item/suit/varsity
	name = "Varsity Jacket"
	item_path = /obj/item/clothing/suit/varsity

/datum/loadout_item/suit/offdep_jacket
	name = "Work Jacket - Off-Department"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber

/datum/loadout_item/suit/engi_jacket
	name = "Work Jacket - Engineering"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/engi

/datum/loadout_item/suit/sci_jacket
	name = "Work Jacket - Science"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sci

/datum/loadout_item/suit/med_jacket
	name = "Work Jacket - Medbay"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/med

/datum/loadout_item/suit/supply_jacket
	name = "Work Jacket - Supply"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/supply

/*
*	HOODIES
*/

/datum/loadout_item/suit/hoodie
	abstract_type = /datum/loadout_item/suit/hoodie

/datum/loadout_item/suit/hoodie/greyscale
	name = "Hoodie  (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie

/datum/loadout_item/suit/hoodie/greyscale_trim_alt
	name = "Hoodie  (Colorable, Pocket Trim)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim/alt

/datum/loadout_item/suit/hoodie/greyscale_trim
	name = "Hoodie  (Colorable, Zipper Trim)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/trim

/datum/loadout_item/suit/hoodie/black
	name = "Hoodie (Black)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "Hoodie (Red)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "Hoodie (Blue)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "Hoodie (Green)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "Hoodie (Orange)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "Hoodie (Yellow)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/yellow

/datum/loadout_item/suit/hoodie/grey
	name = "Hoodie (Grey)"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/grey

/datum/loadout_item/suit/hoodie/nt
	name = "Hoodie - NT"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded

/datum/loadout_item/suit/hoodie/smw
	name = "Hoodie - SMW"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "Hoodie - NRTI"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/nrti

/datum/loadout_item/suit/hoodie/cti
	name = "Hoodie - CTI"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/cti

/datum/loadout_item/suit/hoodie/mu
	name = "Hoodie - MU"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/hoodie/branded/mu

/*
*	WORKWEAR
*/

/datum/loadout_item/suit/recolorable_apron
	name = "Apron"
	item_path = /obj/item/clothing/suit/apron/chef/colorable_apron
	group = "Workwear"

/datum/loadout_item/suit/frontierjacket/short/medical
	name = "Frontier Jacket - Medical (Short)"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical
	group = "Workwear"

/datum/loadout_item/suit/cargo_gorka_jacket
	name = "Gorka Jacket - Cargo"
	item_path = /obj/item/clothing/suit/toggle/cargo_tech
	group = "Workwear"

/datum/loadout_item/suit/labcoat_highvis
	name = "High-Vis Jacket"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/highvis
	group = "Workwear"

/datum/loadout_item/suit/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat
	group = "Workwear"

/datum/loadout_item/suit/labcoat_custom
	name = "Labcoat  (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/custom
	group = "Workwear"

/datum/loadout_item/suit/labcoat_green
	name = "Labcoat (Green)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad
	group = "Workwear"

/datum/loadout_item/suit/labcoat_medical
	name = "Labcoat -  Medical"
	item_path = /obj/item/clothing/suit/toggle/labcoat/medical
	group = "Workwear"

/datum/loadout_item/suit/labcoat_lalunevest
	name = "Labcoat - Designer"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/lalunevest
	group = "Workwear"

/datum/loadout_item/suit/fancy_labcoat
	name = "Labcoat - Fancy (Colorable)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy
	group = "Workwear"

/datum/loadout_item/suit/labcoat_regular
	name = "Labcoat - Fancy, Research"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/regular
	group = "Workwear"

/datum/loadout_item/suit/labcoat_pharmacist
	name = "Labcoat - Fancy, Pharmacy"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/pharmacist
	group = "Workwear"

/datum/loadout_item/suit/labcoat_geneticist
	name = "Labcoat - Fancy, Genetics"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/geneticist
	group = "Workwear"

/datum/loadout_item/suit/labcoat_roboticist
	name = "Labcoat - Fancy, Robotics"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/roboticist
	group = "Workwear"

/datum/loadout_item/suit/recolorable_overalls
	name = "Overalls"
	item_path = /obj/item/clothing/suit/apron/overalls
	group = "Workwear"

/datum/loadout_item/suit/overalls_loneskirt
	name = "Overalls Skirt"
	item_path = /obj/item/clothing/suit/apron/overalls_loneskirt
	group = "Workwear"

//Religious Clothing (Workwear for Chaplain. Better sorted here than in Costumes)
/datum/loadout_item/suit/chap_eastmonk
	name = "Religious - Eastern Monk's Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/monkrobeeast
	group = "Workwear"

/datum/loadout_item/suit/chap_holiday
	name = "Religious - Holiday Priest Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/holidaypriest
	group = "Workwear"

/datum/loadout_item/suit/chap_brownmonk
	name = "Religious - Monk's Habit"
	item_path = /obj/item/clothing/suit/hooded/chaplainsuit/monkhabit
	group = "Workwear"

/datum/loadout_item/suit/chap_nun
	name = "Religious - Nun's Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/nun
	group = "Workwear"

/datum/loadout_item/suit/chap_shrinehand
	name = "Religious - Shrinehand's Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/shrinehand
	group = "Workwear"

/datum/loadout_item/suit/chap_blackmonk
	name = "Religious - Tunic"
	item_path = /obj/item/clothing/suit/chaplainsuit/habit
	group = "Workwear"

/*
*	COSTUMES
*/

/datum/loadout_item/suit/syndi
	name = "Black And Red Space Suit Replica"
	item_path = /obj/item/clothing/suit/syndicatefake
	group = "Costumes"

/datum/loadout_item/suit/blastwave_suit
	name = "Blastwave Trenchcoat"
	item_path = /obj/item/clothing/suit/blastwave
	group = "Costumes"

/datum/loadout_item/suit/caretaker
	name = "Caretaker Jacket"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler
	group = "Costumes"

/datum/loadout_item/suit/deckers
	name = "Deckers Hoodie"
	item_path = /obj/item/clothing/suit/costume/deckers
	group = "Costumes"

/datum/loadout_item/suit/flakjack
	name = "Flak Jacket"
	item_path = /obj/item/clothing/suit/flakjack
	group = "Costumes"

/datum/loadout_item/suit/plague_doctor
	name = "Plague Doctor Robes"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit
	group = "Costumes"

/datum/loadout_item/suit/pg
	name = "PG Coat"
	item_path = /obj/item/clothing/suit/costume/pg
	group = "Costumes"

/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho
	group = "Costumes"

/datum/loadout_item/suit/poncho_green
	name = "Poncho (Green)"
	item_path = /obj/item/clothing/suit/costume/poncho/green
	group = "Costumes"

/datum/loadout_item/suit/poncho_red
	name = "Poncho (Red)"
	item_path = /obj/item/clothing/suit/costume/poncho/red
	group = "Costumes"

/datum/loadout_item/suit/redhood
	name = "Red Cloak"
	item_path = /obj/item/clothing/suit/hooded/cloak/david
	group = "Costumes"

/datum/loadout_item/suit/soviet
	name = "Soviet Coat"
	item_path = /obj/item/clothing/suit/costume/soviet
	group = "Costumes"

/datum/loadout_item/suit/bee
	name = "Suit - Bee"
	item_path = /obj/item/clothing/suit/hooded/bee_costume
	group = "Costumes"

/datum/loadout_item/suit/cardborg
	name = "Suit - Cardborg"
	item_path = /obj/item/clothing/suit/costume/cardborg
	group = "Costumes"

/datum/loadout_item/suit/carp_costume
	name = "Suit - Carp"
	item_path = /obj/item/clothing/suit/hooded/carp_costume
	group = "Costumes"

/datum/loadout_item/suit/chicken
	name = "Suit - Chicken"
	item_path = /obj/item/clothing/suit/costume/chickensuit
	group = "Costumes"

/datum/loadout_item/suit/ian_costume
	name = "Suit - Corgi"
	item_path = /obj/item/clothing/suit/hooded/ian_costume
	group = "Costumes"

/datum/loadout_item/suit/griffin
	name = "Suit - Griffon"
	item_path = /obj/item/clothing/suit/toggle/owlwings/griffinwings
	group = "Costumes"

/datum/loadout_item/suit/monkey
	name = "Suit - Monkey"
	item_path = /obj/item/clothing/suit/costume/monkeysuit
	group = "Costumes"

/datum/loadout_item/suit/owl
	name = "Suit - Owl"
	item_path = /obj/item/clothing/suit/toggle/owlwings
	group = "Costumes"

/datum/loadout_item/suit/shark_costume
	name = "Suit - Shark"
	item_path = /obj/item/clothing/suit/hooded/shark_costume
	group = "Costumes"

/datum/loadout_item/suit/shork_costume
	name = "Suit - Shork"
	item_path = /obj/item/clothing/suit/hooded/shork_costume
	group = "Costumes"

/datum/loadout_item/suit/snowman
	name = "Suit - Snowman"
	item_path = /obj/item/clothing/suit/costume/snowman
	group = "Costumes"

/datum/loadout_item/suit/xenos
	name = "Suit - Xenos"
	item_path = /obj/item/clothing/suit/costume/xenos
	group = "Costumes"

/datum/loadout_item/suit/tmc
	name = "TMC Coat"
	item_path = /obj/item/clothing/suit/costume/tmc
	group = "Costumes"

/datum/loadout_item/suit/white_dress
	name = "White Dress"
	item_path = /obj/item/clothing/suit/costume/whitedress
	group = "Costumes"


/datum/loadout_item/suit/jacket/long_robe
	name = "Long Robe"
	item_path = /obj/item/clothing/suit/jacket/long_robe
	can_be_reskinned = TRUE
	group = "Costumes"

/datum/loadout_item/suit/jacket/haori
	name = "Haori"
	item_path = /obj/item/clothing/suit/jacket/haori
	can_be_reskinned = TRUE
	group = "Costumes"

/datum/loadout_item/suit/witch
	name = "Witch Robe"
	item_path = /obj/item/clothing/suit/wizrobe/marisa/fake
	group = "Costumes"

/datum/loadout_item/suit/wizard
	name = "Wizard Robe"
	item_path = /obj/item/clothing/suit/wizrobe/fake
	group = "Costumes"

/datum/loadout_item/suit/yuri
	name = "Yuri Coat"
	item_path = /obj/item/clothing/suit/costume/yuri
	group = "Costumes"

/*
*	SPECIES-UNIQUE
*/

/datum/loadout_item/suit/mothcoat
	name = "Mothic Flightsuit"
	item_path = /obj/item/clothing/suit/mothcoat
	group = "Species-Unique"

/datum/loadout_item/suit/mantella
	name = "Mothic Mantella"
	item_path = /obj/item/clothing/suit/mothcoat/winter
	group = "Species-Unique"

/datum/loadout_item/suit/ethereal_raincoat
	name = "Ethereal Raincoat"
	item_path = /obj/item/clothing/suit/hooded/ethereal_raincoat
	group = "Species-Unique"

/*
*	JOB-LOCKED
*/

//CARGO
/datum/loadout_item/suit/qm_jacket
	name = "Quartermaster's Overcoat"
	item_path = /obj/item/clothing/suit/jacket/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)
	group = "Job-Locked"

//SEC
/datum/loadout_item/suit/navybluejackethos
	name = "Head of Security's Formal Jacket (Navy Blue)"
	item_path = /obj/item/clothing/suit/jacket/hos/blue
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/suit/navybluejacketwarden
	name = "Warden's Formal Jacket (Navy Blue)"
	item_path = /obj/item/clothing/suit/jacket/warden/blue
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/suit/british_jacket
	name = "Security British Coat"
	item_path = /obj/item/clothing/suit/british_officer
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/navybluejacketofficer
	name = "Security Formal Jacket (Navy Blue)"
	item_path = /obj/item/clothing/suit/jacket/officer/blue
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/brit
	name = "Security High Vis Armored Vest"
	item_path = /obj/item/clothing/suit/armor/vest/brit
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/highvis_jacket
	name = "Security High-Vis Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/jacket
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/highvis_jacket/badge
	name = "Security High-Vis Jacket - Badged"
	item_path = /obj/item/clothing/suit/armor/vest/jacket/badge
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/security_wintercoat
	name = "Security Winter Jacket"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/security_wintercoat_blue
	name = "Security Winter Coat (Blue)"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/blue
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

/datum/loadout_item/suit/security_jacket
	name = "Security Work Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/nova/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY) //Not giving this one to COs because it's actually better than the one they spawn with
	group = "Job-Locked"

//Detective
/datum/loadout_item/suit/deckard
	name = "Detective Runner Coat"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/suit/detectivearmorvest
	name = "Detective's Armor Vest"
	item_path = /obj/item/clothing/suit/armor/vest/det_suit
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/suit/detjacketbrown
	name = "Detective's Jacket"
	item_path = /obj/item/clothing/suit/jacket/det_suit
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/suit/detjackenoir
	name = "Detective's Jacket (Noir)"
	item_path = /obj/item/clothing/suit/jacket/det_suit/noir
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/suit/detjacketplain
	name = "Detective's Trenchcoat"
	item_path = /obj/item/clothing/suit/toggle/jacket/det_trench
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/suit/detjacket
	name = "Detective's Trenchcoat (Dark)"
	item_path = /obj/item/clothing/suit/toggle/jacket/det_trench/noir
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/*
*	DONATOR
*/

/datum/loadout_item/suit/donator
	abstract_type = /datum/loadout_item/suit/donator
	donator_only = TRUE

/datum/loadout_item/suit/donator/blondie
	name = "Cowboy Vest"
	item_path = /obj/item/clothing/suit/cowboyvest

/datum/loadout_item/suit/digicoat_glitched //Public donator reward for Razurath.
	name = "Digicoat - Glitched"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched

/datum/loadout_item/suit/donator/digicoat
	abstract_type = /datum/loadout_item/suit/donator/digicoat

/datum/loadout_item/suit/donator/digicoat/interdyne
	name = "Digicoat - Interdyne"
	item_path = /obj/item/clothing/suit/toggle/digicoat/interdyne

/datum/loadout_item/suit/donator/digicoat/nanotrasen
	name = "Digicoat - Nanotrasen"
	item_path = /obj/item/clothing/suit/toggle/digicoat/nanotrasen

/datum/loadout_item/suit/donator/furredjacket
	name = "Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/public

/datum/loadout_item/suit/donator/whitefurredjacket
	name = "Furred Jacket (White)"
	item_path = /obj/item/clothing/suit/brownfurrich/white

/datum/loadout_item/suit/donator/creamfurredjacket
	name = "Furred Jacket (Cream)"
	item_path = /obj/item/clothing/suit/brownfurrich/cream

/datum/loadout_item/suit/donator/chokha //All-donators donator item for BlindPoet
	name = "Iseurian Chokha"
	item_path = /obj/item/clothing/suit/chokha

/datum/loadout_item/suit/donator/modern_winter
	name = "Modern Winter Coat"
	item_path = /obj/item/clothing/suit/modern_winter

/datum/loadout_item/suit/donator/replica_parade_jacket
	name = "Replica Parade Jacket"
	item_path = /obj/item/clothing/suit/replica_parade_jacket
