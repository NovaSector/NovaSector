/obj/item/disk/nifsoft_uploader/summoner/service
	name = "Grimoire Hestia"
	loaded_nifsoft = /datum/nifsoft/summoner/job/service

/datum/nifsoft/summoner/job/service
	name = "Grimoire Hestia"
	program_desc = "The Grimoire Hestia is an overlay of Zvirdnyan Manufacturing Repurposement Algorithms atop a Ceruleam base, \
	crafting standard Ceruleam devices and reconfiguring them mid-synthesis into simpler, repurposable shapes for basic food cultivation and preparation. \
	Hestia watches over both hearth and home, and with her in your head, yours shall be blessed too."
	summonable_items = list(
		/obj/item/storage/bag/tray/nanite,
		/obj/item/reagent_containers/cup/glass/shaker/nanite,
		/obj/item/reagent_containers/cup/rag/nanite,
		/obj/item/knife/kitchen/nanite,
		/obj/item/kitchen/rollingpin/nanite,
		/obj/item/cultivator/nanite,
		/obj/item/geneshears/nanite,
		/obj/item/secateurs/nanite,
		/obj/item/shovel/spade/nanite,
		/obj/item/hatchet/nanite,
		/obj/item/mop/nanite,
	)
	max_summoned_items = 3
	activation_cost = 100
	name_tag = "hestial "
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_KITCHEN_SET
	able_to_keep = FALSE

/obj/item/storage/bag/tray/nanite
	desc = "A serving tray to lay food on. Formerly a WizOff deck of cards, as the colorful spell arts can still be seen as faint impressions in the Hestian polymer."
	force = 0
	throwforce = 0

/obj/item/reagent_containers/cup/glass/shaker/nanite
	desc = "A polymer shaker to mix drinks in. The hilt of a conjured katana, stretched and widened and encrusted with the remaining Hestian bladesteel."

/obj/item/reagent_containers/cup/rag/nanite
	desc = "For cleaning up messes you did not make. A large-scale simulated filter from a Hestian holocigarette, \
	it cleans the station as nicely as it cleans your lungs from the simulated Vulgaris."

/obj/item/knife/kitchen/nanite
	desc = "A very safe, general purpose Chef's Knife reverse engineered by the Altspace Coven. \
	Like the Malatestan katana it is salvaged from, this knife cuts via hyperbole, and is thus harmless to most living tissue."
	force = 0
	throwforce = 0
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/kitchen/rollingpin/nanite
	desc = "Used to chastise the bartender. The handles are glorious Caeruleam folded over 1000 times, and the body exudes a cane-do attitude from the mass of two Hestian folding canes."
	force = 0
	throwforce = 0
	resistance_flags = null

/obj/item/cultivator/nanite
	desc = "It's used for removing weeds or scratching tallies into concrete. \
	The length of a walking cane, whittled down to dulled Hestian points by years of simulated hiking, split three-fold for gardening use."
	force = 0
	throwforce = 0

/obj/item/geneshears/nanite
	desc = "A high tech, high fidelity pair of plant shears, utilizing the Hestian errata of a Kotahi deck to move genetic traits of a plant into a restricted or limited banlist."
	force = 0
	throwforce = 0

/obj/item/secateurs/nanite
	desc = "A tool for cutting grafts off plants, or changing podperson looks. \
	In the old world, dice games routinely pruned family trees, and this tradition is upheld through overclocking the Hestian resin engraving process, \
	etching snipping blades instead of numbers."
	force = 0
	throwforce = 0

/obj/item/shovel/spade/nanite
	desc = "A small tool for digging and moving dirt, the fused polymers of a Hestian tarot deck cast into a trowl. A tarowl, if you will."
	force = 0
	throwforce = 0

/obj/item/hatchet/nanite
	desc = "A very dull axe blade upon a short foam handle. Hestian algorithms bring forth the dream of a toy foamblade, \
	allowing it to split inert tissue and lumber without posing a threat to the living."
	force = 0
	throwforce = 0

/obj/item/mop/nanite
	desc = "A custodial staple, using the capillary actions of numerous Hestian holocigarettes to absorb liquids and clean messes."
	force = 0
	throwforce = 0
