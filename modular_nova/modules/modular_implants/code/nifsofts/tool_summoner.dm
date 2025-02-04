/obj/item/disk/nifsoft_uploader/summoner/tools
	name = "Grimoire Opera"
	loaded_nifsoft = /datum/nifsoft/summoner/tools

/datum/nifsoft/summoner/tools
	name = "Grimoire Opera"
	program_desc = "Grimoire Opera is a fork of the Grimoire Caeruleam NIFSoft engineered by and for contracted technicians operating for the Altspace Coven. \
	Its entirely functional aspect and high requirement for fidelity makes it more expensive and taxing than many other Grimoires."
	summonable_items = list(
		/obj/item/screwdriver/omni_drill/nanite,
		/obj/item/weldingtool/mini/nanite,
		/obj/item/multitool/nanite,
		/obj/item/wirebrush/nanite,
		/obj/item/door_seal/nanite,
	)
	max_summoned_items = 2
	activation_cost = 100
	purchase_price = 350
	name_tag = "covenant "
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_WRENCH
	able_to_keep = FALSE

/obj/item/screwdriver/omni_drill/nanite
	name = "omni manipulator lite"
	desc = "eventually"
	toolspeed = 1.5

/obj/item/weldingtool/mini/nanite
	name = "boson burner"
	desc = "eventually"
	toolspeed = 1.5

/obj/item/wirebrush/nanite
	name = "rust-gone"
	desc = "eventually"
	toolspeed = 1.5

/obj/item/multitool/nanite
	name = "vareditor"
	desc = "eventually"
	toolspeed = 1.5

/obj/item/door_seal/nanite
	name = "null entry"
	desc = "eventually"
	unseal_time = 1 SECONDS
