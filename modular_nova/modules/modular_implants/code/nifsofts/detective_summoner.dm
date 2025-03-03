/obj/item/disk/nifsoft_uploader/summoner/detective
	name = "Grimoire Vacholiere"
	loaded_nifsoft = /datum/nifsoft/summoner/job/detective

/obj/item/disk/nifsoft_uploader/summoner/detective/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/datum/nifsoft/summoner/job/detective
	name = "Grimoire Vacholiere"
	program_desc = "Grimoire Vacholiere is a fork of the Grimoire Caeruleam NIFSoft commissioned by numerous Zvirdnyan Colonial Militia officers. \
	Despite it creating nothing more but largely bureaucratical tidbits, the high use cost is generated from running the forensic equipment in the background. <br>\
	Some inspectors could swear that uncertainly beneficial voices of suggestion and warning appear in their minds, after running Vacholieres for prolonged periods \
	of time - technically described as backlogs of data interfering with Soulcatchers."
	summonable_items = list(
		/obj/item/detective_scanner/nanite,
		/obj/item/folder/yellow/nanite,
		/obj/item/binoculars/nanite,
		/obj/item/toy/crayon/white/nanite,
	)
	max_summoned_items = 2
	activation_cost = 200
	name_tag = "vacholiere-"
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_MAGNIFYING_GLASS
	able_to_keep = FALSE

/obj/item/detective_scanner/nanite
	name = "regular forensic tool"
	desc = "The truth ain't what happened, but what you can prove. Means, motive, culpability, these are the realm of the past. \
	Or fiction, to those who can spin it. What the Zvirdnyan Empire learned early on is, you can only work with what's here and now. \
	Build a tower out of residues to hang the perp from. The things that get left behind: DNA, shreds of fabric, chemical stains, access codes; \
	all concrete facts, the whetstone to keep your wit sharp to cut through the woven web of lies. \
	This scanner might just be a projection of nanites from inside your head, but the brightest thoughts come from within, illuminating the truth to cast out the last shadows of doubt. \
	If you're gonna take down a kingpin, you start with the prints."
	range = 4

/obj/item/folder/yellow/nanite
	name = "folder of oblivion"
	desc = "There's two parts to every case: solving it, and proving it. You're a hardened gumshoe, the solving's the easy part. \
	Ain't no scrap of a chance you've enough sleuth diplomacy to con a judge into a conviction with that alone. \
	You need your ducks in a row, your red strings taut between every shred of proof, and most importantly, you need a safehouse to stash your findings. \
	This is it, your vacholieran vault. Tucks your papers, your photos, your provenance in one perfect package, slim enough to slip through a mail slot in the dead of night."

/obj/item/binoculars/nanite
	name = "searchlight divisioner"
	desc = "Quantum mechanics has a funny notion of observation: if you're caught observing something, you change it. \
	A perp sees you see them, they cover their tracks, make a clean getaway with you holding the bag. \
	You're a hardened gumshoe, already living on the edge of society, the stalwart guard between the fragile innocence of the high life and the sick rot in every floor tile, \
	in every street. What's a little more distance to someone like you? The only mystery you won't be able to solve is how nanites form a clear surface to gaze through."

/obj/item/toy/crayon/white/nanite
	name = "actual asphalt grafitter"
	desc = "Everyone dreams of making a mark in the world, something that lasts longer than they do. \
	You're a dream maker, but it sure feels like a nightmare. A little memorial, the outline of their body, not for their body or who they were, \
	but a solemn reminder of their last seconds, how it all fell apart. Let the flappers mourn the stiff, you're here for the case. \
	If you can mark out where things fell, you can work back to how, deduce the why, detain the who. Everyone's last thoughts as they're slammed into the long sleep ain't about peace, \
	but getting even, and you're the dream maker."
	charges = -1
	edible = FALSE
