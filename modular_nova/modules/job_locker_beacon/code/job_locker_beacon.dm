/obj/item/choice_beacon/job_locker
	name = "job locker beacon"
	desc = "A beacon which summons a locker with a job's items, what more is there to tell."
	company_source = "Nanotrasen"
	var/locker_path = list()

/obj/item/choice_beacon/job_locker/generate_display_names()
	if(!locker_path)
		return
	var/locker_list = list()
	for(var/obj/structure/closet/secure_closet/path as anything in locker_path)
		locker_list[initial(path.name)] = path
	return locker_list

/obj/item/choice_beacon/job_locker/debug
	name = "debug job locker beacon"
	company_source = /obj/item/choice_beacon::company_source

/obj/item/choice_beacon/job_locker/debug/generate_display_names()
	var/locker_list = list()
	for(var/obj/structure/closet/secure_closet/path as anything in subtypesof(/obj/structure/closet/secure_closet))
		locker_list[initial(path.name)] = path
	return locker_list
