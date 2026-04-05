/// IRIS STATION EDIT: Summon Ash Crusher
/datum/ash_ritual/summon_cursed_carver
	name = "Summon Cursed Ash Carver"
	desc = "Summons a weapon that mimics the invader's tools, allowing us to collect trophies from the hunt."
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/cursed_dagger,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/cursed_dagger,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/kinetic_crusher/cursed,
	)
