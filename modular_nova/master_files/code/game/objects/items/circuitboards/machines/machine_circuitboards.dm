/obj/item/circuitboard/machine/skill_station
	var/static/list/skillsofts_name_paths = list(
		/obj/machinery/skill_station = "glass",
		/obj/machinery/skill_station/plasmaglass = "plasmaglass",
	)
	needs_anchored = FALSE
	var/is_special_type = FALSE

/obj/item/circuitboard/machine/skill_station/apply_default_parts(obj/machinery/skill_station/skill_station)
	build_path = skill_station.base_build_path
	if(!skillsofts_name_paths.Find(build_path))
		name = "[initial(skill_station.name)]" //if it's a unique type, give it a unique name.
		is_special_type = TRUE
	return ..()

/obj/item/circuitboard/machine/skill_station/screwdriver_act(mob/living/user, obj/item/tool)
	if (is_special_type)
		return FALSE
	var/position = skillsofts_name_paths.Find(build_path, skillsofts_name_paths)
	position = (position == length(skillsofts_name_paths)) ? 1 : (position + 1)
	build_path = skillsofts_name_paths[position]
	to_chat(user, span_notice("You register [skillsofts_name_paths[build_path]] chamber material with the board."))
	return TRUE

/obj/item/circuitboard/machine/skill_station/examine(mob/user)
	. = ..()
	if(is_special_type)
		return
	. += span_info("[src] is registered for [skillsofts_name_paths[build_path]] chamber material. You can use a screwdriver to reconfigure it.")
