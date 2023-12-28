// Pollution vars
/datum/chemical_reaction
	/// If defined, it'll emit that pollutant on reaction
	var/pollutant_type
	/// How much amount per volume of the pollutant shall we emit if `pollutant_type` is defined
	var/pollutant_amount = 1
