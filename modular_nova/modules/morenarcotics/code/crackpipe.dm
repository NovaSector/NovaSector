/obj/item/cigarette/pipe/crackpipe
	name = "crack pipe"
	desc = "A slick, glass pipe made for smoking one thing: crack."
	icon = 'modular_nova/modules/morenarcotics/icons/crack.dmi'
	worn_icon = 'modular_nova/modules/morenarcotics/icons/mask.dmi'
	icon_state = "glass_pipeoff" //it seems like theres some unused crack pipe sprite in masks.dmi, sweet!
	icon_on = "glass_pipeon"
	icon_off = "glass_pipeoff"
	chem_volume = 20
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.05, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.05)

/obj/item/cigarette/pipe/crackpipe/process(seconds_per_tick)
	smoketime -= seconds_per_tick
	if(smoketime <= 0)
		if(ismob(loc))
			var/mob/living/smoking_mob = loc
			to_chat(smoking_mob, span_notice("Your [name] goes out."))
			lit = FALSE
			icon_state = icon_off
			inhand_icon_state = icon_off
			smoking_mob.update_worn_mask()
			packeditem = FALSE
			name = "empty [initial(name)]"
		STOP_PROCESSING(SSobj, src)
		return
	open_flame()
	if(reagents?.total_volume) // check if it has any reagents at all
		handle_reagents()


/obj/item/cigarette/pipe/crackpipe/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(is_type_in_list(attacking_item, list(/obj/item/reagent_containers/crack,/obj/item/reagent_containers/blacktar)))
		to_chat(user, span_notice("You stuff [attacking_item] into [src]."))
		smoketime = 2 * 60
		name = "[attacking_item.name]-packed [initial(name)]"
		if(attacking_item.reagents)
			attacking_item.reagents.trans_to(src, attacking_item.reagents.total_volume, transferred_by = user)
		qdel(attacking_item)
	else
		var/lighting_text = attacking_item.ignition_effect(src,user)
		if(lighting_text)
			if(smoketime > 0)
				light(lighting_text)
			else
				to_chat(user, span_warning("There is nothing to smoke!"))
		else
			return ..()

/datum/crafting_recipe/crackpipe
	name = "Crack pipe"
	result = /obj/item/cigarette/pipe/crackpipe
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/shard = 1,
				/obj/item/stack/rods = 10)
	parts = list(/obj/item/shard = 1)
	time = 20
	category = CAT_CHEMISTRY
