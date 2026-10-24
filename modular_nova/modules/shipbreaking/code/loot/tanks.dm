/obj/effect/spawner/random/salvage/every_small_tank
	name = "random small tank"
	icon_state = "tank"
	loot = list(
		/obj/structure/shuttle_decoration/liquid_tank/battery,
		/obj/structure/shuttle_decoration/liquid_tank/coolant,
		/obj/structure/shuttle_decoration/liquid_tank/explosive,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium,
	)

/obj/effect/spawner/random/salvage/small_fuel_tanks
	name = "random small fuel tank"
	icon_state = "fuel"
	loot = list(
		/obj/structure/shuttle_decoration/liquid_tank/explosive,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium,
	)

/obj/effect/spawner/random/salvage/every_industrial_tank
	name = "random industrial tank"
	icon_state = "industrial"
	loot = list(
		/obj/structure/shuttle_decoration/liquid_tank/coolant/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium/industrial,
	)

/obj/effect/spawner/random/salvage/industrial_fuel_only
	name = "random industrial fuel tank"
	icon_state = "industrial"
	loot = list(
		/obj/structure/shuttle_decoration/liquid_tank/explosive/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium/industrial,
	)
