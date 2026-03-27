/// Interdyne proprietary autoinjectors — dark body with colored band indicating damage type.

/obj/item/reagent_containers/hypospray/medipen/interdyne
	name = "Interdyne autoinjector"
	desc = "A sleek, dark autoinjector bearing the Interdyne Pharmaceuticals brand. \
		Its proprietary design is required for administering Interdyne's enhanced pharmaceutical compounds."
	icon = 'modular_nova/modules/company_imports/icons/interdyne_injectors.dmi'
	icon_state = "default"
	base_icon_state = "default"
	volume = 50
	amount_per_transfer_from_this = 50
	list_reagents = list()

/obj/item/reagent_containers/hypospray/medipen/interdyne/inject(mob/living/affected_mob, mob/user)
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE
	if((affected_mob != user) && !do_after(user, 1 SECONDS, affected_mob))
		return FALSE
	return ..()

/obj/item/reagent_containers/hypospray/medipen/interdyne/brute
	name = "Interdyne brute trauma injector"
	desc = "A dark Interdyne autoinjector with a red band, designed for brute trauma treatment."
	icon_state = "brute"
	base_icon_state = "brute"

/obj/item/reagent_containers/hypospray/medipen/interdyne/burn
	name = "Interdyne burn treatment injector"
	desc = "A dark Interdyne autoinjector with an orange band, designed for burn treatment."
	icon_state = "burn"
	base_icon_state = "burn"

/obj/item/reagent_containers/hypospray/medipen/interdyne/tox
	name = "Interdyne toxin purge injector"
	desc = "A dark Interdyne autoinjector with a green band, designed for toxin purging."
	icon_state = "tox"
	base_icon_state = "tox"

/obj/item/reagent_containers/hypospray/medipen/interdyne/oxy
	name = "Interdyne suffocation treatment injector"
	desc = "A dark Interdyne autoinjector with a blue band, designed for oxygen deprivation treatment."
	icon_state = "oxy"
	base_icon_state = "oxy"

/obj/item/reagent_containers/hypospray/medipen/interdyne/misc
	name = "Interdyne general purpose injector"
	desc = "A dark Interdyne autoinjector with a white band, designed for general-purpose pharmaceuticals."
	icon_state = "misc"
	base_icon_state = "misc"
