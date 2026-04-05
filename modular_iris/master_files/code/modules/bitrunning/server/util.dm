/obj/machinery/quantum_server/get_random_domain_id()
	var/static/list/valid_domains = null
	if(!valid_domains)
		valid_domains = list()
		for(var/datum/lazy_template/virtual_domain/available as anything in subtypesof(/datum/lazy_template/virtual_domain))
			if(!(initial(available.domain_flags) & DOMAIN_TEST_ONLY))
				valid_domains[available] = 5

	var/list/available_domains = valid_domains.Copy()
	for(var/datum/lazy_template/virtual_domain/domain as anything in available_domains)
		if(initial(domain.cost) > points)
			available_domains -= domain

	var/datum/lazy_template/virtual_domain/selected = pick_weight(available_domains)
	if(valid_domains[selected] > 1)
		if(is_ready && !generated_domain && !length(avatar_connection_refs)) // The checks are only done after us, weird. So do em again here
			valid_domains[selected]--

	domain_randomized = TRUE
	return initial(selected.key)
