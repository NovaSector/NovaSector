/obj/item/clothing/head/costume/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/costume.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

/obj/item/clothing/head/costume/nova/maid
	name = "maid headband"
	desc = "Maid for you."
	icon_state = "maid"

/obj/item/clothing/head/costume/nova/papakha
	name = "papakha"
	desc = "A big wooly clump of fur designed to go on your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/nova/papakha"
	post_init_icon_state = "papakha"
	greyscale_config = /datum/greyscale_config/papakha
	greyscale_config_worn = /datum/greyscale_config/papakha/worn
	greyscale_colors = "#222222"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/nova/flowerpin
	name = "flower pin"
	desc = "A small, colourable flower pin"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/nova/flowerpin"
	post_init_icon_state = "flowerpin"
	greyscale_config = /datum/greyscale_config/flowerpin
	greyscale_config_worn = /datum/greyscale_config/flowerpin/worn
	greyscale_colors = "#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/head/costume/nova/christmas
	name = "christmas hat"
	desc = "How festive!"
	icon_state = "christmas"

/obj/item/clothing/head/costume/nova/christmas/green
	icon_state = "christmas_g"

/obj/item/clothing/head/costume/nova/en //One of the two parts of E-N's butchering
	name = "E-N suit head"
	icon_state = "enhead"
	supports_variations_flags = NONE

//Ushankas
//These have to be subtypes of TG's ushanka to inherit the toggleability

/obj/item/clothing/head/costume/ushanka/sec/blue
	icon_state = "/obj/item/clothing/head/costume/ushanka/sec/blue"
	greyscale_colors = "#C7B08B#3F6E9E"

//Pelts
//Not made into a subtype of /costume but stored in the same file
/obj/item/clothing/head/pelt
	icon = 'modular_nova/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/costume.dmi'
	name = "bear pelt"
	desc = "A luxurious bear pelt, good to keep warm in winter. Or to sleep through it."
	icon_state = "bearpelt_brown"
	inhand_icon_state = "cowboy_hat_brown"
	cold_protection = CHEST|HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/pelt/black
	icon_state = "bearpelt_black"
	inhand_icon_state = "cowboy_hat_black"

/obj/item/clothing/head/pelt/white
	icon_state = "bearpelt_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/tiger
	name = "shiny tiger pelt"
	desc = "A vibrant tiger pelt, particularly fabulous."
	icon_state = "tigerpelt_shiny"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/snow_tiger
	name = "snow tiger pelt"
	desc = "A pelt of a less vibrant tiger, but rather warm."
	icon_state = "tigerpelt_snow"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/pink_tiger
	name = "pink tiger pelt"
	desc = "A particularly vibrant tiger pelt, for those who want to be the most fabulous at parties."
	icon_state = "tigerpelt_pink"
	inhand_icon_state = "cowboy_hat_red"

/obj/item/clothing/head/pelt/wolf
	name = "wolf pelt"
	desc = "A fuzzy wolf pelt that demands respect as a hunter... assuming it wasn't just purchased, that is, for all the glory but none of the credit."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_brown"

/obj/item/clothing/head/pelt/wolf/black
	icon_state = "wolfpelt_gray"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/wolf/white
	icon_state = "wolfpelt_white"
	inhand_icon_state = "cowboy_hat_white"
//End Pelts

/obj/item/clothing/head/maid_headband
	name = "maid headband"
	desc = "Just like from one of those Chinese cartoons!"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/maid_headband"
	post_init_icon_state = "maid_headband"
	greyscale_config = /datum/greyscale_config/maid_costume_headband
	greyscale_config_worn = /datum/greyscale_config/maid_costume_headband/worn
	greyscale_colors = "#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/head/playbunnyears
	name = "bunny ears headband"
	desc = "A pair of bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/playbunnyears"
	worn_icon = 'modular_nova/master_files/icons/mob/large-worn-icons/32x48/bunnyears.dmi'
	post_init_icon_state = "playbunny_ears"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/playbunnyears/syndicate
	name = "blood-red bunny ears headband"
	desc = "An unusually suspicious pair of bunny ears attached to a headband. The headband looks reinforced with plasteel... but why?"
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "syndibunny_ears"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/head/playbunnyears/centcom
	name = "centcom bunny ears headband"
	desc = "A pair of very professional bunny ears attached to a headband. The ears themselves came from an endangered species of green rabbits."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "playbunny_ears_centcom"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/british
	name = "british bunny ears headband"
	desc = "A pair of classy bunny ears attached to a headband. Worn to honor the crown."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "playbunny_ears_brit"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/communist
	name = "really red bunny ears headband"
	desc = "A pair of red and gold bunny ears attached to a headband. Commonly used by any collectivizing bunny waiters."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "playbunny_ears_communist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/usa
	name = "usa bunny ears headband"
	desc = "A pair of star spangled bunny ears attached to a headband. The headband of a true patriot."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "playbunny_ears_usa"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//CAPTAIN

/obj/item/clothing/head/hats/caphat/bunnyears_captain
	name = "captain's bunny ears"
	desc = "A pair of dark blue bunny ears attached to a headband. Worn in lieu of the more traditional bicorn hat."
	icon_state = "captain"
	inhand_icon_state = "that"
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/large-worn-icons/32x48/bunnyears.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

//CARGO

/obj/item/clothing/head/playbunnyears/quartermaster
	name = "quartermaster's bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The brown headband denotes relative importance."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "qm"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cargo
	name = "cargo bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The gray headband denotes relative unimportance."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "cargo_tech"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/miner
	name = "shaft miner's bunny ears"
	desc = "Muddy gray bunny ears attached to a headband. Has zero resistance against the hostile lavaland atmosphere."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "explorer"
	post_init_icon_state = null
	armor_type = /datum/armor/hooded_explorer
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mailman
	name = "mailman's bunny ears"
	desc = "Blue and red bunny ears attached to a headband. Shows everyone your commitment to speed and efficiency."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "mail"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bitrunner
	name = "bunrunner's bunny ears"
	desc = "Black and gold with stains of space mountain. The official wear of the Carota E-Sports team."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "bitrunner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//ENGI

/obj/item/clothing/head/playbunnyears/engineer
	name = "engineering bunny ears"
	desc = "Yellow and orange bunny ears attached to a headband. Likely to get caught in heavy machinery."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "engi"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/atmos_tech
	name = "atmospheric technician's bunny ears"
	desc = "Yellow and blue bunny ears attached to a headband. Gives zero protection against both fires and extreme pressures."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "atmos"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/ce
	name = "chief engineer's bunny ears"
	desc = "Green and white bunny ears attached to a headband. Just keep them away from the supermatter."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "ce"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//MEDICAL

/obj/item/clothing/head/playbunnyears/doctor
	name = "medical bunny ears"
	desc = "White and blue bunny ears attached to a headband. Certainly cuter than a head mirror."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "doctor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/paramedic
	name = "paramedic's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. Marks you clearly as a bunny first responder, allowing you a high degree of respect and deference… yeah right."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "paramedic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chemist
	name = "chemist's bunny ears"
	desc = "White and orange bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "chem"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/pathologist
	name = "pathologist's bunny ears"
	desc = "White and green bunny ears attached to a headband. This is not proper PPE gear."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "virologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/coroner
	name = "coroner's bunny ears"
	desc = "Black and white bunny ears attached to a headband. Please don't wear this to a funeral."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "coroner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cmo
	name = "chief medical officer's bunny ears"
	desc = "White and blue bunny ears attached to a headband. A headband that commands respect from the entire medical team."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "cmo"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SCIENCE

/obj/item/clothing/head/playbunnyears/scientist
	name = "scientist's bunny ears"
	desc = "Purple and white bunny ears attached to a headband. Completes the look for lagomorphic studies."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "science"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/roboticist
	name = "roboticist's bunny ears"
	desc = "Black and red bunny ears attached to a headband. Installed with servos to imitate the movement of real bunny ears."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "roboticist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/geneticist
	name = "geneticist's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. For when you have no bunnies to splice your genes with."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "genetics"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/rd
	name = "research director's bunny ears"
	desc = "Purple and black bunny ears attached to a headband. Large amounts of funding went into creating a piece of headgear capable of increasing the wearers height, this is what was produced."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "rd"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SECURITY

/obj/item/clothing/head/playbunnyears/security
	name = "security bunny ears"
	desc = "Red and black bunny ears attached to a headband. The band is made out of hardened steel."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "sec"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/security/assistant
	name = "security assistant's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Snugly fit, to keep it attatched during long distance tackles."
	icon_state = "sec_assistant"

/obj/item/clothing/head/playbunnyears/warden
	name = "warden's bunny ears"
	desc = "Red and white bunny ears attached to a headband. Keeps the hair out of the face when checking on cameras."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "warden"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/brig_phys
	name = "brig physician's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Whoever's wearing these is surely a professional... right?"
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "brig_phys"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/detective
	name = "detective's bunny ears"
	desc = "Brown bunny ears attached to a headband. Big ears for listening to calls from hysteric dames."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "detective"
	post_init_icon_state = null
	armor_type = /datum/armor/fedora_det_hat
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/detective/noir
	name = "noir detective's bunny ears"
	desc = "Black bunny ears attached to a white headband. Big ears for listening to calls from hysteric dames. In glorious black and white!"
	icon_state = "detective_noir"

/obj/item/clothing/head/playbunnyears/prisoner
	name = "prisoner's bunny ears"
	desc = "Black and orange bunny ears attached to a headband. This outfit was long ago outlawed under the space geneva convention for being a “cruel and unusual punishment”."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "prisoner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/hos
	name = "head of security's bunny ears"
	desc = "Red and gold bunny ears attached to a headband. Shows your authority over all bunny officers."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "hos"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/hats_hos
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SERVICE

/obj/item/clothing/head/playbunnyears/hop
	name = "head of personnel's bunny ears"
	desc = "A pair of muted blue bunny ears attached to a headband. The preferred color of bunnycrats everywhere."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "hop"
	post_init_icon_state = null
	armor_type = /datum/armor/hats_hopcap
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/janitor
	name = "janitor's bunny ears"
	desc = "A pair of purple bunny ears attached to a headband. Kept meticulously clean."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "janitor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bartender
	name = "bartender's bunny ears"
	desc = "A pair of classy black and white bunny ears attached to a headband. They smell faintly of alchohol."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "bar"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/head/playbunnyears/cook
	name = "cook's bunny ears"
	desc = "A pair of white and red bunny ears attached to a headband. Helps keep hair out of the food."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "chef"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/botanist
	name = "botanist's bunny ears"
	desc = "A pair of green and blue bunny ears attached to a headband. Good for keeping the sweat out of your eyes during long days on the farm."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "botany"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/clown
	name = "clown's bunny ears"
	desc = "A pair of orange and pink bunny ears. They even squeak."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "clown"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mime
	name = "mime's bunny ears"
	desc = "Red and black bunny ears attached to a headband. Great for street performers sick of the standard beret."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "mime"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chaplain
	name = "chaplain's bunny ears"
	desc = "A pair of black and white bunny ears attached to a headband. Worn in worship of The Gardener of Carota."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "chaplain"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_red
	name = "curator's red bunny ears"
	desc = "A pair of red and beige bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "curator_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_green
	name = "curator's green bunny ears"
	desc = "A pair of green and black bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "curator_green"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_teal
	name = "curator's teal bunny ears"
	desc = "A pair of teal bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "curator_teal"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_black
	name = "lawyer's black bunny ears"
	desc = "A pair of black bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "lawyer_black"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_blue
	name = "lawyer's blue bunny ears"
	desc = "A pair of blue and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "lawyer_blue"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_red
	name = "lawyer's red bunny ears"
	desc = "A pair of red and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "lawyer_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_good
	name = "good lawyer's bunny ears"
	desc = "A pair of beige and blue bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "lawyer_good"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/psychologist
	name = "psychologist's bunny ears"
	desc = "A pair of black bunny ears. And how do they make you feel?"
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "psychologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

