//generic safe variant that cannot be hacked with a multitool and is easy for mappers to set up using the new vars
/obj/structure/secure_safe/unhackable
	name = "extra secure safe"
	///Items that will spawn inside this safe
	var/list/stored_items = list()
	///Code for this safe, must be 5 digits long, also has to be a string, if no code is given the safe will spawn unlocked
	var/safe_code = ""

/obj/structure/secure_safe/unhackable/Initialize(mapload)
	. = ..()
	if(safe_code)
		if(length(safe_code) != 5)
			CRASH("[src] spawned with invalid code - code must be a string exactly five digits long.")

		var/regex/invalid_characters = regex(@"[^\d]")
		if(invalid_characters.Find(safe_code))
			CRASH("[src] spawned with invalid code - code must only contain numeric characters.")

	for(var/item in stored_items)
		atom_storage.set_holdable(item)

	AddComponent(/datum/component/lockable_storage, \
		lock_code = (safe_code ? safe_code : null), \
		can_hack_open = FALSE, \
	)

/obj/structure/secure_safe/unhackable/PopulateContents()
	for(var/item in stored_items)
		new item(src)
