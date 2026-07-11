/obj/item/clothing/neck/mantle
	name = "mantle"
	desc = "A decorative drape over the shoulders. This one has a simple, dry color."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "mantle"

/obj/item/clothing/neck/tesharian_mantle
	name = "Tesharian mantle"
	desc = "Locally sourced from 'Opalite Industries', sewed by the most gentle of packs; The Tesharian mantle is a comfortable knit to cover a decent amount of the average wearer's chest and neck in its luxurious fabric and wool, held together by adorned with stitching. Local Reviewers say: The human-sized ones seems to be made of some brandless knockoff 'eco-friendly' fabric..."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/tesharian_mantle"
	post_init_icon_state = "tesharian_mantle"
	greyscale_config = /datum/greyscale_config/tesharian_mantle
	greyscale_config_worn = /datum/greyscale_config/tesharian_mantle/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/tesharian_mantle/worn/teshari
	greyscale_colors = "#ffcc00#ffffff"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/mantle/regal
	name = "regal mantle"
	desc = "A colorful felt mantle. You feel posh just holding this thing."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "regal-mantle"

/obj/item/clothing/neck/mantle/qm
	name = "\proper the quartermaster's mantle"
	desc = "A snug and comfortable looking shoulder covering garment, it has an air of rebellion and independence. Or annoyance and delusions, your call."
	icon_state = "qmmantle"

/obj/item/clothing/neck/mantle/hopmantle
	name = "\proper the head of personnel's mantle"
	desc = "A decorative draping of blue and red over your shoulders, signifying your stamping prowess."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hopmantle"

/obj/item/clothing/neck/mantle/cmomantle
	name = "\proper the chief medical officer's mantle"
	desc = "A light blue shoulder draping for THE medical professional. Contrasts well with blood."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cmomantle"

/obj/item/clothing/neck/mantle/rdmantle
	name = "\proper the research director's mantle"
	desc = "A terribly comfortable shoulder draping for the discerning scientist of fashion."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "rdmantle"

/obj/item/clothing/neck/mantle/cemantle
	name = "\proper the chief engineer's mantle"
	desc = "A bright white and yellow striped mantle. Do not wear around active machinery."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cemantle"

/datum/atom_skin/hosmantle
	abstract_type = /datum/atom_skin/hosmantle

/datum/atom_skin/hosmantle/red
	preview_name = "Red Variant"
	new_icon_state = "hosmantle"

/datum/atom_skin/hosmantle/blue
	preview_name = "Blue Variant"
	new_icon_state = "hosmantle_blue"

/obj/item/clothing/neck/mantle/hosmantle
	name = "\proper the head of security's mantle"
	desc = "A plated mantle that one might wrap around the upper torso. The 'scales' of the garment signify the members of security and how you're carrying them on your shoulders."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hosmantle"

/obj/item/clothing/neck/mantle/hosmantle/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hosmantle)

/obj/item/clothing/neck/mantle/bsmantle
	name = "\proper the blueshield's mantle"
	desc = "A plated mantle with command colors. Suitable for the one assigned to making sure they're still breathing."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "bsmantle"

/obj/item/clothing/neck/mantle/capmantle
	name = "\proper the captain's mantle"
	desc = "A formal mantle to drape around the shoulders. Others stand on the shoulders of giants. You're the giant they stand on."
	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "capmantle"

/obj/item/clothing/neck/mantle/recolorable
	name = "mantle"
	desc = "A simple drape over the shoulders."
	worn_icon = 'modular_nova/modules/GAGS/icons/neck/neck.dmi'
	worn_icon_teshari = 'modular_nova/modules/GAGS/icons/neck/neck_teshari.dmi'
	greyscale_colors = "#ffffff"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/mantle/recolorable"
	post_init_icon_state = "mantle"
	greyscale_config = /datum/greyscale_config/mantle
	greyscale_config_worn = /datum/greyscale_config/mantle/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/mantle/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/mantle/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/mantle/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/face_scarf
	name = "face scarf"
	desc = "A warm looking scarf that you can easily put around your face."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/face_scarf"
	post_init_icon_state = "face_scarf"
	greyscale_config = /datum/greyscale_config/face_scarf
	greyscale_config_worn = /datum/greyscale_config/face_scarf/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/face_scarf/worn/muzzled
	greyscale_colors = "#a52424"
	flags_1 = IS_PLAYER_COLORABLE_1
	flags_inv = HIDEFACIALHAIR | HIDESNOUT
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/neck/face_scarf/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, toggle_noun = "scarf")

/obj/item/clothing/neck/face_scarf/click_alt(mob/user) //Make sure that toggling actually hides the snout so that it doesn't clip
	if(icon_state != "face_scarf_t")
		flags_inv = HIDEFACIALHAIR | HIDESNOUT
	else
		flags_inv = HIDEFACIALHAIR
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/maid_neck_cover
	name = "maid neck cover"
	desc = "A neckpiece for a maid costume, it smells faintly of disappointment."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/maid_neck_cover"
	post_init_icon_state = "maid_neck_cover"
	greyscale_config = /datum/greyscale_config/maid_neck_cover
	greyscale_config_worn = /datum/greyscale_config/maid_neck_cover/worn
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1

//Override thing from Monkey. Lets us tie bowties.

/obj/item/clothing/neck/tie
	var/tie_type = "tie_greyscale"

/obj/item/clothing/neck/tie/update_icon()
	. = ..()
	// Normal strip & equip delay, along with 2 second self equip since you need to squeeze your head through the hole.
	if(is_tied)
		icon_state = "[tie_type]_tied"
		strip_delay = 4 SECONDS
		equip_delay_other = 4 SECONDS
		equip_delay_self = 2 SECONDS
	else // Extremely quick strip delay, it's practically a ribbon draped around your neck
		icon_state = "[tie_type]_untied"
		strip_delay = 1 SECONDS
		equip_delay_other = 1 SECONDS
		equip_delay_self = 0

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/neck/tie/bunnytie
	name = "bowtie collar"
	desc = "A fancy tie that includes a collar. Looking snazzy!"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/tie/bunnytie"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	post_init_icon_state = "bowtie_collar_tied"
	tie_type = "bowtie_collar"
	greyscale_colors = "#ffffff#39393f"
	greyscale_config = /datum/greyscale_config/bowtie_collar
	greyscale_config_worn = /datum/greyscale_config/bowtie_collar_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/tie/bunnytie/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/bunnytie/syndicate
	name = "blood-red bowtie collar"
	desc = "A fancy tie that includes a red collar. Looking sinister..."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_syndi_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_syndi"
	armor_type = /datum/armor/large_scarf_syndie
	tie_timer = 2 SECONDS //Tactical tie
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/syndicate/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/magician
	name = "magician's bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking magical!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_wiz_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	custom_price = null

/obj/item/clothing/neck/tie/bunnytie/magician/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/centcom
	name = "centcom bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking in charge!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_centcom_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/centcom/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/communist
	name = "really red bowtie collar"
	desc = "A simple red tie that includes a collar. Looking egalitarian!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_communist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/communist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/blue
	name = "blue bowtie collar"
	desc = "A simple blue tie that includes a collar. Looking imperialist!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_blue_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/blue/tied
	is_tied = TRUE

//CAPTAIN

/obj/item/clothing/neck/tie/bunnytie/captain
	name = "captain's bowtie"
	desc = "A blue tie that includes a collar. Looking commanding!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_captain_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_captain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/captain/tied
	is_tied = TRUE

//CARGO

/obj/item/clothing/neck/tie/bunnytie/cargo
	name = "cargo bowtie"
	desc = "A brown tie that includes a collar. Looking unionized!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_cargo_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_cargo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cargo/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/miner
	name = "shaft miner's bowtie"
	desc = "A purple tie that includes a collar. Looking hardy!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_explorer_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_explorer"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/miner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/mailman
	name = "mailman's bowtie"
	desc = "A red tie that includes a collar. Looking unstoppable!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_mail_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_mail"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/mailman/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bitrunner
	name = "bunrunner's bowtie"
	desc = "Bitrunners were told that wearing a novelty shirt with a printed bow tie wasn't enough for formal events."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_bitrunner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_bitrunner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/bitrunner/tied
	is_tied = TRUE

//ENGI

/obj/item/clothing/neck/tie/bunnytie/engineer
	name = "engineering bowtie"
	desc = "An orange tie that includes a collar. Looking industrious!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_engi_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_engi"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/engineer/tied
	is_tied = TRUE


/obj/item/clothing/neck/tie/bunnytie/atmos_tech
	name = "atmospheric technician's bowtie"
	desc = "A blue tie that includes a collar. Looking inflammable!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_atmos_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_atmos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/atmos_tech/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/ce
	name = "chief engineer's bowtie"
	desc = "A green tie that includes a collar. Looking managerial!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_ce_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_ce"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/ce/tied
	is_tied = TRUE

//MEDICAL

/obj/item/clothing/neck/tie/bunnytie/doctor
	name = "medical bowtie"
	desc = "A light blue tie that includes a collar. Looking helpful!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_doctor_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_doctor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/doctor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/paramedic
	name = "paramedic's bowtie"
	desc = "A white tie that includes a collar. Looking selfless!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_paramedic_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_paramedic"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/paramedic/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/chemist
	name = "chemist's bowtie"
	desc = "An orange tie that includes a collar. Looking explosive!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_chem_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_chem"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/chemist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/pathologist
	name = "pathologist's bowtie"
	desc = "A green tie that includes a collar. Looking infectious!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_virologist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_virologist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/pathologist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/coroner
	name = "coroner's bowtie"
	desc = "A black tie that includes a collar. Looking dead...Dead good!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_coroner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_coroner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/coroner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/cmo
	name = "chief medical officer's bowtie"
	desc = "A blue tie that includes a collar. Looking responsible!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_cmo_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_cmo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cmo/tied
	is_tied = TRUE

//SCIENCE

/obj/item/clothing/neck/tie/bunnytie/scientist
	name = "scientist's bowtie"
	desc = "A purple tie that includes a collar. Looking intelligent!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_science_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/roboticist
	name = "roboticist's bowtie"
	desc = "A red tie that includes a collar. Looking transhumanist!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_roboticist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_roboticist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/roboticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/geneticist
	name = "geneticist's bowtie"
	desc = "A blue tie that includes a collar. Looking aberrant!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_genetics_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_genetics"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/geneticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/rd
	name = "research director's bowtie"
	desc = "A purple tie that includes a collar. Looking inventive!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_science_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

//SECURITY

/obj/item/clothing/neck/tie/bunnytie/security
	name = "security bowtie"
	desc = "A red tie that includes a collar. Looking tough!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_sec_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_sec"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/security_assistant
	name = "security assistant's bowtie"
	desc = "A grey tie that includes a collar. Looking \"helpful\"."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_sec_assistant_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_sec_assistant"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security_assistant/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/brig_phys
	name = "brig physician's bowtie"
	desc = "A red tie that includes a collar. Looking underappreciated!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_brig_phys_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_brig_phys"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/brig_phys/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/detective
	name = "detective's tie collar"
	desc = "A brown tie that includes a collar. Looking inquisitive!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "tie_collar_det_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_det"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/detective/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/prisoner
	name = "prisoner's bowtie"
	desc = "A black tie that includes a collar. Looking criminal!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_prisoner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_prisoner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/prisoner/tied
	is_tied = TRUE

//SERVICE

/obj/item/clothing/neck/tie/bunnytie/hop
	name = "head of personnel's bowtie"
	desc = "A dull red tie that includes a collar. Looking bogged down."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_hop_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_hop"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/hop/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/janitor
	name = "janitor's bowtie"
	desc = "A purple tie that includes a collar. Looking tidy!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_janitor_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_janitor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/janitor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bartender
	name = "bartender's bowtie"
	desc = "A black tie that includes a collar. Looking fancy!"
	icon_state = "/obj/item/clothing/neck/tie/bunnytie/bartender"
	flags_1 = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/neck/tie/bunnytie/bartender/tied
	is_tied = TRUE
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/bunnytie/cook
	name = "cook's bowtie"
	desc = "A red tie that includes a collar. Looking culinary!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_chef_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_chef"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cook/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/botanist
	name = "botanist's bowtie"
	desc = "A blue tie that includes a collar. Looking green-thumbed!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_collar_botany_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_botany"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/botanist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/clown
	name = "clown's bowtie"
	desc = "An outrageously large blue bowtie. Looking funny!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "bowtie_clown_tied"
	post_init_icon_state = null
	tie_type = "bowtie_clown"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null
	tie_timer = 8 SECONDS //It's a BIG bowtie

/obj/item/clothing/neck/tie/clown/tied
	is_tied = TRUE

/obj/item/clothing/neck/bunny_pendant
	name = "bunny pendant"
	desc = "A golden pendant depicting a holy rabbit."
	icon_state = "chaplain_pendant"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'

/obj/item/clothing/neck/tie/bunnytie/lawyer_black
	name = "lawyer's black tie collar"
	desc = "A black tie that includes a collar. Looking legal!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "tie_collar_lawyer_black_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_black"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_black/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue
	name = "lawyer's blue tie collar"
	desc = "A blue tie that includes a collar. Looking defensive!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "tie_collar_lawyer_blue_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_blue"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_red
	name = "lawyer's red tie collar"
	desc = "A red tie that includes a collar. Looking prosecutive!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "tie_collar_lawyer_red_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_red"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_red/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_good
	name = "good lawyer's tie collar"
	desc = "A black tie that includes a collar. Looking technically legal!"
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "tie_collar_lawyer_good_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_good"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_good/tied
	is_tied = TRUE


