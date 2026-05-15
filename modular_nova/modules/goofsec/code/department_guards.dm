//Rather than assigning a security officer to each department, Nova departments get their own allied Guards!
//Most related code is in this file; uniform icons are in the relevant department's .dmi

//SORT ORDER: Sci, Generic, Med, Engi, Cargo, Serv

/*
	UNIFORMS
*/
/obj/item/clothing/under/rank/security/officer/blueshirt/nova
	//Effectively the same as TG's blueshirt, including icon. The /nova path makes it easier for sorting.
	name = "science guard's uniform"

/obj/item/clothing/under/rank/security/officer/blueshirt/nova/setup_reskins()
	return

/obj/item/clothing/under/rank/security/officer/blueshirt/nova/orderly
	name = "orderly uniform"
	desc = "White scrubs with gray pants underneath. Be warned, wearers of this uniform may only take the Hippocratic Oath as a suggestion."
	icon_state = "orderly_uniform"
	worn_icon_state = "orderly_uniform"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/nova/engineering_guard
	name = "engineering guard uniform"
	desc = "Effectively just padded hi-vis coveralls, they do the trick both inside of, and while keeping people out of, a hardhat zone."
	icon_state = "engineering_guard_uniform"
	worn_icon_state = "engineering_guard_uniform"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/engineering.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/engineering_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/nova/customs_agent
	name = "customs agent uniform"
	desc = "A cargo-brown short-sleeve shirt, and cargo shorts in an authoritative charcoal color. Only for the FTU's finest strong-hands."
	icon_state = "customs_uniform"
	worn_icon_state = "customs_uniform"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/cargo.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/cargo_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/nova/bouncer
	name = "bouncer uniform"
	desc = "Short-sleeves and jeans, for that aura of cool that makes the drunk people listen."
	icon_state = "bouncer"
	worn_icon_state = "bouncer"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/civilian.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/obj/item/clothing/under/rank/security/nova/turtleneck/cargo
	name = "customs agent turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/cargo"
	greyscale_colors = "#39393F#ba832f#ba832f"

/obj/item/clothing/under/rank/security/nova/turtleneck/engineering
	name = "engineering guard turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/engineering"
	greyscale_colors = "#ee7900#a78962#FFE12F"

/obj/item/clothing/under/rank/security/nova/turtleneck/science
	name = "science guard turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/science"
	greyscale_colors = "#daeaf0#66748c#830085"

/obj/item/clothing/under/rank/security/nova/turtleneck/medical
	name = "orderly turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/medical"
	greyscale_colors = "#CBCDD1#39393F#16313D"

/obj/item/clothing/under/rank/security/nova/turtleneck/service
	name = "bouncer turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/service"
	greyscale_colors = "#39393F#57852A#57852A"

/obj/item/clothing/under/rank/security/nova/skirt/cargo
	name = "customs agent skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/cargo"
	greyscale_colors = "#39393F#ba832f#ba832f#39393F"

/obj/item/clothing/under/rank/security/nova/skirt/engineering
	name = "engineering guard skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/engineering"
	greyscale_colors = "#ee7900#a78962#FFE12F#FFE12F"

/obj/item/clothing/under/rank/security/nova/skirt/science
	name = "science guard skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/science"
	greyscale_colors = "#daeaf0#66748c#830085#830085"

/obj/item/clothing/under/rank/security/nova/skirt/medical
	name = "orderly skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/medical"
	greyscale_colors = "#CBCDD1#39393F#16313D#16313D"

/obj/item/clothing/under/rank/security/nova/skirt/service
	name = "bouncer skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/service"
	greyscale_colors = "#39393F#57852A#57852A#EBEBEB"

/obj/item/clothing/under/rank/security/nova/plainskirt/cargo
	name = "customs agent plain skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/cargo"
	greyscale_colors = "#39393F#ba832f#ba832f#39393F"

/obj/item/clothing/under/rank/security/nova/plainskirt/engineering
	name = "engineering guard plain skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/engineering"
	greyscale_colors = "#ee7900#a78962#FFE12F#FFE12F"

/obj/item/clothing/under/rank/security/nova/plainskirt/science
	name = "science guard plain skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/science"
	greyscale_colors = "#daeaf0#66748c#830085#830085"

/obj/item/clothing/under/rank/security/nova/plainskirt/medical
	name = "orderly plain skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/medical"
	greyscale_colors = "#CBCDD1#39393F#16313D#16313D"

/obj/item/clothing/under/rank/security/nova/plainskirt/service
	name = "bouncer plain skirt"
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/service"
	greyscale_colors = "#39393F#57852A#57852A#EBEBEB"

/obj/item/clothing/under/rank/security/nova/dress/cargo
	name = "customs agent dress"
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/cargo"
	greyscale_colors = "#ba832f#39393F#ba832f"

/obj/item/clothing/under/rank/security/nova/dress/engineering
	name = "engineering guard dress"
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/engineering"
	greyscale_colors = "#ee7900#a78962#FFE12F"

/obj/item/clothing/under/rank/security/nova/dress/science
	name = "science guard dress"
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/science"
	greyscale_colors = "#daeaf0#66748c#830085"

/obj/item/clothing/under/rank/security/nova/dress/medical
	name = "orderly dress"
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/medical"
	greyscale_colors = "#CBCDD1#39393F#16313D"

/obj/item/clothing/under/rank/security/nova/dress/service
	name = "bouncer dress"
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/service"
	greyscale_colors = "#57852A#39393F#EBEBEB"

/obj/item/clothing/under/rank/security/nova/shorts/cargo
	name = "customs agent shorts"
	icon_state = "/obj/item/clothing/under/rank/security/nova/shorts/cargo"
	greyscale_colors = "#39393F"

/obj/item/clothing/under/rank/security/nova/shorts/engineering
	name = "engineering guard shorts"
	icon_state = "/obj/item/clothing/under/rank/security/nova/shorts/engineering"
	greyscale_colors = "#a78962"

/obj/item/clothing/under/rank/security/nova/shorts/science
	name = "science guard shorts"
	icon_state = "/obj/item/clothing/under/rank/security/nova/shorts/science"
	greyscale_colors = "#66748c"

/obj/item/clothing/under/rank/security/nova/shorts/medical
	name = "orderly shorts"
	icon_state = "/obj/item/clothing/under/rank/security/nova/shorts/medical"
	greyscale_colors = "#16313D"

/obj/item/clothing/under/rank/security/nova/shorts/service
	name = "bouncer shorts"
	icon_state = "/obj/item/clothing/under/rank/security/nova/shorts/service"
	greyscale_colors = "#57852A"

/*
	NECK
*/
/obj/item/clothing/neck/security_cape/armplate_caped/engineer
	name = "caped engineer guard gauntlet"
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/engineer"
	greyscale_colors = "#ee7900"

/obj/item/clothing/neck/security_cape/armplate_caped/science
	name = "caped science guard gauntlet"
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/science"
	greyscale_colors = "#830085"

/obj/item/clothing/neck/security_cape/armplate_caped/medical
	name = "caped orderly gauntlet"
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/medical"
	greyscale_colors = "#16313D"

/obj/item/clothing/neck/security_cape/armplate_caped/cargo
	name = "caped cargo guard gauntlet"
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/cargo"
	greyscale_colors = "#ba832f"

/obj/item/clothing/neck/security_cape/armplate_caped/service
	name = "caped service guard gauntlet"
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/service"
	greyscale_colors = "#57852A"

/*
	SUITS
*/
/obj/item/clothing/suit/armor/vest/blueshirt/nova
	//Effectively the same as TG's blueshirt, including icon. The /nova path makes it easier for sorting.
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/blueshirt/nova/setup_reskins()
	return

/obj/item/clothing/suit/armor/vest/blueshirt/nova/guard //Badge-less version of the blueshirt vest
	icon_state = "guard_armor"
	worn_icon_state = "guard_armor"

/obj/item/clothing/suit/armor/vest/blueshirt/nova/orderly
	name = "armored orderly coat"
	desc = "An armored coat, in a deep paramedic blue. It'll keep you padded while dealing with troublesome patients."
	icon_state = "medical_coat"
	worn_icon_state = "medical_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/nova/engineering_guard
	name = "armored engineering guard coat"
	desc = "An armored coat whose hazard strips are worn to the point of uselessness. It'll keep you protected while clearing hazard zones at least."
	icon_state = "engineering_coat"
	worn_icon_state = "engineering_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/nova/customs_agent
	name = "armored customs agent coat"
	desc = "An armored coat, with intricately woven patterns and details. This should help keep you safe from unruly customers."
	icon_state = "customs_coat"
	worn_icon_state = "customs_coat"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/cargo
	name = "customs agent winter coat"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/cargo"
	greyscale_colors = "#ba832f#CEC8BF#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/engineering
	name = "engineering guard winter coat"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/engineering"
	greyscale_colors = "#ee7900#CEC8BF#a78962#FFE12F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/science
	name = "science guard winter coat"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/science"
	greyscale_colors = "#daeaf0#cec8bf#39393f#830085"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/medical
	name = "orderly winter coat"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/medical"
	greyscale_colors = "#16313D#cec8bf#39393f#cbcdd1"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/service
	name = "bouncer winter coat"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/service"
	greyscale_colors = "#57852A#CEC8BF#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/cargo
	name = "customs agent vested jacket"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/cargo"
	greyscale_colors = "#39393F#39393F#ba832f"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/engineering
	name = "engineering guard vested jacket"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/engineering"
	greyscale_colors = "#EE7900#39393F#CEC8BF"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/science
	name = "science guard vested jacket"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/science"
	greyscale_colors = "#830085#39393F#daeaf0"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/medical
	name = "orderly vested jacket"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/medical"
	greyscale_colors = "#16313D#39393F#CBCDD1"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/service
	name = "bouncer vested jacket"
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/service"
	greyscale_colors = "#57852a#39393F#ebebeb"

/obj/item/clothing/suit/armor/vest/depgag_hazard/cargo
	name = "customs agent hazard vest"
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard/cargo"
	greyscale_colors = "#ba832f#EBEBEB"

/obj/item/clothing/suit/armor/vest/depgag_hazard/engineering
	name = "engineering guard hazard vest"
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard/engineering"
	greyscale_colors = "#ee7900#EBEBEB"

/obj/item/clothing/suit/armor/vest/depgag_hazard/science
	name = "science guard hazard vest"
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard/science"
	greyscale_colors = "#830085#EBEBEB"

/obj/item/clothing/suit/armor/vest/depgag_hazard/medical
	name = "orderly hazard vest"
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard/medical"
	greyscale_colors = "#16313D#EBEBEB"

/obj/item/clothing/suit/armor/vest/depgag_hazard/service
	name = "bouncer hazard vest"
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard/service"
	greyscale_colors = "#57852A#EBEBEB"

/*
	HEAD
*/
/obj/item/clothing/head/helmet/blueshirt/nova
	//Effectively the same as TG's blueshirt, including icon. The /nova path makes it easier for sorting.
	//The base one is used for science guards, and the sprite is unchanged

/obj/item/clothing/head/helmet/blueshirt/nova/guard //Version of the blueshirt helmet without a blue line. Used by all dept guards right now.
	icon = 'modular_nova/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "mallcop_helm"
	worn_icon_state = "mallcop_helm"

/obj/item/clothing/head/beret/sec/science
	name = "science guard beret"
	desc = "A robust beret with an Erlenmeyer flask emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/science"
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#8D008F#F2F2F2"

/obj/item/clothing/head/beret/sec/medical
	name = "medical officer beret"
	desc = "A robust beret with a Medical insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/medical"
	greyscale_colors = "#16313D#F2F2F2" //Paramed blue to (mostly) match their vest (as opposed to medical white)

/obj/item/clothing/head/beret/sec/engineering
	name = "engineer officer beret"
	desc = "A robust beret with a hazard symbol emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/engineering"
	greyscale_colors = "#ee7900#F2F2F2"

/obj/item/clothing/head/beret/sec/cargo
	name = "cargo officer beret"
	desc = "A robust beret with a Crate emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/cargo"
	greyscale_colors = "#c99840#F2F2F2"

/obj/item/clothing/head/beret/sec/service
	name = "bouncer beret"
	desc = "A robust beret with a simple badge emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/service"
	greyscale_colors = "#5E8F2D#F2F2F2"

/obj/item/clothing/head/security_cap/cargo
	name = "customs agent cap"
	icon_state = "/obj/item/clothing/head/security_cap/cargo"
	greyscale_colors = "#ba832f#EBEBEB#39393F"

/obj/item/clothing/head/security_cap/engineering
	name = "engineering guard cap"
	icon_state = "/obj/item/clothing/head/security_cap/engineering"
	greyscale_colors = "#ee7900#EBEBEB#ee7900"

/obj/item/clothing/head/security_cap/science
	name = "science guard cap"
	icon_state = "/obj/item/clothing/head/security_cap/science"
	greyscale_colors = "#830085#daeaf0#830085"

/obj/item/clothing/head/security_cap/medical
	name = "orderly cap"
	icon_state = "/obj/item/clothing/head/security_cap/medical"
	greyscale_colors = "#16313D#CBCDD1#39393F"

/obj/item/clothing/head/security_cap/service
	name = "bouncer cap"
	icon_state = "/obj/item/clothing/head/security_cap/service"
	greyscale_colors = "#57852A#EBEBEB#57852A"

/*
	BELT
*/
/obj/item/storage/belt/security/department_guard
	icon_state = "engine"
	worn_icon_state = "engine"
	icon = 'modular_nova/modules/goofsec/icons/obj/belts.dmi'
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/belts.dmi'

/obj/item/storage/belt/security/department_guard/setup_reskins()
	return

/obj/item/storage/belt/security/department_guard/science
	name = "science guard belt"
	icon_state = "science"
	worn_icon_state = "science"

/obj/item/storage/belt/security/department_guard/science/PopulateContents()
	new /obj/item/restraints/handcuffs/cable/pink(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/gun/ballistic/automatic/pistol/pepperball(src)
	new /obj/item/melee/baton/security/loaded/departmental/science(src)

/obj/item/storage/belt/security/department_guard/medical
	name = "medical guard belt"
	icon_state = "medical"
	worn_icon_state = "medical"

/obj/item/storage/belt/security/department_guard/medical/PopulateContents()
	new /obj/item/restraints/handcuffs/cable/blue(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/gun/ballistic/automatic/pistol/pepperball(src)
	new /obj/item/melee/baton/security/loaded/departmental/medical(src)

/obj/item/storage/belt/security/department_guard/engineering
	name = "engineer guard belt"
	icon_state = "engine"
	worn_icon_state = "engine"

/obj/item/storage/belt/security/department_guard/engineering/PopulateContents()
	new /obj/item/restraints/handcuffs/cable/yellow(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/gun/ballistic/automatic/pistol/pepperball(src)
	new /obj/item/melee/baton/security/loaded/departmental/engineering(src)

/obj/item/storage/belt/security/department_guard/cargo
	name = "cargo guard belt"
	icon_state = "cargo"
	worn_icon_state = "cargo"

/obj/item/storage/belt/security/department_guard/cargo/PopulateContents()
	new /obj/item/restraints/handcuffs/cable/orange(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/gun/ballistic/automatic/pistol/pepperball(src)
	new /obj/item/melee/baton/security/loaded/departmental/cargo(src)

/obj/item/storage/belt/security/department_guard/service
	name = "service guard belt"
	icon_state = "service"
	worn_icon_state = "service"

/obj/item/storage/belt/security/department_guard/service/PopulateContents()
	new /obj/item/restraints/handcuffs/cable/green(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/gun/ballistic/automatic/pistol/pepperball(src)
	new /obj/item/melee/baton/security/loaded/departmental/service(src)
/*
	GLOVES
*/
/obj/item/clothing/gloves/color/black/security/depgag/cargo
	name = "customs agent gloves"
	icon_state = "/obj/item/clothing/gloves/color/black/security/depgag/cargo"
	greyscale_colors = "#39393F#ba832f"

/obj/item/clothing/gloves/color/black/security/depgag/engineering
	name = "engineering guard gloves"
	icon_state = "/obj/item/clothing/gloves/color/black/security/depgag/engineering"
	greyscale_colors = "#a78962#ee7900"

/obj/item/clothing/gloves/color/black/security/depgag/science
	name = "science guard gloves"
	icon_state = "/obj/item/clothing/gloves/color/black/security/depgag/science"
	greyscale_colors = "#daeaf0#830085"

/obj/item/clothing/gloves/color/black/security/depgag/medical
	name = "orderly gloves"
	icon_state = "/obj/item/clothing/gloves/color/black/security/depgag/medical"
	greyscale_colors = "#CBCDD1#16313D"

/obj/item/clothing/gloves/color/black/security/depgag/service
	name = "bouncer gloves"
	icon_state = "/obj/item/clothing/gloves/color/black/security/depgag/service"
	greyscale_colors = "#39393F#57852A"

/*
	LANDMARKS
*/
/obj/effect/landmark/start/science_guard
	name = "Science Guard"
	icon_state = "Science Guard"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/orderly
	name = "Orderly"
	icon_state = "Orderly"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/engineering_guard
	name = "Engineering Guard"
	icon_state = "Engineering Guard"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/customs_agent
	name = "Customs Agent"
	icon_state = "Customs Agent"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/bouncer
	name = "Service Guard"
	icon_state = "Bouncer"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/*
	SCIENCE GUARD DATUMS
*/
/datum/job/science_guard
	title = JOB_SCIENCE_GUARD
	description = "Figure out why the emails aren't working, keep an eye on the eggheads, protect them from their latest mistakes."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_RD
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "SCIENCE_GUARD"

	outfit = /datum/outfit/job/science_guard
	plasmaman_outfit = /datum/outfit/plasmaman/science

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/science)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/science_guard
	name = "Science Guard"
	jobtype = /datum/job/science_guard

	belt = /obj/item/storage/belt/security/department_guard/science
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/nova
	shoes = /obj/item/clothing/shoes/jackboots
	head =  /obj/item/clothing/head/helmet/blueshirt/nova
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/nova
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/modular_computer/pda/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science

	id_trim = /datum/id_trim/job/science_guard
	pda_slot = ITEM_SLOT_LPOCKET

/datum/id_trim/job/science_guard
	assignment = "Science Guard"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_calhoun"
	department_color = COLOR_SCIENCE_PINK
	subdepartment_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENCE_GUARD
	extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/science_guard

/*
	MEDICAL GUARD DATUMS
*/
/datum/job/orderly
	title = JOB_ORDERLY
	description = "Defend the medical department, hold down idiots who refuse the vaccine, assist medical with prep and/or cleanup."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CMO
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ORDERLY"

	outfit = /datum/outfit/job/orderly
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_ORDERLY
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/medical)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/orderly
	name = "Orderly"
	jobtype = /datum/job/orderly

	belt = /obj/item/storage/belt/security/department_guard/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/nova/orderly
	shoes = /obj/item/clothing/shoes/sneakers/white
	head =  /obj/item/clothing/head/helmet/blueshirt/nova/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/nova/orderly
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/modular_computer/pda/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	messenger = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/orderly
	pda_slot = ITEM_SLOT_LPOCKET

/datum/id_trim/job/orderly
	assignment = "Orderly"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_orderly"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_ORDERLY
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/orderly

/*
	ENGINEERING GUARD DATUMS
*/
/datum/job/engineering_guard
	title = JOB_ENGINEERING_GUARD
	description = "Monitor the supermatter, keep an eye on atmospherics, make sure everyone is wearing Proper Protective Equipment."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CE
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ENGINEERING_GUARD"

	outfit = /datum/outfit/job/engineering_guard
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_ENGINEER_GUARD
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/engineering)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/engineering_guard
	name = "Engineering Guard"
	jobtype = /datum/job/engineering_guard

	belt = /obj/item/storage/belt/security/department_guard/engineering
	ears = /obj/item/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/nova/engineering_guard
	head =  /obj/item/clothing/head/helmet/blueshirt/nova/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/nova/engineering_guard
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/modular_computer/pda/engineering

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng
	box = /obj/item/storage/box/survival/engineer

	id_trim = /datum/id_trim/job/engineering_guard
	pda_slot = ITEM_SLOT_LPOCKET

/datum/id_trim/job/engineering_guard
	assignment = "Engineering Guard"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_engiguard"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_ENGINEERING_GUARD
	extra_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/engineering_guard

/*
	CARGO GUARD DATUMS
*/
/datum/job/customs_agent
	title = JOB_CUSTOMS_AGENT
	description = "Inspect the packages coming to and from the station, protect the cargo department, beat the shit out of people trying to ship Cocaine to the Spinward Stellar Coalition."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_QM
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CUSTOMS_AGENT"

	outfit = /datum/outfit/job/customs_agent
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CUSTOMS_AGENT
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/cargo)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/customs_agent
	name = "Customs Agent"
	jobtype = /datum/job/customs_agent

	belt = /obj/item/storage/belt/security/department_guard/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/sneakers/black
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/nova/customs_agent
	head =  /obj/item/clothing/head/helmet/blueshirt/nova/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/nova/customs_agent
	glasses = /obj/item/clothing/glasses/hud/gun_permit
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/modular_computer/pda/cargo

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/customs_agent
	pda_slot = ITEM_SLOT_LPOCKET

/datum/id_trim/job/customs_agent
	assignment = "Customs Agent"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_customs"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CUSTOMS_AGENT
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_QM, ACCESS_CHANGE_IDS)
	job = /datum/job/customs_agent

/*
	SERVICE GUARD DATUMS
*/
/datum/job/bouncer
	title = JOB_BOUNCER
	description = "Make sure people don't jump the kitchen counter, stop Chapel vandalism, check bargoer's IDs, prevent the dreaded \"food fight\"."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_HOP
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BOUNCER"

	outfit = /datum/outfit/job/bouncer
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	bounty_types = CIV_JOB_DRINK
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/service)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/bouncer
	name = "Bouncer"
	jobtype = /datum/job/bouncer

	belt = /obj/item/storage/belt/security/department_guard/service
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/nova/bouncer
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/helmet/blueshirt/nova/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/nova/guard
	l_pocket = /obj/item/modular_computer/pda/bar
	r_pocket = /obj/item/flashlight
	glasses = /obj/item/clothing/glasses/sunglasses

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/bouncer
	pda_slot = ITEM_SLOT_LPOCKET

/datum/id_trim/job/bouncer
	assignment = "Service Guard"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_bouncer"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME // Personally speaking I'd have one of these with sec colors but I'm being authentic
	sechud_icon_state = SECHUD_BOUNCER
	extra_access = list(
		ACCESS_BAR,
		ACCESS_JANITOR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_BAR,
		ACCESS_JANITOR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/bouncer

/*
	Departmental Batons
*/
/obj/item/melee/baton/security/loaded/departmental
	name = "departmental stun baton"
	desc = "A stun baton fitted with a departmental area-lock, based off the station's blueprint layout - outside of its department, it only has three uses."
	icon = 'modular_nova/modules/goofsec/icons/departmental_batons.dmi'
	icon_state = "prison_stunbaton"
	inside_belt_icon_state = "stunbaton"
	var/department_icon_state = "prison"
	var/list/valid_areas = list()
	var/emagged = FALSE
	var/non_departmental_uses_left = 4

/obj/item/melee/baton/security/loaded/departmental/update_icon_state()
	. = ..()
	icon_state = "[department_icon_state]_[icon_state]"

/obj/item/melee/baton/security/loaded/departmental/try_stun(mob/living/target, mob/living/user, harmbatonning)
	if(active && !emagged && COOLDOWN_FINISHED(src, cooldown_check))
		var/area/current_area = get_area(user)
		if(!is_type_in_list(current_area, valid_areas))
			if(non_departmental_uses_left)
				non_departmental_uses_left--
				if(non_departmental_uses_left)
					say("[non_departmental_uses_left] non-departmental uses left!")
				else
					say("[src] is out of non-departmental uses! Return to your department and reactivate the baton to refresh it!")
			else
				target.visible_message(span_warning("[user] prods [target] with [src]. Luckily, it shut off due to being in the wrong area."), \
					span_warning("[user] prods you with [src]. Luckily, it shut off due to being in the wrong area."))
				turn_off()
				balloon_alert(user, "wrong department")
				playsound(src, SFX_SPARKS, 75, TRUE, -1)
				update_appearance()
				return FALSE
	return ..()

/obj/item/melee/baton/security/loaded/departmental/attack_self(mob/user)
	. = ..()
	if(active) // just turned on
		var/area/current_area = get_area(user)
		if(!is_type_in_list(current_area, valid_areas))
			return
		if(non_departmental_uses_left < 4)
			say("Non-departmental uses refreshed!")
			non_departmental_uses_left = 4

/obj/item/melee/baton/security/loaded/departmental/emag_act(mob/user)
	if(!emagged)
		if(user)
			user.visible_message(span_warning("Sparks fly from [src]!"),
							span_warning("You scramble [src]'s departmental lock, allowing it to be used freely!"),
							span_hear("You hear a faint electrical spark."))
		balloon_alert(user, "emagged")
		playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		emagged = TRUE
		return TRUE
	return FALSE

/obj/item/melee/baton/security/loaded/departmental/medical
	name = "medical stun baton"
	desc = "A stun baton that doesn't operate outside of the Medical department, based off the station's blueprint layout. Can be used outside of Medical up to three times before needing to return!"
	department_icon_state = "medical"
	valid_areas = list(/area/station/medical, /area/station/maintenance/department/medical, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/engineering
	name = "engineering stun baton"
	desc = "A stun baton that doesn't operate outside of the Engineering department, based off the station's blueprint layout. Can be used outside of Engineering up to three times before needing to return!"
	department_icon_state = "engineering"
	valid_areas = list(/area/station/engineering, /area/station/maintenance/department/engine, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/science
	name = "science stun baton"
	desc = "A stun baton that doesn't operate outside of the Science department, based off the station's blueprint layout. Can be used outside of Science up to three times before needing to return!"
	department_icon_state = "science"
	valid_areas = list(/area/station/science, /area/station/maintenance/department/science, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/cargo
	name = "cargo stun baton"
	desc = "A stun baton that doesn't operate outside of the Cargo department, based off the station's blueprint layout. Can be used outside of Cargo up to three times before needing to return!"
	department_icon_state = "cargo"
	valid_areas = list(/area/station/cargo, /area/station/maintenance/department/cargo, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/service
	name = "service stun baton"
	desc = "A stun baton that doesn't operate outside of the Service department, based off the station's blueprint layout. Can be used outside of Service up to three times before needing to return!"
	department_icon_state = "service"
	valid_areas = list(/area/station/service, /area/station/hallway/primary/fore, /area/station/commons/lounge, /area/station/maintenance/department/chapel, /area/station/maintenance/department/crew_quarters, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/prison
	name = "prison stun baton"
	desc = "A stun baton that doesn't operate outside of the Prison, based off the station's blueprint layout. Can be used outside of the Prison up to three times before needing to return!"
	department_icon_state = "prison"
	valid_areas = list(/area/station/security/prison, /area/station/security/processing, /area/shuttle/escape)

/datum/supply_pack/security/baton_prison
	name = "Prison Baton Crate"
	desc = "Contains an extra baton for Corrections Officers. \
		Just in case you hated the idea of a normal baton in their hands."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/prison)

/datum/supply_pack/service/baton_service
	name = "Service Baton Crate"
	desc = "Contains an extra baton for Service Guards."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/service)

/datum/supply_pack/medical/baton_medical
	name = "Medical Baton Crate"
	desc = "Contains an extra baton for Orderlies."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/medical)

/datum/supply_pack/engineering/baton_engineering
	name = "Engineering Baton Crate"
	desc = "Contains an extra baton for Engineering Guards."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/engineering)

/datum/supply_pack/science/baton_science
	name = "Science Baton Crate"
	desc = "Contains an extra baton for Science Guards."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/science)

/datum/supply_pack/misc/baton_cargo
	name = "Cargo Baton Crate"
	desc = "Contains an extra baton for Customs Agents."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/cargo)
/*
* Garment Bags
*/

/obj/item/storage/bag/garment/science_guard
	name = "science guard's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the science guard."

/obj/item/storage/bag/garment/science_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_sci = 1,
		/obj/item/clothing/shoes/sneakers/black = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/nova = 1,
		/obj/item/clothing/head/helmet/blueshirt/nova = 1,
		/obj/item/clothing/head/beret/sec/science = 1,
		/obj/item/clothing/head/security_cap/science = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/nova = 1,
		/obj/item/clothing/suit/armor/vest/depgag_hazard/science = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/science = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/science = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/gloves/color/black/security/depgag/science = 1,
		/obj/item/clothing/under/rank/security/nova/shorts/science = 1,
		/obj/item/clothing/under/rank/security/nova/turtleneck/science = 1,
		/obj/item/clothing/under/rank/security/nova/skirt/science = 1,
		/obj/item/clothing/under/rank/security/nova/plainskirt/science = 1,
		/obj/item/clothing/under/rank/security/nova/dress/science = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/science = 1,
		/obj/item/clothing/neck/security_cape/armplate_caped/science = 1,
	), src)

/obj/item/storage/bag/garment/orderly
	name = "orderly's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the orderly."

/obj/item/storage/bag/garment/orderly/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_med = 1,
		/obj/item/clothing/shoes/sneakers/white = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/nova/orderly = 1,
		/obj/item/clothing/head/helmet/blueshirt/nova/guard = 1,
		/obj/item/clothing/head/beret/sec/medical = 1,
		/obj/item/clothing/head/security_cap/medical = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/nova/orderly = 1,
		/obj/item/clothing/suit/armor/vest/depgag_hazard/medical = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/medical = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/medical = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/gloves/color/black/security/depgag/medical = 1,
		/obj/item/clothing/under/rank/security/nova/shorts/medical = 1,
		/obj/item/clothing/under/rank/security/nova/turtleneck/medical = 1,
		/obj/item/clothing/under/rank/security/nova/skirt/medical = 1,
		/obj/item/clothing/under/rank/security/nova/plainskirt/medical = 1,
		/obj/item/clothing/under/rank/security/nova/dress/medical = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/medical = 1,
		/obj/item/clothing/neck/security_cape/armplate_caped/medical = 1,
	), src)

/obj/item/storage/bag/garment/engineering_guard
	name = "engineering guard's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the engineering guard."

/obj/item/storage/bag/garment/engineering_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_eng = 1,
		/obj/item/clothing/shoes/workboots = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/nova/engineering_guard = 1,
		/obj/item/clothing/head/helmet/blueshirt/nova/guard = 1,
		/obj/item/clothing/head/beret/sec/engineering = 1,
		/obj/item/clothing/head/security_cap/engineering = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/nova/engineering_guard = 1,
		/obj/item/clothing/suit/armor/vest/depgag_hazard/engineering = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/engineering = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/engineering = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/gloves/color/black/security/depgag/engineering = 1,
		/obj/item/clothing/under/rank/security/nova/shorts/engineering = 1,
		/obj/item/clothing/under/rank/security/nova/turtleneck/engineering = 1,
		/obj/item/clothing/under/rank/security/nova/skirt/engineering = 1,
		/obj/item/clothing/under/rank/security/nova/plainskirt/engineering = 1,
		/obj/item/clothing/under/rank/security/nova/dress/engineering = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/engineering = 1,
		/obj/item/clothing/neck/security_cape/armplate_caped/engineer = 1,
	), src)

/obj/item/storage/bag/garment/customs_agent
	name = "customs agent's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the customs agent."

/obj/item/storage/bag/garment/customs_agent/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_cargo = 1,
		/obj/item/clothing/shoes/sneakers/black = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/nova/customs_agent = 1,
		/obj/item/clothing/head/helmet/blueshirt/nova/guard = 1,
		/obj/item/clothing/head/beret/sec/cargo = 1,
		/obj/item/clothing/head/security_cap/cargo = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/nova/customs_agent = 1,
		/obj/item/clothing/suit/armor/vest/depgag_hazard/cargo = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/cargo = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/cargo = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/hud/gun_permit = 1,
		/obj/item/clothing/gloves/color/black/security/depgag/cargo = 1,
		/obj/item/clothing/under/rank/security/nova/shorts/cargo = 1,
		/obj/item/clothing/under/rank/security/nova/turtleneck/cargo = 1,
		/obj/item/clothing/under/rank/security/nova/skirt/cargo = 1,
		/obj/item/clothing/under/rank/security/nova/plainskirt/cargo = 1,
		/obj/item/clothing/under/rank/security/nova/dress/cargo = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/cargo = 1,
		/obj/item/clothing/neck/security_cape/armplate_caped/cargo = 1,
	), src)

/obj/item/storage/bag/garment/service_guard
	name = "\proper the service guard's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the service guard."

/obj/item/storage/bag/garment/service_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_srv = 1,
		/obj/item/clothing/shoes/sneakers/black = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/nova/bouncer = 1,
		/obj/item/clothing/head/helmet/blueshirt/nova/guard = 1,
		/obj/item/clothing/head/beret/sec/service = 1,
		/obj/item/clothing/head/security_cap/service = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/nova/guard = 1,
		/obj/item/clothing/suit/armor/vest/depgag_hazard = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket/service = 1,
		/obj/item/clothing/suit/hooded/wintercoat/security/depgag/service = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/gloves/color/black/security/depgag/service = 1,
		/obj/item/clothing/under/rank/security/nova/shorts/service = 1,
		/obj/item/clothing/under/rank/security/nova/turtleneck/service = 1,
		/obj/item/clothing/under/rank/security/nova/skirt/service = 1,
		/obj/item/clothing/under/rank/security/nova/plainskirt/service = 1,
		/obj/item/clothing/under/rank/security/nova/dress/service = 1,
		/obj/item/clothing/neck/security_cape/armplate_caped/service = 1,
	), src)
