// Sec overrides can be found on
// modular_nova\modules\sec_haul\code\security_clothing\sec_clothing_overrides.dm

/obj/item/clothing/under/rank/security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/warden/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/*
*	SECURITY OFFICER
*/

//Redsec uniform with black pants
/datum/atom_skin/security_uniform_black
	abstract_type = /datum/atom_skin/security_uniform_black

/datum/atom_skin/security_uniform_black/black
	preview_name = "Black Variant"
	new_icon_state = "security_black"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

/datum/atom_skin/security_uniform_black/white
	preview_name = "White Variant"
	new_icon_state = "security_white"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/nova/officer/black
	icon_state = "security_black"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/officer/black/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_uniform_black)

//Bluesec uniform
/datum/atom_skin/security_uniform_blue
	abstract_type = /datum/atom_skin/security_uniform_blue

/datum/atom_skin/security_uniform_blue/black
	preview_name = "Black Variant"
	new_icon_state = "security_blue_black"

/datum/atom_skin/security_uniform_blue/blue
	preview_name = "Blue Variant"
	new_icon_state = "security_blue"

/datum/atom_skin/security_uniform_blue/white
	preview_name = "White Variant"
	new_icon_state = "security_white"

/obj/item/clothing/under/rank/security/nova/officer
	name = "security uniform"
	desc = "A tactical security uniform for officers complete with Nanotrasen belt buckle."
	icon_state = "security_blue_black"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/officer/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/under/rank/security/nova/officer) // Don't add this on subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_uniform_blue)

/obj/item/clothing/under/rank/security/nova/formal
	name = "security formal suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "formal"

/obj/item/clothing/under/rank/security/nova/formal/blue
	icon_state = "formal_blue"

/datum/atom_skin/security_jumpskirt
	abstract_type = /datum/atom_skin/security_jumpskirt

/datum/atom_skin/security_jumpskirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "jumpskirt_blue"

/datum/atom_skin/security_jumpskirt/black
	preview_name = "Black Variant"
	new_icon_state = "jumpskirt_black"

/obj/item/clothing/under/rank/security/nova/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" security uniform with the legs replaced by a skirt."
	icon_state = "jumpskirt_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/nova/skirt/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/under/rank/security/nova/skirt) // Don't add this to the plain subtype
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jumpskirt)

/datum/atom_skin/security_plain_skirt
	abstract_type = /datum/atom_skin/security_plain_skirt

/datum/atom_skin/security_plain_skirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "plain_skirt_blue"

/datum/atom_skin/security_plain_skirt/black
	preview_name = "Black Variant"
	new_icon_state = "plain_skirt_black"

/obj/item/clothing/under/rank/security/nova/skirt/plain
	name = "security plain skirt"
	desc = "Plain-shirted uniform commonly worn by Nanotrasen officers, attached with a skirt."
	icon_state = "plain_skirt_blue"

/obj/item/clothing/under/rank/security/nova/skirt/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_plain_skirt)

/datum/atom_skin/security_miniskirt
	abstract_type = /datum/atom_skin/security_miniskirt

/datum/atom_skin/security_miniskirt/red
	preview_name = "Red Variant"
	new_icon_state = "miniskirt"

/datum/atom_skin/security_miniskirt/black
	preview_name = "Black Variant"
	new_icon_state = "miniskirt_black"

/obj/item/clothing/under/rank/security/nova/skirt/mini
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon_state = "miniskirt"

/obj/item/clothing/under/rank/security/nova/skirt/mini/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/under/rank/security/nova/skirt/mini) // No doubling up with subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_miniskirt)

/datum/atom_skin/security_miniskirt_blue
	abstract_type = /datum/atom_skin/security_miniskirt_blue

/datum/atom_skin/security_miniskirt_blue/blue
	preview_name = "Blue Variant"
	new_icon_state = "miniskirt_blue"

/datum/atom_skin/security_miniskirt_blue/black
	preview_name = "Black Variant"
	new_icon_state = "miniskirt_blue_black"

/obj/item/clothing/under/rank/security/nova/skirt/mini/blue
	icon_state = "miniskirt_blue"

/obj/item/clothing/under/rank/security/nova/skirt/mini/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_miniskirt_blue)

/obj/item/clothing/under/rank/security/nova/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/utility/blue
	icon_state = "util_sec_blue"

/obj/item/clothing/under/rank/security/nova/dress
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	icon_state = "security_skirt"
	alt_covers_chest = FALSE
	can_reskin = FALSE

/obj/item/clothing/under/rank/security/nova/dress/blue
	icon_state = "security_skirt_blue"

/datum/atom_skin/security_trousers
	abstract_type = /datum/atom_skin/security_trousers

/datum/atom_skin/security_trousers/red
	preview_name = "Red Variant"
	new_icon_state = "workpants"

/datum/atom_skin/security_trousers/white
	preview_name = "White Variant"
	new_icon_state = "workpants_white"

/obj/item/clothing/under/rank/security/nova/trousers
	name = "security trousers"
	desc = "Some \"combat\" trousers. Probably should pair it with a vest for safety."
	icon_state = "workpants"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/nova/trousers/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/under/rank/security/nova/trousers) // No doubling up with subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_trousers)

/datum/atom_skin/security_trousers/blue
	abstract_type = /datum/atom_skin/security_trousers/blue

/datum/atom_skin/security_trousers/blue/blue
	preview_name = "Blue Variant"
	new_icon_state = "workpants_blue"

/datum/atom_skin/security_trousers/blue/white
	preview_name = "White Variant"
	new_icon_state = "workpants_white"

/obj/item/clothing/under/rank/security/nova/trousers/blue
	icon_state = "workpants_blue"

/obj/item/clothing/under/rank/security/nova/trousers/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_trousers/blue)

/datum/atom_skin/security_shorts
	abstract_type = /datum/atom_skin/security_shorts

/datum/atom_skin/security_shorts/red_short
	preview_name = "Red Variant, Short"
	new_icon_state = "workshorts"

/datum/atom_skin/security_shorts/red_short_short
	preview_name = "Red Variant, Short Short"
	new_icon_state = "workshorts_short"

/datum/atom_skin/security_shorts/white_short
	preview_name = "White Variant, Short"
	new_icon_state = "workshorts_white"

/datum/atom_skin/security_shorts/white_short_short
	preview_name = "White Variant, Short Short"
	new_icon_state = "workshorts_white_short"

/obj/item/clothing/under/rank/security/nova/trousers/shorts
	name = "security shorts"
	desc = "Some \"combat\" shorts. Probably should pair it with a vest for safety."
	icon_state = "workshorts"

/obj/item/clothing/under/rank/security/nova/trousers/shorts/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/under/rank/security/nova/trousers/shorts) // No doubling up with subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_shorts)

/datum/atom_skin/security_shorts/blue
	abstract_type = /datum/atom_skin/security_shorts/blue

/datum/atom_skin/security_shorts/blue/blue_short
	preview_name = "Blue Variant, Short"
	new_icon_state = "workshorts_blue"

/datum/atom_skin/security_shorts/blue/blue_short_short
	preview_name = "Blue Variant, Short Short"
	new_icon_state = "workshorts_blue_short"

/datum/atom_skin/security_shorts/blue/white_short
	preview_name = "White Variant, Short"
	new_icon_state = "workshorts_white"

/datum/atom_skin/security_shorts/blue/white_short_short
	preview_name = "White Variant, Short Short"
	new_icon_state = "workshorts_white_short"

/obj/item/clothing/under/rank/security/nova/trousers/shorts/blue
	icon_state = "workshorts_blue"

/obj/item/clothing/under/rank/security/nova/trousers/shorts/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_shorts/blue)

/obj/item/clothing/under/rank/security/nova/turtleneck
	name = "security turtleneck"
	desc = "Turtleneck sweater commonly worn by trained Officers, attached with pants."
	icon_state = "secturtleneck"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/nova/turtleneck/blue
	icon_state = "secturtleneck_blue"

/*
*	WARDEN
*/

/obj/item/clothing/under/rank/security/warden/nova
	icon_state = "warden_black"

/obj/item/clothing/under/rank/security/warden/nova/blue
	icon_state = "warden_blue_black"

/obj/item/clothing/under/rank/security/warden/nova/suit
	name = "warden's suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "formal_warden"

/obj/item/clothing/under/rank/security/warden/nova/suit/blue
	icon_state = "formal_warden_blue"

/*
*	HEAD OF SECURITY
*/

/obj/item/clothing/under/rank/security/head_of_security/nova
	icon_state = "hos_black"

/obj/item/clothing/under/rank/security/head_of_security/nova/blue
	icon_state = "hos_blue_black"

/obj/item/clothing/under/rank/security/head_of_security/nova/formal
	name = "head of security's formal suit"
	desc = "A security suit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "formal_hos"

/obj/item/clothing/under/rank/security/head_of_security/nova/formal/blue
	icon_state = "formal_hos_blue"

/obj/item/clothing/under/rank/security/head_of_security/nova/imperial //Rank pins of the Grand General
	desc = "A tar black naval suit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"

/obj/item/clothing/under/rank/security/head_of_security/nova/parade
	name = "head of security's parade uniform"
	desc = "A male head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_male_blue"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/nova/parade/female
	name = "head of security's formal uniform"
	desc = "A female head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_fem_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/head_of_security/nova/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt_blue"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/nova/alt/skirt
	name = "head of security's turtleneck skirt"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with a tactical skirt."
	icon_state = "hosalt_skirt_blue"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/*
*	SYNDICATE
*/

/obj/item/clothing/under/rank/security/nova/utility/syndicate
	armor_type = /datum/armor/clothing_under/sec_syndicate
	has_sensor = NO_SENSORS

/datum/armor/clothing_under/sec_syndicate
	melee = 10
	fire = 50
	acid = 40
