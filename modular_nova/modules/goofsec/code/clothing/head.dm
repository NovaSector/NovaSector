/// SolFed Goggles
/obj/item/clothing/glasses/sunglasses/solfed
	name = "robust military goggles"
	desc = "A strangely old technology modernized to be much more robust in the modern day."
	icon_state = "/obj/item/clothing/glasses/sunglasses/solfed"
	post_init_icon_state = "federal_goggles"
	greyscale_config = /datum/greyscale_config/solfed_goggles
	greyscale_config_worn = /datum/greyscale_config/solfed_goggles/worn
	greyscale_colors = "#4d4d4d"
	glass_colour_type = /datum/client_colour/glass_colour/gray

// Sol Federation Combat Helmetjk
/obj/item/clothing/head/helmet/solfed
	name = "\improper SolFed MK I Combat helmet"
	desc = "A robust Sol Federation helmet designed with an integrated light to provide vision to the brave marines on the front line, and annoyingly no strap. It feels cheep \
	it feels mass produced, its perfect for missions that are of lower grade threats."
	icon_state = "icons/map_icons/clothing/head/_head"
	post_init_icon_state = "mark_one_helmet"
	worn_icon_state = "mark_one_helmet"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_type = /datum/armor/clothing_under/solfed_response_standard

	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_color = "#fff9f3"
	light_on = FALSE

	greyscale_config = /datum/greyscale_config/solfed_goggles
	greyscale_config_worn = /datum/greyscale_config/solfed_goggles/worn
	greyscale_colors = "#808080"
	unique_reskin = null
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	clothing_flags = SNUG_FIT

	/// Default state for the light
	var/on = FALSE
	/// Just to spite Ian (Also because I cannot be bothered to make a doggo version)
	dog_fashion = null

/obj/item/clothing/head/helmet/solfed/mk2
	name = "\improper SolFed MK II Combat helmet"
	desc = "A much more robust Sol Federation helmet than the MK I, coming with its signature integrated light from its older counterpart but also with more heavier protection. \
	this time with a strap!"
	icon_state = "icons/map_icons/clothing/head/_head"
	post_init_icon_state = "mark_two_helmet"
	worn_icon_state = "mark_two_helmet"
	armor_type = /datum/armor/clothing_under/solfed_response_grand

// Toggle state for the helmet light
/obj/item/clothing/head/helmet/solfed/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)

// Toggle state for the light ON
/obj/item/clothing/head/helmet/solfed/proc/turn_on(mob/user)
	set_light_on(TRUE)

// Toggle state for the light OFF
/obj/item/clothing/head/helmet/solfed/proc/turn_off(mob/user)
	set_light_on(FALSE)

/obj/item/clothing/head/helmet/solfed/attack_self(mob/living/user)
	toggle_helmet_light(user)
