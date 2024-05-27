

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A weapon for combat exosuits. Shoots a spread of pellets. Shoots Ballistic Ammo"
	icon_state = "mecha_scatter"
	equip_cooldown = 20
	projectile = /obj/projectile/bullet/scattershot
	projectiles = 80
	projectiles_cache = 80
	projectiles_cache_max = 200
	projectiles_per_shot = 8
	variance = 35
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg
	name = "\improper Ultra AC 2"
	desc = "A weapon for combat exosuits. Shoots a rapid, three shot burst. Shoots Ballistic Ammo"
	icon_state = "mecha_carbine"
	equip_cooldown = 15
	projectile = /obj/projectile/bullet/lmg
	projectiles = 300
	projectiles_cache = 300
	projectiles_cache_max = 1200
	projectiles_per_shot = 3
	variance = 1
	randomspread = 0
	projectile_delay = 2
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/ac20
	name = "\improper  LB AC 20 \"Slugger\""
	desc = "A weapon for combat exosuits. Shoots one massive slug, falls off over range. Shoots Ballistic Ammo"
	icon_state = "mecha_uac2"
	equip_cooldown = 25
	projectile = /obj/projectile/bullet/lmg/ac20b
	projectiles = 20
	projectiles_cache = 20
	projectiles_cache_max = 100
	projectiles_per_shot = 1
	variance = 0
	randomspread = 0
	projectile_delay = 1
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG
	fire_sound = 'sound/weapons/gun/hmg/hmg.ogg'

//nerfing this thing via slower fire rate
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	name = "\improper FNX-99 \"Hades\" Carbine"
	desc = "A weapon for combat exosuits. Shoots Ballistic ammo."
	icon_state = "mecha_carbine"
	equip_cooldown = 50
	projectile = /obj/projectile/bullet/incendiary/fnx99
	projectiles = 24
	projectiles_cache = 24
	projectiles_cache_max = 96
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/railgun
	name = "\improper  ARLS-500 \"Piercer\""
	desc = "A weapon for combat exosuits. Magnetically fires a metallic rod at a high speed, prone to peircing armor and embedding. Requires a manual reload of the rail between each shot. Shoots Ballistic Ammo "
	icon_state = "mecha_mime"
	fire_sound = "sound/weapons/emitter2.ogg"
	equip_cooldown = 30
	projectile = /obj/projectile/bullet/rebar/r500
	projectiles = 1
	projectiles_cache = 30
	projectiles_cache_max = 100
	projectiles_per_shot = 1
	variance = 0
	randomspread = 0
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG
