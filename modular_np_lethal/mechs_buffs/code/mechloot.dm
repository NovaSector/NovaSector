/obj/structure/maintenance_loot_structure/large_crate/mechsupply
	name = "Exosuit supply box"
	desc = "A large crate for transporting equally large amounts of tools and components around."
	icon_state = "toolcrate"
	loot_weighted_list = list(
		/obj/effect/spawner/random/epic_loot/mech_weapons = 2,
		/obj/effect/spawner/random/epic_loot/mech_mods = 1,
		/obj/effect/spawner/random/epic_loot/mech_ammo = 1

	)



/obj/effect/spawner/random/epic_loot/mech_weapons
	name = "random exo spawner"
	desc = "Automagically transforms into a mech bit of some sort."
	icon_state = "random_tool"
	loot = list(


		/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/mechsaw = 0.2, // hehe funny
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/clusterbang/impactlauncher = 1,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/stringers = 1.5,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang = 1.5,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/ac20 = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/railgun = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/lasershot = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy = 2,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/trickshot = 2,
	)


/obj/effect/spawner/random/epic_loot/mech_mods
	name = "random exo spawner"
	desc = "Automagically transforms into a mech bit of some sort."
	icon_state = "random_tool"
	loot = list(
	/obj/item/mecha_parts/mecha_equipment/repair_droid = 2,
	/obj/item/mecha_parts/mecha_equipment/radio = 2,
	/obj/item/mecha_parts/mecha_equipment/teleporter = 2,
	/obj/item/mecha_parts/mecha_equipment/wormhole_generator = 2,
	/obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster = 2,
	/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster = 2

	)

/obj/effect/spawner/random/epic_loot/mech_ammo
	name = "random exo spawner"
	desc = "Automagically transforms into a mech bit of some sort."
	icon_state = "random_tool"
	loot = list(
	/obj/item/mecha_ammo/lmg/ballistic = 2,
	/obj/item/mecha_ammo/flashbang/nonlethal = 2,
	/obj/item/mecha_ammo/pep/explosive = 3

	)
