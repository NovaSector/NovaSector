// Below defines copied from the original implant_deathrattle.dm, at code/game/objects/items/implants/implant_deathrattle.dm ...
/// This deathrattle group does not care about the area someone dies in.
#define DEATHRATTLE_AREA_NOLIST		0
/// This deathrattle group uses its `area_list` as a blacklist: if someone dies in these areas, they DO NOT cause an alert.
#define DEATHRATTLE_AREA_BLACKLIST	1
/// This deathrattle group uses its `area_list` as a whitelist: if someone dies in these areas, they DO cause an alert.
#define DEATHRATTLE_AREA_WHITELIST	2

/// A deathrattle group subtype - originally only rigged for those who die in the Lavaland or Icemoon Wastes.
/// For a more forgiving experience, blacklists station areas for deathrattling. Triggers in every other area.
/datum/deathrattle_group/lavaland
	area_list_mode = DEATHRATTLE_AREA_BLACKLIST
	area_list = list(
		/area/station,
	)

#undef DEATHRATTLE_AREA_NOLIST
#undef DEATHRATTLE_AREA_BLACKLIST
#undef DEATHRATTLE_AREA_WHITELIST
