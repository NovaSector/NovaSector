/obj/item/storage/box/buckshotroulette
	name = "box of spent shotgun shells"
	desc = "A box full of lethal shotgun shells, well they would be lethal if they were full, these ones are spent."
	icon_state = "secbox"
	illustration = null

/obj/item/storage/box/buckshotroulette/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/buckshot/spent(src)

/obj/item/ammo_casing/shotgun/buckshot/spent
	name = "spent buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = null

/obj/item/ammo_box/magazine/internal/shot/buckshotroulette
	name = "buckshotroulette shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/spent
	max_ammo = 6

/obj/item/gun/ballistic/shotgun/buckshotroulette
	name = "Buckshot roulette shotgun"
	desc = "Relic of ancient times, this shotgun seems to have an unremovable firing pin, used by complete maniacs in the deepest and darkest places. Start by pointing it at your mouth."
	icon_state = "riotshotgun"
	inhand_icon_state = "shotgun"
	fire_delay = 8
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/buckshotroulette
	sawn_desc = "This one doesn't fix itself."
	can_be_sawn_off = TRUE
	pin = /obj/item/firing_pin/permit_pin/buckshotroulette

/obj/item/firing_pin/permit_pin/buckshotroulette //no cheating allowed
	pin_removable = FALSE
