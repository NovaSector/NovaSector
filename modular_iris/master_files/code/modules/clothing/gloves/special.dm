/obj/item/clothing/gloves/fishing/attackby(obj/item/attacking_item, mob/user, params)
	var/datum/component/profound_fisher/fishing_component = GetComponent(/datum/component/profound_fisher)
	if(isnull(fishing_component))
		return ..()

	. = fishing_component.our_rod.attackby(attacking_item, user, params)
	if(.)
		return .
	return ..()
