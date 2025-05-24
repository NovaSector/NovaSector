/obj/projectile/kiss/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/parriable_projectile))
	AddComponent(/datum/component/parriable_projectile, parry_trait = TRAIT_CAN_HOLD_ITEMS) // Original: AddComponent(/datum/component/parriable_projectile) // allows kiss parry to be done without a mining exclusive. It wont accept null as a trait, dont try.
