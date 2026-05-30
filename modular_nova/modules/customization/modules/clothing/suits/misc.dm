/obj/item/clothing/suit/wornshirt
	name = "wrinkled shirt"
	desc = "A worn out (or perhaps just baggy), curiously comfortable t-shirt."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "wornshirt"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/dutchjacketsr
	name = "western jacket"
	desc = "Botanists screaming of mangos have been rumored to wear this."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "dutchjacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE


/obj/item/clothing/suit/toggle/trackjacket
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "track jacket"
	desc = "A black jacket with blue stripes for the athletic. It is also popular among russian delinquents."
	icon_state = "trackjacket"
	toggle_noun = "zipper"

/obj/item/clothing/suit/frenchtrench
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "blue trenchcoat"
	icon_state = "frenchtrench"
	desc = "There's a certain timeless feeling to this coat, like it was once worn by a romantic, broken through his travels, from a schemer who hunted injustice to a traveller, however it arrived in your hands? Who knows?"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/victoriantailcoatbutler
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "caretaker tailcoat"
	desc = "You've ALWAYS been the Caretaker. I ought to know, I've ALWAYS been here."
	icon_state = "victorian_tailcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/koreacoat
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "eastern winter coat"
	desc = "War makes people cold, not just on the inside, but on the outside as well... luckily this coat's not seen any hardships like that, and is actually quite warm!"
	icon_state = "chi_korea_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/modernwintercoatthing
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "modern winter coat"
	desc = "Warm and comfy, the inner fur seems to be removable, not this one though, someone's sewn it in and left the buttons!"
	icon_state = "modern_winter"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/toggle/jacket/nova/cardigan
	name = "cardigan"
	desc = "It's like, half a jacket."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/cardigan"
	post_init_icon_state = "cardigan"
	greyscale_config = /datum/greyscale_config/cardigan
	greyscale_config_worn = /datum/greyscale_config/cardigan/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	toggle_noun = "button"

/obj/item/clothing/suit/jacket/discoblazer //armorless version of /obj/item/clothing/suit/jacket/det_suit/disco
	name = "disco ass blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"

/obj/item/clothing/suit/kimjacket
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "aerostatic bomber jacket"
	desc = "A jacket once worn by the Air Force during the Antecentennial Revolution, there are quite a few pockets on the inside, mostly for storing notebooks and compasses."
	icon_state = "aerostatic_bomber_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/blackfurrich
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "expensive black fur coat"
	desc = "Ever thought to yourself 'I'm a rich bitch, but I haven't GOT the Mafia Princess look?' Well thanks to the tireless work of underpaid slave labour in Space China, your dreams of looking like a bitch have been fulfilled, like a Genie with a sweatshop."
	icon_state = "expensivecoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/brownbattlecoat
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "expensive brown fur coat"
	desc = "There is nothing more valuable, nothing more sacred, look at the fur lining, it's beautiful, when you cruse through Necropolis in this thing, you're gonna be balls deep in Ash Walker snatch."
	icon_state = "battlecoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/brownfurrich
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "quartermaster fur coat"
	desc = "Cargonia, or if you're a dork, Cargoslavia has shipped out a coat for loyal quartermasters, despite accusations it's just a dyed black fur coat, it's...not, promise!"
	icon_state = "winter_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_brownfurrich

/datum/armor/suit_brownfurrich
	melee = 10
	bullet = 10

/obj/item/clothing/suit/brownfurrich/public
	name = "fur coat"
	desc = "A lavishly cosy furr coat, made with 100% recycled carbon!"

/obj/item/clothing/suit/brownfurrich/white
	name = "white fur coat"
	desc = "A lavishly cosy furr coat, made with 100% recycled carbon!"
	icon_state = "winter_coat_white"

/obj/item/clothing/suit/brownfurrich/cream
	name = "cream fur coat"
	desc = "A lavishly cosy furr coat, made with 100% recycled carbon!"
	icon_state = "winter_coat_cream"

/obj/item/clothing/suit/fallsparka
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "falls parka"
	desc = "A light brown coat with light fur lighting around the collar."
	icon_state = "fallsparka"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/british_officer
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "british officers coat"
	desc = "Whether you're commanding a colonial crusade or commanding a battalion for the British Empire, this coat will suit you."
	icon_state = "british_officer"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_british_officer

/datum/armor/suit_british_officer
	melee = 10
	bullet = 10

/obj/item/clothing/suit/modern_winter
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "modern winter coat"
	desc = "A comfy modern winter coat."
	icon_state = "modern_winter"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/woolcoat
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "wool coat"
	desc = "A fine coat made from the richest of wool."
	icon_state = "woolcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS


/obj/item/clothing/suit/gautumn
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "neo american general's coat"
	desc = "In stark contrast to the undersuit, this large and armored coat is as white as snow, perfect for the bloodstains."
	icon_state = "soldier"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_gautumn

/datum/armor/suit_gautumn
	melee = 10
	bullet = 10
	laser = 20
	energy = 20

/obj/item/clothing/suit/autumn
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "neo american officer's coat"
	desc = "In stark contrast to the undersuit, this coat is a greeny white colour, layered with slight protection against bullets and melee weapons."
	icon_state = "autumn"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_autumn

/datum/armor/suit_autumn
	melee = 10
	bullet = 10

/obj/item/clothing/suit/texas
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "white suit coat"
	desc = "A white suit coat, perfect for fat oil barons."
	icon_state = "texas"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/cossack
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "ukrainian coat"
	desc = "Hop on your horse, dawn your really fluffy hat, and strap this coat to your back."
	icon_state = "kuban_cossak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/corgisuit/en
	name = "\improper super-hero E-N suit"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "ensuit"
	supports_variations_flags = NONE

/obj/item/clothing/suit/corgisuit/en/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/corgisuit/en/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/corgisuit/en/process()
	if(prob(2))
		for(var/obj/object in orange(2,src))
			if(!object.anchored && (object.obj_flags & CONDUCTS_ELECTRICITY))
				step_towards(object,src)
		for(var/mob/living/silicon/S in orange(2,src))
			if(istype(S, /mob/living/silicon/ai)) continue
			step_towards(S,src)
		for(var/datum/species/synthetic/R in orange(2,src))
			step_towards(R,src)

/obj/item/clothing/suit/trenchbrown
	name = "brown trenchcoat"
	desc = "A brown noir-inspired coat. Looks best if you're not wearing it over a baggy t-shirt."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "brtrenchcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/trenchblack
	name = "black trenchcoat"
	desc = "A matte-black coat. Best suited for space-italians, or maybe a monochrome-cop."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "bltrenchcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/apron/chef/colorable_apron
	name = "apron"
	desc = "A basic apron."
	worn_icon = 'modular_nova/modules/GAGS/icons/suit/suit.dmi'
	worn_icon_teshari = 'modular_nova/modules/GAGS/icons/suit/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	greyscale_colors = "#ffffff"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/apron/chef/colorable_apron"
	post_init_icon_state = "apron"
	greyscale_config = /datum/greyscale_config/apron
	greyscale_config_worn = /datum/greyscale_config/apron/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/apron/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/apron/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/apron/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/apron/overalls
	greyscale_config_worn_digi = /datum/greyscale_config/overalls/worn/digi
	greyscale_config_worn_better_vox = /datum/greyscale_config/overalls/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/overalls/worn/vox

/obj/item/clothing/suit/apron/overalls/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
	)

/obj/item/clothing/suit/warm_sweater
	name = "warm sweater"
	desc = "A comfortable warm-looking sweater."
	body_parts_covered = CHEST|ARMS
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/warm_sweater"
	post_init_icon_state = "warm_sweater"
	greyscale_config = /datum/greyscale_config/warm_sweater
	greyscale_config_worn = /datum/greyscale_config/warm_sweater/worn
	greyscale_colors = "#867361"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/heart_sweater
	name = "heart sweater"
	desc = "A comfortable warm-looking sweater. It even has a heart pattern on it, how cute."
	body_parts_covered = CHEST|ARMS
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/heart_sweater"
	post_init_icon_state = "heart_sweater"
	greyscale_config = /datum/greyscale_config/heart_sweater
	greyscale_config_worn = /datum/greyscale_config/heart_sweater/worn
	greyscale_colors = "#867361#8f3a3a"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/dagger_mantle
	name = "'dagger' designer mantle"
	desc = "For their Spring 2560 collection, the designer had a lot to say about the allure of objects that \
		'seem to spring into existence without human intervention.' Made from a single piece of fabric with a seam \
		and closure in the back, this mantle is almost austere enough to disguise its origin in a Marsian garment \
		factory."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/dagger_mantle"
	post_init_icon_state = "dagger_mantle"
	greyscale_config = /datum/greyscale_config/dagger_mantle
	greyscale_config_worn = /datum/greyscale_config/dagger_mantle/worn
	greyscale_colors = "#d6f7ff"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK

/obj/item/clothing/under/pants/nova/double_skirt_dress
	name = "double skirt dress"
	desc = "A fashionable dress with two layers of skirts."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/double_skirt_dress"
	post_init_icon_state = "double_skirt_dress"
	greyscale_config = /datum/greyscale_config/double_skirt_dress
	greyscale_config_worn = /datum/greyscale_config/double_skirt_dress/worn
	greyscale_colors = "#5f5f5f#ffffff#33ccff"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suit_digi.dmi'

/obj/item/clothing/suit/nova/bridge_officer/goth
	name = "bridge officer's gothic coat"
	desc = "It's an elaborate coat, with a scarf, seeming rather gothic in nature but its style and colors show its for a \"Bridge Officer\"."
	icon_state = "bo_writer"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/apron/overalls_loneskirt
	name = "overalls-skirt"
	desc = "A set of skirted overalls, a little less good at protecting thinner clothes from the elements."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/apron/overalls_loneskirt"
	post_init_icon_state = "overalls_loneskirt"
	greyscale_config = /datum/greyscale_config/overalls_loneskirt
	greyscale_config_worn = /datum/greyscale_config/overalls_loneskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/overalls_loneskirt/worn/digi
	greyscale_colors = "#252525#CCCED1"
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "tailcoat"
	desc = "A coat usually worn by bunny themed waiters and the like."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/tailcoat"
	post_init_icon_state = "tailcoat"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/tailcoat
	greyscale_config_worn = /datum/greyscale_config/tailcoat_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/tailcoat/bartender
	name = "bartender's tailcoat"
	desc = "A coat usually worn by bunny themed bartenders. It has an interior holster for firearms and some extra padding for minor protection."
	icon_state = "/obj/item/clothing/suit/jacket/tailcoat/bartender"
	post_init_icon_state = "tailcoat_bar"
	greyscale_colors = "#39393f#ffffff"
	greyscale_config = /datum/greyscale_config/tailcoat_bar
	greyscale_config_worn = /datum/greyscale_config/tailcoat_bar_worn
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/jacket/tailcoat/bartender/Initialize(mapload) //so bartenders can use cram their shotgun inside
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate
	name = "suspicious tailcoat"
	desc = "A oddly intimidating coat usually worn by bunny themed assassins. It's reinforced with some extremely flexible lightweight alloy. How much did they pay for this?"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_syndi"
	post_init_icon_state = null
	armor_type = /datum/armor/wintercoat_syndicate
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/syndicate/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/restraints/handcuffs,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/tailcoat/magician
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_wiz"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat that seems to radiate power."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	icon_state = "tailcoat_wiz"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	inhand_icon_state = null
	flags_inv = null

/obj/item/clothing/suit/jacket/tailcoat/centcom
	name = "centcom tailcoat"
	desc = "An official coat usually worn by bunny themed executives. The inside is lined with comfortable yet tasteful bunny fluff."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_centcom"
	post_init_icon_state = null
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/british
	name = "british flag tailcoat"
	desc = "A tailcoat emblazoned with the Union Jack. Perfect attire for teatime."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_brit"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/communist
	name = "really red tailcoat"
	desc = "A red tailcoat emblazoned with a golden star. The official uniform of the Bunny Waiter Union."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_communist"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/usa
	name = "stars tailcoat"
	desc = "A vintage coat worn by the 5th bunny battalion during the Revolutionary War. Smooth-bore musket not included."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_stars"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/plasmaman
	name = "purple tailcoat"
	desc = "A purple coat that looks to be the same purple used in several plasmaman evirosuits."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_plasma"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//CAPTAIN

/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	name = "captain's tailcoat"
	desc = "A nautical coat usually worn by bunny themed captains. It’s reinforced with genetically modified armored blue rabbit fluff."
	icon_state = "captain"
	inhand_icon_state = null
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

//CARGO

/obj/item/clothing/suit/jacket/tailcoat/quartermaster
	name = "quartermaster's tailcoat"
	desc = "A fancy brown coat worn by bunny themed quartermasters. The gold accents show everyone who's in charge."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "qm"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cargo
	name = "cargo tailcoat"
	desc = "A simple brown coat worn by bunny themed cargo technicians. Significantly less stripy than the quartermasters."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "cargo_tech"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/miner
	name = "explorer tailcoat"
	desc = "An adapted explorer suit worn by bunny themed shaft miners. It has attachment points for goliath plates but comparatively little armor."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "explorer"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/hooded_explorer
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/item/clothing/suit/jacket/tailcoat/miner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/suit/jacket/tailcoat/bitrunner
	name = "bunrunner tailcoat"
	desc = "A black and gold coat worn by bunny themed cargo technicians. Open your Space Colas and let's fuckin' game!"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "bitrunner"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//ENGI

/obj/item/clothing/suit/jacket/tailcoat/engineer
	name = "engineering tailcoat"
	desc = "A high visibility tailcoat worn by bunny themed engineers. Great for working in low-light conditions."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "engi"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null

	greyscale_colors = null
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime,
	)

/obj/item/clothing/suit/jacket/tailcoat/engineer/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/utility/fire/atmos_tech_tailcoat
	name = "atmospheric technician's tailcoat"
	desc = "A heavy duty fire-tailcoat worn by bunny themed atmospheric technicians. Reinforced with asbestos weave that makes this both stylish and lung-cancer inducing."
	icon_state = "atmos"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/atmos_tech_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/atmos_tech_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

/obj/item/clothing/suit/utility/fire/ce_tailcoat
	name = "chief engineer's tailcoat"
	desc = "A heavy duty green and white coat worn by bunny themed chief engineers. Made of a three layered composite fabric that is both insulating and fireproof, it also has an open face rendering all this useless."
	icon_state = "ce"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/ce_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/ce_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

//MEDICAL

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat
	name = "medical tailcoat"
	desc = "A sterile white and blue coat worn by bunny themed doctors. Great for keeping the blood off."
	icon_state = "doctor"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/paramedic/doctor_tailcoat
	name = "paramedic's tailcoat"
	desc = "A heavy duty coat worn by bunny themed paramedics. Marked with high visibility lines for emergency operations in the dark."
	icon_state = "paramedic"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/chemist/doctor_tailcoat
	name = "chemist's tailcoat"
	desc = "A sterile white and orange coat worn by bunny themed chemists. The open chest isn't the greatest when working with dangerous substances."
	icon_state = "chem"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/virologist/doctor_tailcoat
	name = "pathologist's tailcoat"
	desc = "A sterile white and green coat worn by bunny themed pathologists. The more stylish and ineffective alternative to a biosuit."
	icon_state = "virologist"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/coroner/doctor_tailcoat
	name = "coroner's tailcoat"
	desc = "A sterile black and white coat worn by bunny themed coroners. Adorned with a skull on the back."
	icon_state = "coroner"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/cmo/doctor_tailcoat
	name = "chief medical officer's tailcoat"
	desc = "A sterile blue coat worn by bunny themed chief medical officers. The blue helps both the wearer and bloodstains stand out from other, lower ranked, and cleaner doctors."
	icon_state = "cmo"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'

//SCIENCE

/obj/item/clothing/suit/toggle/labcoat/science/doctor_tailcoat
	name = "scientist's tailcoat"
	desc = "A smart white coat worn by bunny themed scientists. Decent protection against slimes."
	icon_state = "science"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/roboticist/doctor_tailcoat
	name = "roboticist's tailcoat"
	desc = "A smart white coat with red pauldrons worn by bunny themed roboticists. Looks surprisingly good with oil stains on it."
	icon_state = "roboticist"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/toggle/labcoat/genetics/doctor_tailcoat
	name = "geneticist's tailcoat"
	desc = "A smart white and blue coat worn by bunny themed geneticists. Nearly looks like a real doctor's lab coat."
	icon_state = "genetics"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/research_director/tailcoat
	name = "research director's tailcoat"
	desc = "A smart purple coat worn by bunny themed head researchers. Created from captured abductor technology, what looks like a coat is actually an advanced hologram emitted from the pauldrons. Feels exactly like the real thing, too."
	icon_state = "rd"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//SECURITY

/obj/item/clothing/suit/armor/security_tailcoat
	name = "security tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security officers. Uses the same lightweight armor as the MK 1 vest, though obviously has lighter protection in the chest area."
	icon_state = "sec"
	inhand_icon_state = "armor"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/armor/security_tailcoat/assistant
	name = "security assistant's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security assistants. The duller color scheme denotes a lower rank on the chain of bunny command."
	icon_state = "sec_assistant"

/obj/item/clothing/suit/armor/security_tailcoat/warden
	name = "warden's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed wardens. Stylishly holds hidden flak plates."
	icon_state = "warden"

/obj/item/clothing/suit/toggle/labcoat/nova/security_medic/doctor_tailcoat
	name = "brig physician's tailcoat"
	desc = "A mostly sterile red and grey coat worn by bunny themed brig physicians. It lacks the padding of the \"standard\" security tailcoat."
	icon_state = "brig_phys"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	blood_overlay_type = "coat"


/obj/item/clothing/suit/jacket/det_suit/tailcoat
	name = "detective's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/det_suit/tailcoat/noir
	name = "noir detective's tailcoat"
	desc = "A reinforced tailcoat worn by noir bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective_noir"

/obj/item/clothing/suit/armor/hos_tailcoat
	name = "head of security's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security commanders. Enhanced with a special alloy for some extra protection and style."
	icon_state = "hos"
	inhand_icon_state = "armor"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/armor_hos
	strip_delay = 80

//SERVICE

/obj/item/clothing/suit/armor/hop_tailcoat
	name = "head of personnel's tailcoat"
	desc = "A strict looking coat usually worn by bunny themed bureaucrats. The pauldrons are sure to make people finally take you seriously."
	icon_state = "hop"
	inhand_icon_state = "armor"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/jacket/tailcoat/janitor
	name = "janitor's tailcoat"
	desc = "A clean looking coat usually worn by bunny themed janitors. The purple sleeves are a late 24th century style."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "janitor"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cook
	name = "cook's tailcoat"
	desc = "A professional white coat worn by bunny themed chefs. The red accents pair nicely with the monkey blood that often stains this."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "chef"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)

/obj/item/clothing/suit/jacket/tailcoat/botanist
	name = "botanist's tailcoat"
	desc = "A green leather coat worn by bunny themed botanists. Great for keeping the sun off your back."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "botany"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
	)

/obj/item/clothing/suit/jacket/tailcoat/clown
	name = "clown's tailcoat"
	desc = "An orange polkadot coat worn by bunny themed clowns. Shows everyone who the real ringmaster is."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "clown"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/mime
	name = "mime's tailcoat"
	desc = "A stripy sleeved black coat worn by bunny themed mimes. The red accents mimic the suspenders seen in more standard mime outfits."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "mime"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/chaplain
	name = "chaplain's tailcoat"
	desc = "A gilded black coat worn by bunny themed chaplains. Traditional vestments of the lagomorphic cults of Cairead."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "chaplain"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/nullrod,
		/obj/item/reagent_containers/cup/glass/bottle/holywater,
		/obj/item/storage/fancy/candle_box,
		/obj/item/flashlight/flare/candle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
	)

/obj/item/clothing/suit/jacket/tailcoat/curator_red
	name = "curator's red tailcoat"
	desc = "A red linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_red"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_green
	name = "curator's green tailcoat"
	desc = "A green linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_green"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_teal
	name = "curator's teal tailcoat"
	desc = "A teal linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_teal"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_black
	name = "lawyer's black tailcoat"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_black"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_blue
	name = "lawyer's blue tailcoat"
	desc = "A blue linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_blue"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_red
	name = "lawyer's red tailcoat"
	desc = "A red linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_red"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_good
	name = "good lawyer's tailcoat"
	desc = "A beige linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_good"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/psychologist
	name = "psychologist's tailcoat"
	desc = "A black linen coat worn by bunny themed psychologists. A casual open coat for making you seem approachable, maybe too casual."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "psychologist"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


