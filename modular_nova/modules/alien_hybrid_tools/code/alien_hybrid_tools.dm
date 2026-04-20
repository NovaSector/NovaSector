/obj/item/crowbar/power/alien
	name = "hybrid jaws of life"
	desc = "A set of jaws of life, compressed through the magic of science and augmented with alien technology. \
		Depending on the installed hardlight emitter, it can pry or cut by itself, without any effort required."
	usesound = 'sound/items/weapons/sonic_jackhammer.ogg'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.25, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3.75, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 3.75, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_SMALL

/obj/item/screwdriver/power/alien
	name = "hybrid hand drill"
	desc = "A powered hand drill, augmented with alien technology. \
		Depending on the installed hardlight emitter, it can drive screws or turn bolts with little to no effort."
	usesound = 'sound/items/pshoom/pshoom.ogg'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 3.25, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_SMALL

/obj/item/scalpel/advanced/alien
	name = "hybrid hardlight scalpel"
	desc = "An advanced scalpel which uses laser technology, augmented with alien technology, \
		to cut tissue or saw through denser material, like bone."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4.25, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 2)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/retractor/advanced/alien
	name = "hybrid mechanical pinches"
	desc = "An agglomerate of rods and gears, augmented with alien technology, \
		to clamp or retract tissue."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/cautery/advanced/alien
	name = "hybrid searing tool"
	desc = "An advanced compact laser projector, augmented with alien technology, \
		for medical applications such as cauterizing tissue or drilling bone."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4.75, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/blood_filter/advanced/alien
	name = "hybrid medical combitool"
	desc = "A confusing combination of a blood filter and bonesetter, augmented with alien technology, \
		for filtering blood and tending to bones, including treating fractures even without surgical intervention."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 9.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 3.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5)
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/blood_filter/advanced/alien/get_all_tool_behaviours()
	return list(TOOL_BLOODFILTER, TOOL_BONESET, TOOL_ALIEN_BONESET)

// upgrade fodder/material
/obj/item/alien_tool_upgrade
	name = "assimilative superalloy"
	desc = "An experimental nanite-integrated smart superalloy, designed for integrating abductor technology into existing experimental tools. \
		Whether this is a good or a bad thing depends entirely on what you use it for. \
		May qualify as intelligent life, depending on the working definition of intelligence. \
		Keep out of reach of assistants, clowns, and other troublemakers."
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	icon_state = "superalloy"
	lefthand_file = 'icons/mob/inhands/items/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/sheets_righthand.dmi'
	inhand_icon_state = "sheet-abductor"
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	sound_vary = TRUE

/obj/item/alien_tool_upgrade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore = "Scientists have often wondered why they shouldn't, in fact, just combine alien technology with their experimental dual-purpose tools. \
			After enough disagreement over how, exactly, they should have done this, someone suggested the idea of a pre-seeded positronic intelligence \
			built with one purpose - to, personally, optimize the integration of recovered alien tool technology into current experimental tools. \
			For what it's worth, they were actually fairly successful.<br>\
			<br>\
			The so-called \"assimilative superalloy\" is a recreation of that first successful experiment, utilizing a very trimmed down positronic \
			intelligence built into a high-performance nanocrystalline lattice with one set task - use the materials supplied to create a better tool. \
			For better or worse, the trimming of the intelligence and the limited amount of construction nanites at its disposal means that it has a very \
			strict definition of \"tool\" that it can use for performing upgrades. This does mitigate its ability to get out of control, though. Theoretically." \
	)

// research
/datum/design/alien_tool_upgrade
	name = "Assimilative Superalloy"
	desc = "An experimental nanite-integrated smart superalloy designed to perform dialectical synthesis \
		between the thesis of combined tools and the antithesis of standalone alien tools. \
		Or kitbashing, if you're not a nerd."
	id = "alien_tool_upgrade"
	build_path = /obj/item/alien_tool_upgrade
	build_type = PROTOLATHE | AWAY_LATHE
	// price could probably be tuned tbh
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
					/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2,
					/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
					/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
					/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
					/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
				)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/techweb_node/alientech/New()
	design_ids += list(
		"alien_tool_upgrade",
	)
	return ..()
