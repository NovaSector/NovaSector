// Whilst we are technically not clothes, we should turn fast enough for players to never notice
/obj/item/transformative_wintercoat
	name = "Transformative Wintercoat"
	desc = "A special type of wintercoat that uses nanobots to quickly change its shape into the assigned job of the wearer, its limited amount of nanobots means it cannot replicate more exotic wintercoats."
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	var/changing = FALSE

/obj/item/transformative_wintercoat/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(!changing) // sanity check for race conditions (as if)
		changing = TRUE
		INVOKE_ASYNC(src, PROC_REF(change_wintercoat), user) // Me when coders forbid me from overriding on_equipped()

/obj/item/transformative_wintercoat/proc/change_wintercoat(mob/user)
	var/turf/our_turf = get_turf(src)
	moveToNullspace()
	sleep(1)
	if(QDELETED(src) || isnull(user.mind))
		return
	var/list/wintercoat_list = list(
		// Just a note, command is left out as their coats are unique and shouldn't be this easy to produce
		// Service
		/datum/job/botanist = /obj/item/clothing/suit/hooded/wintercoat/hydro,
		/datum/job/janitor = /obj/item/clothing/suit/hooded/wintercoat/janitor,
		/datum/job/bartender = /obj/item/clothing/suit/hooded/wintercoat/nova/bartender,
		// Security
		/datum/job_department/security = /obj/item/clothing/suit/hooded/wintercoat/security,
		// Medical
		/datum/job_department/medical = /obj/item/clothing/suit/hooded/wintercoat/medical,
		/datum/job/chemist = /obj/item/clothing/suit/hooded/wintercoat/medical/chemistry,
		/datum/job/coroner = /obj/item/clothing/suit/hooded/wintercoat/medical/coroner,
		/datum/job/virologist = /obj/item/clothing/suit/hooded/wintercoat/medical/viro,
		/datum/job/paramedic = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic,
		// Science
		/datum/job_department/science = /obj/item/clothing/suit/hooded/wintercoat/science,
		/datum/job/roboticist = /obj/item/clothing/suit/hooded/wintercoat/science/robotics,
		/datum/job/geneticist = /obj/item/clothing/suit/hooded/wintercoat/science/genetics,
		// Engineering
		/datum/job_department/engineering = /obj/item/clothing/suit/hooded/wintercoat/engineering,
		/datum/job/atmospheric_technician = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos,
		// Cargo
		/datum/job_department/cargo = /obj/item/clothing/suit/hooded/wintercoat/cargo,
		/datum/job/shaft_miner = /obj/item/clothing/suit/hooded/wintercoat/miner,
	)
	var/datum/job/role = user.mind.assigned_role
	var/obj/item/clothing/suit/hooded/wintercoat/wintercoat = wintercoat_list[role.type] || wintercoat_list[role.departments_list?[1]]
	if(isnull(wintercoat))
		wintercoat = /obj/item/clothing/suit/hooded/wintercoat

	wintercoat = new wintercoat(our_turf)
	user.put_in_active_hand(wintercoat)
	qdel(src)
