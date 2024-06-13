/datum/component/construction/unordered/mecha_chassis/marauder
	result = /datum/component/construction/mecha/marauder
	steps = list(
		/obj/item/mecha_parts/part/marauder_torso,
		/obj/item/mecha_parts/part/marauder_left_arm,
		/obj/item/mecha_parts/part/marauder_right_arm,
		/obj/item/mecha_parts/part/marauder_left_leg,
		/obj/item/mecha_parts/part/marauder_right_leg,
		/obj/item/mecha_parts/part/marauder_head
	)

/datum/component/construction/mecha/marauder
	result = /obj/vehicle/sealed/mecha/marauder
	base_icon = "durand"

	circuit_control = /obj/item/circuitboard/mecha/marauder/main
	circuit_periph = /obj/item/circuitboard/mecha/marauder/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/marauder/targeting

	inner_plating = /obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating = /obj/item/mecha_parts/part/marauder_armor
	outer_plating_amount = 1
