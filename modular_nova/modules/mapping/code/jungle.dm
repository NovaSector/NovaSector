// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!

/// Surface ///
/datum/map_template/ruin/jungle
	ruin_type = ZTRAIT_JUNGLE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/forestplanet/outdoors/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle/luna
	id = "surface_luna"
	suffix = "surface_luna.dmm"
	name = "JungleSurface-Ruin LUNA"
	description = "The dream of a dead dreamer."
	cost = 0
	always_place = TRUE

/datum/map_template/ruin/jungle/blooddraw
	id = "surface_blooddraw"
	suffix = "surface_blooddraw.dmm"
	name = "JungleSurface-Ruin Bloodworking Site"
	description = "For some asinine reason, a lot of blood donor clinics closed when cloning was outlawed. This is one of those."

/datum/map_template/ruin/jungle/fountain
	name = "JungleSurface-Ruin Fountain Hall"
	id = "jungle_fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"

/// Caves ///
/datum/map_template/ruin/jungle_cave
	ruin_type = ZTRAIT_JUNGLE_CAVE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/forestplanet/outdoors/unexplored/deep
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle_cave/trilogy_research
	id = "caves_trilogy_research"
	suffix = "caves_trilogy_research.dmm"
	name = "JungleCave-Ruin Trilogy (Research Department)"
	description = "We tried making millions; didn't quite work out. Something else had better marketshare."
