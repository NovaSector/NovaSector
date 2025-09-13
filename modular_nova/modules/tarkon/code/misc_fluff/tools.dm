/obj/item/construction/rcd/tarkon
	name = "Tarkon Industries RCD"
	desc = "An RCD of an improved design with a \"Tarkon Industries\" logo on it. Reload using metal, glass, or plasteel."
	icon = 'modular_nova/modules/tarkon/icons/misc/tools.dmi'
	icon_state = "trcd"
	ranged = TRUE
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	canRturf = FALSE //We at tarkon industries believe in "Manual Correction". memorize the Rwall decon sequence and you're hired.
	delay_mod = 0.8	//Faster than RCD, Slower than ARCD.
	max_matter = 200	//Industrial/Combat RCD is like 500. Its still better than default 160 and wont matter once silo upgraded. also I like properly rounded numbers.
	matter = 200
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_NO_FREQUENT_USE_COOLDOWN
	var/safety_enabled = TRUE


    //Check if the target is on station and safety is enabled
	//If so, prevent placement and alert the user
	//Ignore check if target is within 1 tile of user
	/obj/item/construction/rcd/tarkon/can_place(atom/target, list/rcd_results, mob/user)

		if(!(target in dview(1, get_turf(user))))
			if (istype(get_area(target), /area/station) && safety_enabled)
				balloon_alert(user,"Safety engaged")
				flick("[icon_state]_empty", src)
				return FALSE

		return ..(target, rcd_results, user)


/obj/item/construction/rcd/arcd/tarkon
	name = "Tarkon Industries Advanced RCD"
	desc = "An improved version over the base design, one of its kind. Works at range, and can deconstruct reinforced walls. Reload using metal, glass, or plasteel."
	icon = 'modular_nova/modules/tarkon/icons/misc/tools.dmi'
	icon_state = "atrcd"
	worn_icon_state = "RCD"
	ranged = TRUE
	canRturf = TRUE
	has_ammobar = TRUE
	max_matter = 500
	matter = 500
	canRturf = TRUE
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_FURNISHING

