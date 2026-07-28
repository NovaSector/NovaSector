/mob/living/basic/deer/mining
	desc = "A common deer, used to living alongside monsters after generations on this planet."
	faction = list(FACTION_MINING)
	ai_controller = /datum/ai_controller/basic_controller/deer/mining

/datum/ai_controller/basic_controller/deer/mining
	behavior_tree_json = "modular_nova/modules/serenitystation/code/mobs/deer.bt.json"
