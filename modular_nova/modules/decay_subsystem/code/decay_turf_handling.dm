/turf/closed/wall
	flags_1 = CAN_BE_DIRTY_1 // Allow walls to be dirty at round start

/turf/open/floor
	// Add CAN_DECAY_BREAK_1 flag to all floors by default - below we individually remove it from tiles that shouldn't break
	turf_flags = IS_SOLID | CAN_DECAY_BREAK_1

/turf/open/floor/plating
	turf_flags = IS_SOLID // No breaking plating (Duh)

/turf/open/floor/glass
	turf_flags = IS_SOLID // No breaking glass (doesn't leave plating behind)

/turf/open/floor/tram
	turf_flags = IS_SOLID // No breaking the irreplacable Tram Line
