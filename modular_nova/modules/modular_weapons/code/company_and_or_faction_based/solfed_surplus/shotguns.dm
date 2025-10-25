/obj/item/gun/ballistic/shotgun/katyusha/jager
	name = "\improper Jäger Shotgun"
	desc = "A mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'Jäger' by the Solar Federation Marines for its versatility in clearing tight corridors, and special operations in hunting individuals."

	icon_state = "jager"
	worn_icon_state = "jager"
	inhand_icon_state = "jager"

	accepted_magazine_type = /obj/item/ammo_box/magazine/jager
	spawn_magazine_type = /obj/item/ammo_box/magazine/jager/rubbershot
	lore_blurb = "The Solar Federation Surplus 'Jäger' Magfed Shotgun is a recent release from Solar Federation Surplus. \
		and it's received a warm welcome from the Solar Federation Marines and S.W.A.T. Teams. \
		issued it in the ongoing rollout. \
		the inimitable firepower and multi-shell compatibility \
		makes the Jäger powerful, reliable, accurate, and shockingly comfortable to fire."

/obj/item/gun/ballistic/shotgun/katyusha/jager/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SOLFED)
