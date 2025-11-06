/datum/blood_type/haemocyanin
	name = "Haemocyanin"
	color = "#3399FF"
	desc = "This oxygen-carrying macromolecule is formed using copper instead of iron (giving it its blue color), and has similar efficiency to haemoglobin in colder temperatures."
	restoration_chem = /datum/reagent/copper
	compatible_types = list(
		/datum/blood_type/haemocyanin,
	)

/datum/blood_type/chlorocruorin
	name = "Chlorocruorin"
	color = "#9FF73B"
	desc = "Chlorocruorin molecules are massive relative to other oxygen carriers and get their green color from the presence of an abnormal heme group."
	compatible_types = list(
		/datum/blood_type/chlorocruorin,
	)

/datum/blood_type/hemerythrin
	name = "Hemerythrin"
	color = "#C978DD"
	desc  = "The pink hemerythrin macromolecules actually bind to oxygen by creating a hydroperoxide, a unique mechanism for blood oxygen."
	compatible_types = list(
		/datum/blood_type/hemerythrin,
	)

/datum/blood_type/pinnaglobin
	name = "Pinnaglobin"
	color = "#CDC020"
	restoration_chem = /datum/reagent/manganese
	desc = "Most similar to haemocyanin, pinnaglobin possesses manganese atoms in place of copper, giving it a unique color."
	compatible_types = list(
		/datum/blood_type/pinnaglobin,
	)

/datum/blood_type/exotic
	name = "Exotic"
	color = "#333333"
	restoration_chem = /datum/reagent/sulfur
	compatible_types = list(
		/datum/blood_type/exotic,
	)
	desc = "This blood color does not appear to exist naturally in nature, but with exposure to sulfur or some other genetic engineering or corruption it might be possible."
