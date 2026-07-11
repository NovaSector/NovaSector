/// A deathrattle group subtype - originally only rigged for those who die in the Lavaland or Icemoon Wastes.
/// For a more forgiving experience, blacklists station areas for deathrattling. Triggers in every other area.
/datum/deathrattle_group/lavaland
	area_list_mode = DEATHRATTLE_AREA_BLACKLIST
	area_list = list(
		/area/station,
		/area/ruin/space/has_grav/nova/des_two,
	)
