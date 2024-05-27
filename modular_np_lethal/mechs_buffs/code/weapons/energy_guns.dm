/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/lasershot
	equip_cooldown = 30
	name = "\improper LK-T5 \"Flare\" laser shot"
	desc = "A weapon for combat exosuits. Shoots beams of light, slow fire rate, hits almost instantly. Drains alot of power, best used at longer consistant ranges."
	icon_state = "mecha_laser"
	energy_drain = 50000
	projectile = /obj/projectile/beam/laser/hitlaser
	fire_sound = 'sound/weapons/beam_sniper.ogg'
	harmful = TRUE


/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser
	equip_cooldown = 2
	name = "\improper CH-PS \"Immolator\" laser"
	desc = "A weapon for combat exosuits. Shoots basic rapid lasers."
	icon_state = "mecha_laser"
	energy_drain = 10
	projectile = /obj/projectile/beam/laser/lethallaser
	fire_sound = 'sound/weapons/laser.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
	equip_cooldown = 30
	name = "\improper CH-LC \"Solaris\" laser cannon"
	desc = "A weapon for combat exosuits. Shoots heavy lasers."
	icon_state = "mecha_ion"
	energy_drain = 100
	projectile = /obj/projectile/beam/laser/heavy/lethalheavy
	fire_sound = 'sound/weapons/lasercannonfire.ogg'


/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/trickshot
	equip_cooldown = 30
	name = "\improper ZE-TRON \"Trickshooter\" laser beam"
	desc = "A weapon for combat exosuits. A dangerously modfied version of the Flare, does less inital damage with each shit but will gain damage as the beam refractors with each richoete, bounces 3 times.."
	icon_state = "mecha_ion"
	energy_drain = 20000
	projectile = /obj/projectile/bullet/lmg/tricklaser
	fire_sound = 'sound/weapons/beam_sniper.ogg'
	harmful = TRUE
