#define AMMO_MATS_SHOTGUN list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4) // not quite as thick as a half-sheet

#define AMMO_MATS_SHOTGUN_FLECH list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

#define AMMO_MATS_SHOTGUN_HIVE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/silver = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_TIDE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/gold = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_PLASMA list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun
	icon = 'modular_nova/modules/shotgunrebalance/icons/shotshells.dmi'
	desc = "A 12 gauge iron slug."
	custom_materials = AMMO_MATS_SHOTGUN

/obj/projectile/bullet/shotgun_slug
	// tg stats at time of writing: 25 damage, 30 AP
	// buffed to 50 force, nerfed to 10 AP
	// for some parity with old stats, except the 10 AP buff
	damage = 50
	armour_penetration = 10

/obj/item/ammo_casing/shotgun/milspec
	desc = "A hot-loaded 12 gauge milspec slug shell, used by various paramilitaries and mercenary forces. Probably not legal to use under corporate regulations."
	icon_state = "mblshell"
	ammo_categories = AMMO_CLASS_SUPER
	custom_materials = AMMO_MATS_HEAVY_FAST

/obj/projectile/bullet/shotgun_slug/milspec
	// tg stats at time of writing: 50 damage, 30 AP (inherited from base slugs)
	// buffed to 60 force, keeps the 30 AP to give it an edge over base, easily produced slugs
	// also gets extra speed to give it another edge
	damage = 60
	armour_penetration = 30
	speed = 1.5

// THE BELOW TWO SLUGS ARE NOTED AS ADMIN ONLY AND HAVE ***EIGHTY*** WOUND BONUS. NOT BARE WOUND BONUS. FLAT WOUND BONUS.
/obj/item/ammo_casing/shotgun/executioner
	name = "expanding shotgun slug"
	desc = "A 12 gauge fragmenting slug purpose-built to annihilate flesh on impact."
	can_be_printed = FALSE // noted as admin only in code/modules/projectiles/projectile/bullets/shotgun.dm.

/obj/item/ammo_casing/shotgun/pulverizer
	name = "pulverizer shotgun slug"
	desc = "A 12 gauge uranium slug purpose-built to break bones on impact."
	can_be_printed = FALSE // noted as admin only in code/modules/projectiles/projectile/bullets/shotgun.dm

/obj/item/ammo_casing/shotgun/beanbag
	harmful = FALSE
	ammo_categories = AMMO_CLASS_NONE

/obj/item/ammo_casing/shotgun/incendiary
	desc = "A 12 gauge shotgun slug coated with incendiary material.\
		<br><br>\
		<i>INCENDIARY: Sets targets aflame. Leaves a flaming trail when shot.</i>"
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/item/ammo_casing/shotgun/incendiary/no_trail
	desc = "A 12 gauge shotgun slug coated with incendiary material.\
		<br><br>\
		<i>PRECISION INCENDIARY: Sets targets aflame. Does not leave a flaming trail when shot.</i>"

/obj/item/ammo_casing/shotgun/dragonsbreath
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/stunslug
	name = "taser slug"
	desc = "A 12 gauge silver slug with electrical microcomponents meant to incapacitate targets."
	can_be_printed = FALSE // comment out if you want rocket tag shotgun ammo being printable

/obj/item/ammo_casing/shotgun/meteorslug
	name = "meteorslug shell"
	desc = "A 12 gauge shell rigged with CMC technology which launches a heap of matter with great force when fired.\
		<br><br>\
		<i>METEOR: Fires a meteor-like projectile that knocks back movable objects like people and airlocks.</i>"
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/pulseslug
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12 slug"
	desc = "A 12 gauge shell containing high explosives designed for defeating some barriers and light vehicles, disrupting IEDs, or intercepting assistants.\
		<br><br>\
		<i>HIGH EXPLOSIVE: Explodes on impact.</i>"
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 12 // 5 * 12 for 60 damage if every pellet hits, we want to keep lethal shells ~50 damage
	variance = 20

/obj/item/ammo_casing/shotgun/buckshot/old
	name = "old buckshot shell"
	desc = "A 12 gauge buckshot shell. Improper storage makes using this a questionable prospect, at best."
	can_be_printed = FALSE // it's just not good

/obj/projectile/bullet/pellet/shotgun_buckshot
	damage = 5
	weak_against_armour = TRUE

/obj/item/ammo_casing/shotgun/buckshot/milspec
	desc = "A hot-loaded 12 gauge milspec buckshot shell, used by various paramilitaries and mercenary forces. Probably not legal to use under corporate regulations."
	icon_state = "mgshell"
	variance = 15
	ammo_categories = AMMO_CLASS_SUPER
	custom_materials = AMMO_MATS_HEAVY_FAST

/obj/projectile/bullet/pellet/shotgun_buckshot/milspec
	damage = 6 // 6 * 12 = 72
	damage_falloff_tile = -0.1
	wound_falloff_tile = -0.25
	speed = 1.5
	armour_penetration = 5
	weak_against_armour = FALSE // lmao

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubber shot shell"
	desc = "A shotgun casing filled with dense rubber balls, used to incapacitate crowds from a distance."
	icon_state = "rshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_rubbershot
	pellets = 6 // 6 * 10 for 60 stamina damage, + some small amount of brute, we want to keep less lethal shells ~60
	variance = 27
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/projectile/bullet/pellet/shotgun_rubbershot
	stamina = 10
	speed = 1
	weak_against_armour = TRUE

/obj/item/ammo_casing/shotgun/incapacitate
	name = "incapacitator shell"
	desc = "A 12 gauge shell filled with some kind of material that excels at incapacitating targets. Contains a lot of pellets, \
		sacrificing individual pellet strength for sheer stopping power in what's best described as \"spitting distance\".\
		<br><br>\
		<i>INCAPACITATOR: Fire an overwhelming amount of projectiles in a single shot.</i>"
	// 12 pellets * 6 stam per pellet = 72 stam
	// but it's also got 25 variance so you're either in spitting distance or missing
	ammo_categories = AMMO_CLASS_NICHE_LTL
	harmful = FALSE

/obj/item/ammo_casing/shotgun/flechette
	name = "shredder flechette shell"
	desc = "A 12 gauge flechette shell that specializes in cutting through armor and embedding like hell."
	ammo_categories = AMMO_CLASS_SUPER // i mean with exotic tech you get to print this for free anyway
	// Points-cost is gone, this may need additional balance.
	// Why didn't these already use flechette materials though??
	custom_materials = AMMO_MATS_SHOTGUN_FLECH

/obj/projectile/bullet/pellet/flechette
	name = "shredder flechette"
	damage = 5 // 8*5 = 40 damage but you've got 30 AP which basically smokes most armor
	damage_falloff_tile = -0.1 // less falloff/longer ranges, though
	speed = 1.3 // you can have above average projectile speed. as a treat
	// embeds staying untouched because i think they're evil and deserve to wreak havoc

/obj/item/ammo_casing/shotgun/flechette/donk
	ammo_categories = AMMO_CLASS_NONE

/obj/item/ammo_casing/shotgun/ion
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/scatterlaser
	ammo_categories = AMMO_CLASS_NICHE // it's techy okay.

/obj/item/ammo_casing/shotgun/techshell
	can_be_printed = FALSE // techshell... casing! so not really usable on its own but if you're gonna make these go raid a seclathe.
	// then again since it doesn't have any defined projectile you're not printing it anyway.

/obj/item/ammo_casing/shotgun/dart
	ammo_categories = AMMO_CLASS_NICHE_LTL // technically.

/obj/item/ammo_casing/shotgun/dart/bioterror
	can_be_printed = FALSE // PRELOADED WITH TERROR CHEMS MAYBE LET'S NOT

/obj/item/ammo_casing/shotgun/breacher
	ammo_categories = AMMO_CLASS_NICHE_LTL
	can_be_printed = FALSE
	// on one hand, 1k damage against airlocks. and mechs. and borgs.
	// on the other hand like 5 damage against everyone else lmao

// everything beyond this point is nova content
/obj/item/ammo_casing/shotgun/magnum
	name = "magnum blockshot shell"
	desc = "A 12 gauge shell that fires fewer, larger pellets than buckshot. A favorite of SolFed anti-piracy enforcers, \
		especially against the likes of vox."
	icon_state = "magshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	pellets = 6 // Half as many pellets for twice the damage each pellet, same overall damage as buckshot
	variance = 20
	ammo_categories = AMMO_CLASS_SUPER

/obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	name = "magnum blockshot"
	damage = 10
	exposed_wound_bonus = 10
	armour_penetration = 5
	weak_against_armour = FALSE

/obj/projectile/bullet/pellet/shotgun_buckshot/magnum/Initialize(mapload)
	. = ..()
	transform = transform.Scale(1.25, 1.25)

/obj/item/ammo_casing/shotgun/express
	name = "express pelletshot shell"
	desc = "A 12 gauge shell that fires more and smaller projectiles than buckshot. Considered taboo to speak about \
		openly near teshari, for reasons you would be personally blessed to not know at least some of."
	icon_state = "expshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/express
	ammo_categories = AMMO_CLASS_SUPER
	pellets = 15 // 4 * 15 for 60 damage, with less spread then buckshot.
	variance = 12 // Slightly less spread then buckshot

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	name = "express pellet"
	damage = 4
	wound_bonus = 0

/obj/projectile/bullet/pellet/shotgun_buckshot/express/Initialize(mapload)
	. = ..()
	transform = transform.Scale(0.75, 0.75)

/obj/item/ammo_casing/shotgun/flechette_nova
	name = "ripper flechette shell"
	desc = "A 12 gauge flechette shell that specializes in ripping unarmored targets apart."
	icon_state = "fshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/flechette_nova
	pellets = 8 //8 x 6 = 48 Damage Potential
	variance = 15
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_SHOTGUN_FLECH

/obj/projectile/bullet/pellet/shotgun_buckshot/flechette_nova
	name = "ripper flechette"
	icon = 'modular_nova/modules/shotgunrebalance/icons/projectiles.dmi'
	icon_state = "flechette"
	damage = 6
	wound_bonus = 0
	exposed_wound_bonus = 15
	sharpness = SHARP_EDGED //Did you knew flechettes fly sideways into people

/obj/projectile/bullet/pellet/shotgun_buckshot/flechette_nova/Initialize(mapload)
	. = ..()
	SpinAnimation()

/obj/item/ammo_casing/shotgun/beehive
	name = "hornet shell"
	desc = "A less-lethal 12 gauge shell that fires four pellets capable of bouncing off nearly any surface \
		and re-aiming themselves toward the nearest target. They will, however, go for <b>any target</b> nearby."
	icon_state = "cnrshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	pellets = 4
	variance = 15
	fire_sound = 'sound/items/weapons/taser.ogg'
	harmful = FALSE
	custom_materials = AMMO_MATS_SHOTGUN_HIVE
	ammo_categories = AMMO_CLASS_NICHE_LTL

/obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	name = "hornet flechette"
	icon = 'modular_nova/modules/shotgunrebalance/icons/projectiles.dmi'
	icon_state = "hornet"
	damage = 4
	stamina = 15
	damage_falloff_tile = -0.1
	stamina_falloff_tile = -0.1
	wound_bonus = -5
	exposed_wound_bonus = 5
	wound_falloff_tile = 0
	sharpness = NONE
	ricochets_max = 5
	ricochet_chance = 200
	ricochet_auto_aim_angle = 60
	ricochet_auto_aim_range = 8
	ricochet_decay_damage = 1
	ricochet_decay_chance = 1
	ricochet_incidence_leeway = 0 //nanomachines son

/obj/item/ammo_casing/shotgun/antitide
	name = "stardust shell"
	desc = "A highly experimental shell filled with nanite electrodes that form a much bigger electrode on launch, \
		forming a cable back to the shell itself and acting much like a taser. Unlimited power!"
	icon_state = "lasershell"
	projectile_type = /obj/projectile/energy/electrode
	harmful = FALSE
	fire_sound = 'sound/items/weapons/taser.ogg'
	custom_materials = AMMO_MATS_SHOTGUN_TIDE
	ammo_categories = AMMO_CLASS_NICHE_LTL

/obj/item/ammo_casing/shotgun/hunter
	name = "hunter slug shell"
	desc = "A 12 gauge slug shell that fires specially designed slugs that deal extra damage to local fauna."
	icon_state = "huntershell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/hunter

/obj/projectile/bullet/shotgun_slug/hunter
	name = "12g hunter slug"
	damage = 20
	range = 12
	/// How much the damage is multiplied by when we hit a mob with the correct biotype
	var/biotype_damage_multiplier = 5
	/// What biotype we look for
	var/biotype_we_look_for = MOB_BEAST

/obj/projectile/bullet/shotgun_slug/hunter/on_hit(atom/target, blocked, pierce_hit)
	if(ismineralturf(target))
		var/turf/closed/mineral/mineral_turf = target
		mineral_turf.gets_drilled(firer, FALSE)
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE
		return ..()
	if(!isliving(target) || (damage > initial(damage)))
		return ..()
	var/mob/living/target_mob = target
	if(target_mob.mob_biotypes & biotype_we_look_for || istype(target_mob, /mob/living/simple_animal/hostile/megafauna))
		damage *= biotype_damage_multiplier
	return ..()

/obj/projectile/bullet/shotgun_slug/hunter/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bane, mob_biotypes = MOB_BEAST, damage_multiplier = 5)

/obj/item/ammo_casing/shotgun/honkshot
	name = "confetti shell"
	desc = "A 12 gauge buckshot shell thats been filled to the brim with confetti. Yippie!"
	icon_state = "honkshell"
	projectile_type = /obj/projectile/bullet/honkshot
	pellets = 19 // The most crucial buff.
	variance = 35
	fire_sound = 'sound/items/bikehorn.ogg'
	harmful = FALSE
	ammo_categories = AMMO_CLASS_NONE

/obj/projectile/bullet/honkshot
	name = "confetti"
	damage = 0
	sharpness = NONE
	shrapnel_type = NONE
	impact_effect_type = null
	ricochet_chance = 0
	jitter = 1 SECONDS
	eyeblur = 1 SECONDS
	hitsound = SFX_CLOWN_STEP
	range = 4
	icon_state = "guardian"

/obj/projectile/bullet/honkshot/Initialize(mapload)
	. = ..()
	SpinAnimation()
	range = rand(1, 4)
	color = pick(
		COLOR_PRIDE_RED,
		COLOR_PRIDE_ORANGE,
		COLOR_PRIDE_YELLOW,
		COLOR_PRIDE_GREEN,
		COLOR_PRIDE_BLUE,
		COLOR_PRIDE_PURPLE,
	)

// This proc addition will spawn a decal on each tile the projectile travels over
/obj/projectile/bullet/honkshot/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	new /obj/effect/decal/cleanable/confetti(get_turf(old_loc))
	return ..()

// This proc addition will make living humanoids do a flip animation when hit by the projectile
/obj/projectile/bullet/honkshot/on_hit(atom/target, blocked, pierce_hit)
	if(!isliving(target))
		return ..()
	target.SpinAnimation(7,1)
	return ..()

// This proc addition adds a spark effect when the projectile expires/hits
/obj/projectile/bullet/honkshot/on_range()
	do_sparks(1, TRUE, src)
	return ..()
