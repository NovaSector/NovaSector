/datum/loadout_item/under/jumpsuit/donator
	abstract_type = /datum/loadout_item/under/jumpsuit/donator
	donator_only = TRUE

/datum/loadout_item/under/jumpsuit/donator/enclavesergeant
	name = "Enclave - Sergeant"
	item_path = /obj/item/clothing/under/syndicate/nova/enclave
	group = "Costumes"

/datum/loadout_item/under/jumpsuit/donator/enclaveofficer
	name = "Enclave - Officer"
	item_path = /obj/item/clothing/under/syndicate/nova/enclave/officer
	group = "Costumes"

/datum/loadout_item/under/jumpsuit/donator/blondie
	name = "Blonde Cowboy Uniform"
	item_path = /obj/item/clothing/under/rank/security/detective/cowboy/armorless
	group = "Costumes"

/datum/loadout_item/under/donator
	abstract_type = /datum/loadout_item/under/donator
	donator_only = TRUE

/datum/loadout_item/under/donator/captain_black
	name = "Captain's Black Uniform"
	item_path = /obj/item/clothing/under/rank/captain/nova/black
	restricted_roles = list(JOB_CAPTAIN)
	group = "Job-Locked"
