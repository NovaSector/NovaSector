/obj/item/disk/nifsoft_uploader/mil_grade/thermal
	name = "Thermal Lens"
	loaded_nifsoft = /datum/nifsoft/hud/thermal
	icon_state = "contract_mil_disk"

/datum/nifsoft/hud/thermal
	name = "Thermal Lens"
	program_desc = "A military-grade visual enhancement package, Thermal Lens is a coveted tool among underworld assassins and elite operatives. \
		Unlike traditional thermal goggles, this NIFSoft directly modifies the user's ocular systems - organic or otherwise - to perceive infrared radiation as visible light. \
		The system's nanites create temporary photonic receptors in the retina, allowing heat signatures to be seen through walls and dense materials with startling clarity. \
		Ironically, despite being completely internal, the program still requires trace external materials to function properly, typically scavenging polymers from \
		NIF-compatible eyewear during activation. This 'borrowed' material is returned intact when deactivated, leaving no forensic evidence. \
		The Lens represents cutting-edge sensory technology, normally reserved for marksmen and high-value protection details due to its exorbitant cost and strategic advantage in \
		both urban and wilderness operations."
	active_cost = 1
	eyewear_check = TRUE
	added_eyewear_traits = list(TRAIT_THERMAL_VISION)
