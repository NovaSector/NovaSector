// LOW COST
/datum/uplink_item/implants/tools_nif
	name = "Grimoire Opera NIFSoft"
	desc = "A specialized NIFSoft for technicians, creating nanite-based tools on demand. Includes an omni-drill, welding tool, multitool, \
			wirebrush, and door seal. Perfect for covert operations requiring specialized equipment without carrying physical tools."
	item = /obj/item/disk/nifsoft_uploader/summoner/tools
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/implants/surgery_nif
	name = "Grimoire Asclepius NIFSoft"
	desc = "An emergency surgical NIFSoft containing a full set of nanite-based medical tools. Includes scalpels, retractors, saws, and analyzers. \
			Originally developed for Marsian EMTs operating in remote red-desert conditions. Ideal when proper medical facilities are unavailable."
	item = /obj/item/disk/nifsoft_uploader/job/summoner/surgery
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS


// MEDIUM COST
/datum/uplink_item/implants/thermal_nif
	name = "Thermal Lens NIFSoft"
	desc = "A military-grade visual enhancement package that modifies the user's ocular systems to perceive infrared radiation as visible light. \
			Allows heat signatures to be seen through walls and dense materials with startling clarity. Requires compatible eyewear to activate."
	item = /obj/item/disk/nifsoft_uploader/mil_grade/thermal
	cost = /datum/uplink_item/medium_cost::cost
	purchasable_from = UPLINK_TRAITORS


// HIGH COST
/datum/uplink_item/implants/blood_steal_nif
	name = "Blood Steal NIFSoft"
	desc = "A combat-oriented nanite package that transforms the user's hands into deadly weapons. Allows absorption of blood through kinetic force \
			and creates small shockwaves to repel targets. Particularly effective for synthetics, though organics can use it at their own risk. \
			Side effects may include tissue necrosis and severe psychosis for organic users."
	item = /obj/item/disk/nifsoft_uploader/mil_grade/blood_steal
	cost = /datum/uplink_item/high_cost::cost
	purchasable_from = UPLINK_TRAITORS
