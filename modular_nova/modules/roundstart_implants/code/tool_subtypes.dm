// ENGINEERING

/obj/item/wrench/integrated
	name = "motorized fingertip wrench-bit"
	desc = "A cheap inverted fingertip replacement complete with a small-factor motor and torque wrenching bit. Works on most station standard applications, but is often slower than using a hand wrench."
	toolspeed = 2

/obj/item/wrench/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/screwdriver/integrated
	name = "motorized fingertip screw-bit"
	desc = "A cheap inverted fingertip replacement that extends into a sturdy universal screwdriver head, complete with a small-factor motor. A bit slow, but gets the job done."
	toolspeed = 2

/obj/item/screwdriver/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/crowbar/integrated
	name = "integrated crowbar"
	desc = "Rumour has it that people over a thousand people died in the resulting espionage centered around the exact angular dimensions that make this feat of physics and leverage possible. Retreats back into the bearer's arm when not in use."
	toolspeed = 2.5 // really slow because a lot of firelock/airlock mobility gameplay relies on crowbar scarcity

/obj/item/crowbar/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/multitool/integrated
	name = "integrated 'multitool' diagnostics device"
	desc = "Combining a set of fingertip probes fed back into an internal coprocessor, this useful little device has made its way into the arms of engineers and maintenance technicians galaxy-wide."
	toolspeed = 2

/obj/item/multitool/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/weldingtool/electric/arc_welder/integrated
	name = "integrated arc welder"
	desc = "Stripped down enough to fit inside a standard humanoid arm, this specialized tool guzzles power like nobody's business and produces a slightly weaker arc. It gets the job done, but you're putting a power cell inside your arm and signing all the OHS waivers that comes with."
	toolspeed = 2 //100% slower. really fucking slow, since synths can repair themselves with this

/obj/item/weldingtool/electric/arc_welder/integrated/switched_on(mob/user)
	. = ..()
	force = 10 // no you're not starting with a force 15 weapon even if it does use more charge than god

// MEDICAL

/obj/item/surgical_drapes/integrated
	name = "hardlight surgical indicators"
	desc = "A basic array of hardlight markers used in rudimentary surgical procedures where more specialized equipment isn't available, co-opted from wound analyzer hardware. Lays out the groundwork protocols for basic surgeries when levelled at a target."

/obj/item/surgical_drapes/integrated/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/surgery_initiator)
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/scalpel/integrated
	name = "fingertip scalpel"
	desc = "The mainstay of less-than-legal cyberneticists galaxy wide. Much more finnicky to use than the real deal, but has the added advantage of inverting neatly into your finger when not in use. Comes with spring-detachable blades for easy sanitation."
	toolspeed = 2
	wound_bonus = 0 // nope you're not starting with a 10 wound bonus weapon unless you pick razor claws
	bare_wound_bonus = 0 // see above

/obj/item/scalpel/integrated/Initialize(mapload)
	// hard override this one since it's worse in some ways
	AddComponent(/datum/component/butchering, \
	speed = 8 SECONDS * toolspeed, \
	effectiveness = 50, \
	bonus_modifier = 0, \
	)
	AddElement(/datum/element/eyestab)
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/hemostat/integrated
	name = "integrated hemostatic clamp"
	desc = "More or less a glorified set of forceps with slightly serrated teeth and a dedicated interlocking mechanism, all miniaturized to fit inside a finger."
	toolspeed = 2 // this will directly affect how fast someone can tend wounds with this setup, balancejak accordingly

/obj/item/hemostat/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

// UTILITY

/obj/item/storage/bag/tray/integrated
	name = "telescoping kitchen carrier"
	desc = "First pioneered aboard the Mothic fleet and later utilized heavily in multi-armed species. Very useful for hauling around large amounts of food, and can rolls into a telescopic, hermetically-sealed tube for storage in the user's arm."

/obj/item/lighter/integrated
	name = "thumbtip lighter"
	desc = "Galactic polling indicated outrageous market demand for this particular cybernetic addition - specifically a hinged false fingertip with a standard lighter housing inside, with many firms citing 'increased reproductive acquisition' as one of the primary survey results. Translated into Galactic Common, this means that lighting cigarettes with your finger helps you pull. Allegedly."

/obj/item/reagent_containers/cup/rag/integrated
	name = "integrated cleaning chamois"
	desc = "Guaranteed to eliminate (most) messes. This civilian-issue cybernetic enhancement comes with a lengthy waiver about foregoing any claims to fluid damage made by the device to your internal arm comparment."
