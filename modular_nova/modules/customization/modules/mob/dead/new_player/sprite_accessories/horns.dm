/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/horns.dmi'
	default_color = "#555555"
	genetic = TRUE
	organ_type = /obj/item/organ/horns

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.head && !wearer.wear_mask)
		return FALSE

	// Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	// Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE

	// Hide accessory if flagged to do so
	if((wearer.head?.flags_inv & HIDEHAIR || wearer.wear_mask?.flags_inv & HIDEHAIR) \
		&& !(wearer.wear_mask && wearer.wear_mask.flags_inv & SHOWSPRITEEARS))
		return TRUE

	return FALSE

/datum/sprite_accessory/horns/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/horns/angler
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

/datum/sprite_accessory/horns/uni
	name = "Uni"
	icon_state = "uni"

/datum/sprite_accessory/horns/oni
	name = "Oni"
	icon_state = "oni"

/datum/sprite_accessory/horns/oni_large
	name = "Oni (Large)"
	icon_state = "oni_large"

/datum/sprite_accessory/horns/big
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/horns_big.dmi'

/datum/sprite_accessory/horns/big/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/horns/big/wideantlers
	name = "Antlers (Palmated)"
	icon_state = "wideantlers"

/datum/sprite_accessory/horns/big/impala
	name = "Impala"
	icon_state = "impala"

/datum/sprite_accessory/horns/big/bigimpala
	name = "Impala (big)"
	icon_state = "bigimpala"

/datum/sprite_accessory/horns/big/paintedpoints
	name = "Painted Points"
	icon_state = "paintedpoints"

/datum/sprite_accessory/horns/big/whoshorns
	name = "Who's Horns"
	icon_state = "whoshorns"

/datum/sprite_accessory/horns/big/highrisehorns
	name = "High-rise Horns"
	icon_state = "highrisehorns"

/datum/sprite_accessory/horns/broken
	name = "Broken"
	icon_state = "broken"

/datum/sprite_accessory/horns/broken_right
	name = "Broken(right)"
	icon_state = "rbroken"

/datum/sprite_accessory/horns/broken_left
	name = "Broken(left)"
	icon_state = "lbroken"

/datum/sprite_accessory/horns/dragon
	name = "Dragon"
	icon_state = "dragon"

/datum/sprite_accessory/horns/lifted
	name = "Lifted"
	icon_state = "lifted"

/datum/sprite_accessory/horns/curly
	name = "Curly"
	icon_state = "newcurly"

/datum/sprite_accessory/horns/upwards
	name = "Upwards"
	icon_state = "upwardshorns"

/datum/sprite_accessory/horns/sideswept
	name = "Side swept back"
	icon_state = "sideswept"

/datum/sprite_accessory/horns/crippledbull
	name = "Crippled Bull"
	icon_state = "crippledbull"

/datum/sprite_accessory/horns/ticketrack
	name = "Ticket Rack"
	icon_state = "ticketrack"

/datum/sprite_accessory/horns/hopefulhorns
	name = "Hopeful Horns"
	icon_state = "hopefulhorns"

/datum/sprite_accessory/horns/broadcurls
	name = "Broad Curls"
	icon_state = "broadcurls"

/datum/sprite_accessory/horns/antenna_fuzzball_v2
	name = "Fuzzball Antenna"
	icon_state = "antenna_fuzzballv2"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/horns/setaceous
	name = "Setaceous Antenna"
	icon_state = "setaceous"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/horns/setaceousm
	name = "Medium Setaceous Antenna"
	icon_state = "setaceousm"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/horns/geniculate
	name = "Geniculate Antenna"
	icon_state = "geniculate"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/horns/moogle_pom
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/moogle_pom.dmi'
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/horns/moogle_pom/small_front
	name = "Moogle Pom (Small, Front)"
	icon_state = "mpom1"

/datum/sprite_accessory/horns/moogle_pom/small_back
	name = "Moogle Pom (Small, Back)"
	icon_state = "mpom1alt"

/datum/sprite_accessory/horns/moogle_pom/medium_front
	name = "Moogle Pom (Medium, Front)"
	icon_state = "mpom2"

/datum/sprite_accessory/horns/moogle_pom/medium_back
	name = "Moogle Pom (Medium, Back)"
	icon_state = "mpom2alt"

/datum/sprite_accessory/horns/moogle_pom/large_front
	name = "Moogle Pom (Large, Front)"
	icon_state = "mpom3"

/datum/sprite_accessory/horns/moogle_pom/large_back
	name = "Moogle Pom (Large, Back)"
	icon_state = "mpom3alt"

