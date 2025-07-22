/obj/item/melee/baton/security/stunsword
	name = "\improper 'Volta' stun sword"
	desc = "A special modification reserved only for the most important of security personnel aboard Nanotrasen stations. It's a sword. It stuns. What more could you want?"
	icon = 'modular_nova/modules/stunsword/stunsword_item.dmi'
	icon_state = "stunsword"
	inhand_icon_state = "stunsword"
	base_icon_state = "stunsword"
	lefthand_file = 'modular_nova/modules/stunsword/stunsword_left.dmi'
	righthand_file = 'modular_nova/modules/stunsword/stunsword_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	force = 15
	throwforce = 10
	wound_bonus = 0
	exposed_wound_bonus = 15
	additional_stun_armour_penetration = 30
	convertible = FALSE
	tip_changes_color = FALSE

	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = "stunsword",
		"Energy Stunsword" = "stunsword_energy",
	)
	unique_reskin_changes_inhand = TRUE
	unique_reskin_changes_base_icon_state = TRUE

/obj/item/melee/baton/security/stunsword/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high
