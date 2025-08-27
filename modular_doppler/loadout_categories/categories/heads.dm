/datum/loadout_category/head
	/// How many maximum of these can be chosen
	var/max_allowed = MAX_ALLOWED_EXTRA_CLOTHES

/datum/loadout_category/head/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/head/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/head/other_loadout_items = list()
	for(var/datum/loadout_item/head/other_loadout_item in all_loadout_items)
		other_loadout_items += other_loadout_item

	if(length(other_loadout_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_loadout_items[1])
	return TRUE

// Loadout items

/datum/loadout_item/head/tv_head
	name = "TV Head"
	item_path = /obj/item/clothing/head/costume/tv_head

/datum/loadout_item/head/witch
	name = "Witch Hat"
	item_path = /obj/item/clothing/head/wizard/marisa/fake

/datum/loadout_item/head/cardborg
	name = "Cardborg"
	item_path = /obj/item/clothing/head/costume/cardborg

/datum/loadout_item/head/cone
	name = "Traffic Cone"
	item_path = /obj/item/clothing/head/cone

/datum/loadout_item/head/rice_hat
	name = "Rice Hat"
	item_path = /obj/item/clothing/head/costume/rice_hat

/datum/loadout_item/head/welding
	name = "Welding Mask"
	item_path = /obj/item/clothing/head/utility/welding

/datum/loadout_item/head/soft_helmet
	name = "Soft Helmet"
	item_path = /obj/item/clothing/head/frontier_colonist_helmet

/datum/loadout_item/head/frontier_cap
	name = "Frontier Cap"
	item_path = /obj/item/clothing/head/soft/frontier_colonist

/datum/loadout_item/head/frontier_med
	name = "Frontier Medical Cap"
	item_path = /obj/item/clothing/head/soft/frontier_colonist/medic

/datum/loadout_item/head/earcap
	name = "Earcap"
	item_path = /obj/item/clothing/head/tajaran_hat

/datum/loadout_item/head/tajaran_helmet
	name = "Tajaran Flophelmet"
	item_path = /obj/item/clothing/head/helmet/tajaran

/datum/loadout_item/head/tajaran_high_helmet
	name = "Tajaran High Flophelmet"
	item_path = /obj/item/clothing/head/helmet/tajaran/contract

/datum/loadout_item/head/flattop
	name = "Flat-Top"
	item_path = /obj/item/clothing/head/vulp_hat

/datum/loadout_item/head/vulp_bandana
	name = "Vulpkanin Bandana"
	item_path = /obj/item/clothing/head/vulp_hat/headband

/datum/loadout_item/head/vulp_skirmisher
	name = "Vulpkanin Skirmisher Helmet"
	item_path = /obj/item/clothing/head/helmet/vulp

/datum/loadout_item/head/peakhat_tan
	name = "Tan Peak-Cover"
	item_path = /obj/item/clothing/head/lizard_hat

/datum/loadout_item/head/peakhat_white
	name = "White Peak-Cover"
	item_path = /obj/item/clothing/head/lizard_hat/white

/datum/loadout_item/head/lizard_helmet_tan
	name = "Tan Tizirian Helmet"
	item_path = /obj/item/clothing/head/helmet/lizard

/datum/loadout_item/head/lizard_helmet_white
	name = "White Tizirian Helmet"
	item_path = /obj/item/clothing/head/helmet/lizard/white

/datum/loadout_item/head/lizard_helmet_tan_glass
	name = "Tan Glassed Tizirian Helmet"
	item_path = /obj/item/clothing/head/helmet/lizard/glass

/datum/loadout_item/head/lizard_helmet_white_glass
	name = "White Glassed Tizirian Helmet"
	item_path = /obj/item/clothing/head/helmet/lizard/white/glass

/datum/loadout_item/head/colonial_cap
	name = "Colonial Cap"
	item_path = /obj/item/clothing/head/hats/colonial

/datum/loadout_item/head/security_colonial_cap
	name = "Security Colonial Cap"
	item_path = /obj/item/clothing/head/cap_colonysec

/datum/loadout_item/head/wrussian
	name = "Black Papakha"
	item_path = /obj/item/clothing/head/costume/papakha

/datum/loadout_item/head/wrussianw
	name = "White Papakha"
	item_path = /obj/item/clothing/head/costume/papakha/white

/datum/loadout_item/head/hair_tie
	name = "Hairtie"
	item_path = /obj/item/clothing/head/hair_tie

/datum/loadout_item/head/hair_tie_scrunchie
	name = "Hairtie (Scrunchie)"
	item_path = /obj/item/clothing/head/hair_tie/scrunchie

/datum/loadout_item/head/hair_tie_plastic
	name = "Hairtie (Plastic)"
	item_path = /obj/item/clothing/head/hair_tie/plastic_beads

/datum/loadout_item/head/bow_large
	name = "Bow (Large)"
	item_path = /obj/item/clothing/head/bow

/datum/loadout_item/head/bow_small
	name = "Bow (Small)"
	item_path = /obj/item/clothing/head/bow/small

/datum/loadout_item/head/bow_back
	name = "Bow (Back)"
	item_path = /obj/item/clothing/head/bow/back

/datum/loadout_item/head/bow_sweet
	name = "Bow (Sweet)"
	item_path = /obj/item/clothing/head/bow/sweet

/datum/loadout_item/head/maid_headband
	name = "Maid Headband"
	item_path = /obj/item/clothing/head/maid_headband

/datum/loadout_item/head/the_hood
	name = "Standalone Hood"
	item_path = /obj/item/clothing/head/standalone_hood

/datum/loadout_item/head/decker_headphones
	name = "Decker Headphones"
	item_path = /obj/item/clothing/head/costume/deckers

/datum/loadout_item/head/slim_beret
	name = "slim Beret"
	item_path = /obj/item/clothing/head/beret/doppler_command

/datum/loadout_item/head/slim_beret_light
	name = "Slim Beret (Light)"
	item_path = /obj/item/clothing/head/beret/doppler_command/light

/datum/loadout_item/head/breach_helmet
	name = "Breach Helmet"
	item_path = /obj/item/clothing/head/utility/hardhat/welding/doppler_dc

/datum/loadout_item/head/breach_helmet
	name = "Flowing Headband"
	item_path = /obj/item/clothing/head/flowing_headband
