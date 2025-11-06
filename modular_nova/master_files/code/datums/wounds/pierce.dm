//Reduce bleed rate by a factor of 2/3
/datum/wound/pierce/bleed/moderate/New()
	initial_flow = round(initial_flow * (2/3), 0.01)
	return ..()

//Reduce bleed rate by a factor of 3/4
/datum/wound/pierce/bleed/severe/New()
	initial_flow = round(initial_flow * (3/4), 0.01)
	return ..()

//Reduce bleed rate by a factor of 3/4
/datum/wound/pierce/bleed/critical/New()
	initial_flow = round(initial_flow * (3/4), 0.01)
	return ..()
