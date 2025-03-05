/obj/item/airlock_painter/decal/tile/fancy
	name = "fancy tile sprayer"
	desc = "An airlock painter, reprogrammed to use a different style of paint in order to spray colors on floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed."
	desc_controls = "Alt-Click to remove the ink cartridge."
	icon_state = "tile_sprayer"
	stored_dir = 2
	stored_color = "#D4D4D432"
	stored_decal = "tile_full"
	spritesheet_type = /datum/asset/spritesheet/decals/tiles/fancy

	color_list = list(
		list("Neutral", "#D4D4D432"),
		list("Dark", "#0e0f0f"),
		list("Bar Burgundy", "#79150082"),
		list("Sec Blue", "#486091"),
		list("Cargo Brown", "#A46106"),
		list("Engi Yellow", "#EFB341"),
		list("Service Green", "#9FED58"),
		list("Med Blue", "#52B4E9"),
		list("R&D Purple", "#D381C9"),
	)
	decal_list = list(
		list("Diagonal Center", "diagonal_centre"),
		list("Diagonal Edge", "diagonal_edge"),
		list("Full Anti Corner Tile", "tile_anticorner"),
		list("Full Half Tile", "tile_half"),
		list("Full Tile", "tile_full"),
		list("Plain Siding", "siding_plain"),
		list("Plain Siding Corner", "siding_plain_corner"),
		list("Plain Siding Corner Inner", "siding_plain_corner_inner"),
		list("Plain Siding End", "siding_plain_end"),
		list("Wood Siding", "siding_wood"),
		list("Wood Siding Corner", "siding_wood_corner"),
		list("Wood Siding End", "siding_wood_end"),
	)
	nondirectional_decals = list(
		"tile_full",
		"diagonal_edge",
		"diagonal_centre",
	)

/datum/asset/spritesheet/decals/tiles/fancy
	name = "floor_tile_decals_fancy"
	painter_type = /obj/item/airlock_painter/decal/tile/fancy
