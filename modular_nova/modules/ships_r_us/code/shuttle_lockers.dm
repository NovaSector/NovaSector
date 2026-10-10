/obj/structure/closet/firecloset/shuttle
	name = "shuttle emergency locker"
	desc = "Otherwise known as the \"Oh, FUCK!\" locker, has a good chance to contain whatever you need to fix \
		basic problems aboard shuttles, so long as the contents haven't been reappropriated for some other use. \
		If nothing within helps, you could always try hiding from your problems inside of it?"
	icon = 'modular_nova/modules/ships_r_us/icons/shuttle_lockers.dmi'
	icon_state = "disastre"
	contents_pressure_protection = 1
	contents_thermal_insulation = 1

/obj/structure/closet/firecloset/shuttle/PopulateContents()
	new /obj/item/extinguisher/mini(src)
	new /obj/item/crowbar/large/emergency(src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/clothing/suit/utility/fire/heavy(src)
	new /obj/item/clothing/head/utility/hardhat/red(src)
	new /obj/item/emergency_bed(src)
	new /obj/item/storage/toolbox/emergency(src)
	new /obj/item/storage/medkit/frontier/stocked(src)
	new /obj/item/storage/medkit/combat_surgeon/stocked(src)

/obj/structure/closet/firecloset/shuttle/solo

/obj/structure/closet/firecloset/shuttle/solo/PopulateContents()
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/clothing/suit/utility/fire/heavy(src)
	new /obj/item/clothing/head/utility/hardhat/red(src)
	new /obj/item/emergency_bed(src)
	new /obj/item/storage/toolbox/emergency(src)
	new /obj/item/storage/medkit/frontier/stocked(src)
	new /obj/item/folded_navigation_gigabeacon(src)

/obj/structure/closet/firecloset/shuttle/tools
	name = "shuttle tools locker"
	desc = "Otherwise known as the \"What's wrong with her now?\" locker, (usually) has a variety of tools for maintenance \
		of smaller shuttles."
	icon_state = "gear"

/obj/structure/closet/firecloset/shuttle/tools/PopulateContents()
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/storage/toolbox/electrical(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/sheet/iron/thirty(src)
	new /obj/item/stack/sheet/glass/twenty(src)
	new /obj/item/door_seal(src)
	new /obj/item/door_seal(src)
	new /obj/item/folded_navigation_gigabeacon(src)
	new /obj/item/flatpack/autolathe(src)
	new /obj/item/wallframe/cell_charger_multi(src)
	new /obj/item/flatpacked_machine(src)

/obj/item/stack/sheet/iron/thirty
	amount = 30

/obj/item/stack/sheet/glass/twenty
	amount = 20
