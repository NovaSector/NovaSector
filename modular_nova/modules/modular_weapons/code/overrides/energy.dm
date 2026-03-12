/obj/item/gun/energy/laser
	name = "laser gun"
	desc = "The Allstar Lasers Star Combat 1, or \"Allstar SC-1\", \
		is a basic, energy-based workhorse of a laser carbine that fires concentrated beams of light which pass through glass and thin metal."
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/laser/pistol
	// 20 lasers up from 16 + small so it competes(?) with the mini egun
	// lethals only but you get a lot of shots off
	name = "laser pistol"
	desc = "The Allstar Lasers Star Combat 1 Compact, or \"Allstar SC-1/C\", \
		is a compact pistol variant of the venerable SC-1 designed with a focus on portability."
	w_class = WEIGHT_CLASS_SMALL
	projectile_damage_multiplier = 1

/obj/item/gun/energy/laser/assault
	name = "laser assault rifle"
	desc = "The Allstar Lasers Star Combat 1 Assault, or \"Allstar SC-1/A\", \
		is an assault variant of the venerable SC-1 designed with a focus on sustained fire \
		potential and resistance against electromagnetic interference."
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/energy/laser/practice
	desc = "A modified version of the Allstar SC-1 laser gun. Fires entirely harmless bolts of directed energy. Safe AND entertaining to fire with abandon."

/obj/item/gun/energy/laser/retro
	name = "retro laser gun"
	desc = parent_type::desc + " This one's from a much older manufacturing run. The fact that \
		it still runs speaks to Allstar's manufacturing standards."

/obj/item/gun/energy/laser/retro/old
	desc = parent_type::desc + " On second thought, perhaps not - how long has this one been in use?"

/obj/item/gun/energy/laser/soul
	name = "classic laser gun"
	desc = parent_type::desc + " This one's from a \"neoclassic\" manufacturing run, using an \
		older manufacturing run's design for the nostalgic laser gunner. \
		They don't make them like they used to."

/obj/item/gun/energy/laser/carbine
	name = "laser burst carbine"
	desc = "The Allstar Lasers Star Combat 1-Rapid, or \"Allstar SC-1/R\", \
		is an energy-based laser burst-fire carbine that fires a sustained volley of lasers. \
		It trades the stopping power of each individual beam for a sustained volley of directed energy."

/obj/item/gun/energy/laser/carbine/practice
	desc = "A modified version of the Allstar SC-1R laser carbine. Fires entirely harmless bolts of directed energy. Safe AND entertaining to fire with abandon."

/obj/item/gun/energy/laser/hellgun
	name = "hellfire laser gun"
	desc = "The Allstar Lasers Star Combat Heavy, or \"Allstar SC-H\", \
		is a relic of a weapon, built before Allstar began installing regulators on their laser weaponry. \
		This pattern of laser gun became infamous for the gruesome burn wounds it caused, \
		and was quietly pushed to the sidelines once it began to affect Allstar's reputation."

/obj/item/gun/energy/laser/captain
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire/blueshield) // 20 hellfires up from 15

/obj/item/gun/energy/e_gun
	name = "energy carbine"
	desc = "The Allstar Lasers Star Combat 2, or \"Allstar SC-2\", \
		is a basic hybrid energy carbine with two settings: disable and kill."
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/e_gun/advtaser
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PAYCHECK_CREW * 5

/obj/item/ammo_casing/energy/laser
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(12, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/laser/hos
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE * 1.2)
	// up from LASER_SHOTS(12, STANDARD_CELL_CHARGE * 1.2)

/obj/item/ammo_casing/energy/disabler/hos
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE * 1.2)
	// up from LASER_SHOTS(20, STANDARD_CELL_CHARGE * 1.2)

/obj/item/ammo_casing/energy/ion/hos
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE * 1.2)
	// up from LASER_SHOTS(4, STANDARD_CELL_CHARGE * 1.2)

/obj/item/ammo_casing/energy/laser/hellfire
	e_cost = LASER_SHOTS(15, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(10, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/lasergun
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(16, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/lasergun/pistol
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/lasergun/carbine
	e_cost = LASER_SHOTS(30, STANDARD_CELL_CHARGE)

/obj/item/stock_parts/power_store/cell/mini_egun
	maxcharge = STANDARD_CELL_CHARGE * 0.75
	// up from STANDARD_CELL_CHARGE * 0.6

// lore

/obj/item/gun/energy/laser/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-1 laser gun, typically referred to as the SC-1, laser gun, or \"ol' reliable\", \
			is one of Allstar's greatest successes in energy weapon development, proving itself as a workhorse.<br>\
			<br>\
			Typically regarded as a solid benchmark by which all other energy firearms can be held against, \
			the SC-1 typically features a respectable cell and solid stopping power per shot. \
			Being an energy-based firearms means that, logistics-wise, the only thing required to support its use other \
			than maintenance equipment and spare parts is a steady supply of power in lieu of ammunition, \
			making it quite popular for people with a surplus of the former and not so much the latter." \
	)

// Retro Laser Gun

/obj/item/gun/energy/laser/retro/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-1 laser gun, typically referred to as the SC-1, laser gun, or \"ol' reliable\", \
			is one of Allstar's greatest successes in energy weapon development, proving itself as a workhorse. \
			Especially this one, which uses a casing pattern that hasn't been in active use for... who knows how long.<br>\
			<br>\
			Typically regarded as a solid benchmark by which all other energy firearms can be held against, \
			the SC-1 typically features a respectable cell and solid stopping power per shot. \
			Being an energy-based firearms means that, logistics-wise, the only thing required to support its use other \
			than maintenance equipment and spare parts is a steady supply of power in lieu of ammunition, \
			making it quite popular for people with a surplus of the former and not so much the latter. \
			The fact that this particular example still runs fine, despite its visible age, is remarkable." \
	)

// Soulful Laser Gun

/obj/item/gun/energy/laser/soulful/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-1 laser gun, typically referred to as the SC-1, laser gun, or \"ol' reliable\", \
			is one of Allstar's greatest successes in energy weapon development, proving itself as a workhorse.<br>\
			<br>\
			This specific variant is from a \"neoclassical\" manufacturing run, using an old chassis as a base. \
			While many would argue that the neoclassical runs are gimmick runs to squeeze out more money, \
			others swear by the old-fashioned style, citing anecdotal evidence. Either way, a laser gun is a laser gun.<br>\
			<br>\
			Typically regarded as a solid benchmark by which all other energy firearms can be held against, \
			the SC-1 typically features a respectable cell and solid stopping power per shot. \
			Being an energy-based firearms means that, logistics-wise, the only thing required to support its use other \
			than maintenance equipment and spare parts is a steady supply of power in lieu of ammunition, \
			making it quite popular for people with a surplus of the former and not so much the latter." \
	)

// hellfire laser gun

/obj/item/gun/energy/laser/hellgun/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-H heavy laser gun, typically referred to as the SC-H, hellfire laser gun, or \"ol' inhumane\", \
			is one of Allstar's less-great successes in energy weapon development, proving itself to be a little too effective. \
			It's considered a notable example of Allstar flying too close to the sun for its own good.<br>\
			<br>\
			The success of the SC-1 resulted in shareholders pushing for a follow-up to ride the wave of its success. Despite insistence \
			from Allstar that it was not ready for a full rollout, continued pushes from shareholders forced the prototype SC-H into production \
			and rollout in the next quarter, even before most of its safety systems had been properly tested and implemented. \
			Reports immediately began flooding in of horrific accidental discharges, battlefield atrocities and unexpected spontaneous combustion \
			from excessive exposure to the untested experimental heat distribution systems 'taking its pound of flesh' for the 'hell it unleashed'.<br>\
			<br>\
			In response, many legal bodies rushed to ban or heavily restrict the firearm from sales within their region of space, \
			and the weapon became infamous for its unethical means of ending sentient life. \
			Laws were passed to ensure power regulators were installed in future energy-based weaponry. \
			Allstar quickly downturned manufacturing of the SC-H in response, returning to focusing on manufacturing the SC-1 to \
			regain lost ground in affected markets. \
			While, legally, the SC-H is still restricted if not banned in many polities, Nanotrasen itself does not regulate possession \
			of the firearm aboard their stations, nor does any legal body intend on preventing them from utilizing it in defense \
			of its own assets." \
	)

// Antique Laser Gun

/obj/item/gun/energy/laser/captain/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "For a brief period, Allstar produced a series of custom-made SC-H laser guns for a select group of \
			clients, mainly consisting of various wealthy starship captains, politicians and military leaders looking to demonstrate prestige before \
			the common folk.<br>\
			<br>\
			The SC-H was a commercial failure, but this particular variant earned its own infamy, linked to narratives of crazed \
			despots using it to put down political rivals and dissidents, as well as tales of mad generals marching ahead of their \
			forces, this weapon brandished, running hot in an outstretched arm towards any moving target they could find on the \
			battlefield. <br>\
			<br>\
			Usage of this firearm is now heavily scrutinized within SolFed space because of its reputation. \
			This is largely why Nanotrasen insists that any examples held by ranking officers be kept under lock and key. \
			All records of the schematics surrounding this variant of the SC-H were seized and destroyed, and the creator behind \
			it detained in a maximum security SolFed sanitorium. During a routine check-up, she appeared to have smeared the walls in her \
			own blood, claiming that 'She' was coming, and that she had paid dearly for the knowledge of how to make the weapon.<br>\
			<br>\
			Even the microfusion breeder cell housed inside the weapon is practically a lost technology. Nanotrasen have remained unable \
			to reverse engineer the device's exact means of functionality. The Syndicate are, obviously, just as interested \
			in exactly how this weapon's cell remains capable of self-perpetuation, hence why the collective \
			seem hell-bent on capturing them whenever possible.<br>\
			<br>\
			Maybe keep this somewhere safe. Or don't." \
	)

// X-ray Laser Gun

/obj/item/gun/energy/laser/xray/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The NT Type 6 Heat Delivery System (sometimes referred to as the HDS6 in research notes) is a breakthrough in the \
			development of directed energy weaponry, using modified Allstar SC-1s as a base.<br>\
			<br>\
			Very little is known about the Type 6, as it is a relatively new experimental weapon only accessible to Nanotrasen security forces.\
			Somehow, Nanotrasen has found a means to 'slip' the energy beams produced by the Type 6 through unintended targets, only impacting \
			once it has made contact with a pre-designated target by the weapon's user. It appears to be unable to slip past organic matter reliably, \
			which hampers its potential for eliminating friendly-fire. However, inorganic targets are left unscathed unless the weapon is directed towards \
			firing upon the object. This makes the weapon exceptional for asset recovery, defensive entrenchment, and assaults on defensive structures. <br>\
			<br>\
			Nanotrasen claims that this phenomenon is achieved 'through the power of X-rays'. Most critics have highlighted that this is total nonsense. Some claim \
			that Nanotrasen has discovered a yet-unknown state of matter that the company is exploiting for weapons development and manufacturing. The most \
			conspiratorially minded of Nanotrasen's critics have even gone as far as to claim it is 'proof of ectoplasm as the sixth element', \
			and that, perhaps, the weapon may be operating through supernatural means; perhaps even powered by the 'spirits of the damned'.<br>\
			<br>\
			Whatever the truth may be, the weapon seems to function as advertised, and matches the energy efficiency of the SC-1. Nanotrasen \
			expects full commercial rollout sometime in the next quarter." \
	)

// Laser Carbine

/obj/item/gun/energy/laser/carbine/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Allstar SC-1R is a modification of the venerable SC-1, and a shaky first step into \
			automatic directed energy weaponry, eventually leading to settling on a burst-fire system.<br>\
			<br>\
			While less popular than the standard laser gun, the SC-1R's burst-fire system and accelerated \
			agitation chamber allows for a good rate of sustained fire with reduced risk of searing ones' hands off, \
			in return for sacrificing stopping power per shot. \
			Being an energy-based firearms means that, logistics-wise, the only thing required to support its use other \
			than maintenance equipment and spare parts is a steady supply of power in lieu of ammunition, \
			making it quite popular for people with a surplus of the former and not so much the latter." \
	)

// crates

/datum/supply_pack/security/armory/laser
	name = "SC-1 Laser Gun Crate"
	desc = "Contains three SC-1 laser guns, developed by Allstar Lasers. For when the going gets tough, \
		you get going with the Allstar SC-1."

/datum/supply_pack/security/armory/laser_carbine
	name = "SC-1R Laser Carbine Crate"
	desc = "Contains three Type SC-1R laser burst carbines, developed by Allstar Lasers. Fires a rapid burst of slightly weaker laser projectiles."
