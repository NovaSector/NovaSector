//Reduce bleed rate by a factor of 2/3
/datum/wound/slash/flesh/New()
	initial_flow = round(initial_flow * (2/3), 0.01)
	minimum_flow = round(minimum_flow * (2/3), 0.01)
	return ..()

/datum/wound/slash/flesh/severe/New()
	initial_flow = round(initial_flow * 0.69, 0.01)
	minimum_flow = round(minimum_flow * 0.638, 0.01)
	return ..()
	
//Reduce bleed rate by a factor of 3/4
/datum/wound/slash/flesh/critical/New()
	initial_flow = round(initial_flow * (3/4), 0.01)
	minimum_flow = round(minimum_flow * (3/4), 0.01)
	return ..()
