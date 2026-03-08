/datum/robotic_style
	var/name = "None"
	/// The .dmi path for this robotic style
	var/icon = "None"
	/// If this style should override the default limb_id
	var/limb_id_override
	/// If this style's source utilizes a dimorphic chest
	var/dimorphic_chest = FALSE
	/// If this style's source utilizes a dimorphic head
	var/dimorphic_head = FALSE

/datum/robotic_style/scrappyipc
	name = "Scrappy"
	icon = 'modular_nova/master_files/icons/mob/augmentation/scrappyipc.dmi' // for ones that don't have associated limb atoms just setting icon works fine

/datum/robotic_style/scrappyipc_greyscale
	name = "Scrappy (Greyscale)"
	icon = 'modular_nova/master_files/icons/mob/augmentation/scrappyipc_greyscale.dmi'

/datum/robotic_style/surplus
	name = "Surplus"
	icon = 'icons/mob/augmentation/surplus_augments.dmi'

/datum/robotic_style/cyborg
	name = "Cyborg"
	icon = 'icons/mob/augmentation/augments.dmi'

/datum/robotic_style/engineering
	name = "Engineering"
	icon = 'icons/mob/augmentation/augments_engineer.dmi'

/datum/robotic_style/mining
	name = "Mining"
	icon = 'icons/mob/augmentation/augments_mining.dmi'

/datum/robotic_style/security
	name = "Security"
	icon = 'icons/mob/augmentation/augments_security.dmi'

/datum/robotic_style/mcgipc
	name = "Morpheus Cyberkinetics"
	icon = 'modular_nova/master_files/icons/mob/augmentation/mcgipc.dmi'

/datum/robotic_style/bshipc
	name = "Bishop Cyberkinetics"
	icon = 'modular_nova/master_files/icons/mob/augmentation/bshipc.dmi'

/datum/robotic_style/bs2ipc
	name = "Bishop Cyberkinetics 2.0"
	icon = 'modular_nova/master_files/icons/mob/augmentation/bs2ipc.dmi'

/datum/robotic_style/e3n
	name = "E3N AI"
	icon = 'modular_nova/master_files/icons/mob/augmentation/e3n.dmi'

/datum/robotic_style/hsiipc
	name = "Hephaestus Industries"
	icon = 'modular_nova/master_files/icons/mob/augmentation/hsiipc.dmi'

/datum/robotic_style/hi2ipc
	name = "Hephaestus Industries 2.0"
	icon = 'modular_nova/master_files/icons/mob/augmentation/hi2ipc.dmi'

/datum/robotic_style/sgmipc
	name = "Shellguard Munitions Standard Series"
	icon = 'modular_nova/master_files/icons/mob/augmentation/sgmipc.dmi'

/datum/robotic_style/wtmipc
	name = "Ward-Takahashi Manufacturing"
	icon = 'modular_nova/master_files/icons/mob/augmentation/wtmipc.dmi'

/datum/robotic_style/xmgipc
	name = "Xion Manufacturing Group"
	icon = 'modular_nova/master_files/icons/mob/augmentation/xmgipc.dmi'

/datum/robotic_style/xm2ipc
	name = "Xion Manufacturing Group 2.0"
	icon ='modular_nova/master_files/icons/mob/augmentation/xm2ipc.dmi'

/datum/robotic_style/zhpipc
	name = "Zeng-Hu Pharmaceuticals"
	icon = 'modular_nova/master_files/icons/mob/augmentation/zhpipc.dmi'

/datum/robotic_style/mariinskyipc
	name = "Mariinsky Ballet Company"
	icon = 'modular_nova/master_files/icons/mob/augmentation/mariinskyipc.dmi'

/datum/robotic_style/zhenkovipc
	name = "Zhenkov & Co. Foundries"
	icon = 'modular_nova/master_files/icons/mob/augmentation/zhenkovipc.dmi'

/datum/robotic_style/zhenkovipc_dark
	name = "Zhenkov & Co. Foundries - Dark"
	icon = 'modular_nova/master_files/icons/mob/augmentation/zhenkovipc_dark.dmi'

/datum/robotic_style/dimorphic // subtype so we don't have to define dimorphic head+chest every single time
	name = null // prevents the subtype from appearing in our list
	dimorphic_chest = TRUE
	dimorphic_head = TRUE

/datum/robotic_style/dimorphic/akula
	name = "Akula"
	icon = /obj/item/bodypart/chest/mutant/akula::icon_greyscale // see how we are just piggybacking off the actual greyscale limb here? this is ideal
	limb_id_override = /obj/item/bodypart/chest/mutant/akula::limb_id // same here

/datum/robotic_style/dimorphic/anthro
	name = "Anthro"
	icon = /obj/item/bodypart/chest/mutant::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/mutant::limb_id

/datum/robotic_style/dimorphic/lizard
	name = "Lizard"
	icon = /obj/item/bodypart/chest/lizard::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/lizard::limb_id
	dimorphic_head = FALSE

/datum/robotic_style/dimorphic/moth
	name = "Moth"
	icon = /obj/item/bodypart/chest/moth::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/moth::limb_id

/datum/robotic_style/dimorphic/ramatan
	name = "Ramatan"
	icon = /obj/item/bodypart/chest/mutant/ramatae::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/mutant/ramatae::limb_id

/datum/robotic_style/dimorphic/vox
	name = "Vox"
	icon = /obj/item/bodypart/chest/mutant/vox::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/mutant/vox::limb_id

/datum/robotic_style/dimorphic/xenohybrid
	name = "Xenohybrid"
	icon = /obj/item/bodypart/chest/mutant/xenohybrid::icon_greyscale
	limb_id_override = /obj/item/bodypart/chest/mutant/xenohybrid::limb_id

// kept at the bottom for parity with other augment dropdowns
/datum/robotic_style/none
	icon = 'icons/mob/augmentation/augments.dmi'
