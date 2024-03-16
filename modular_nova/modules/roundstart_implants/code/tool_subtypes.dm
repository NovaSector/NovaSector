// ENGINEERING

/obj/item/wrench/integrated
	name = "motorized fingertip wrench-bit"
	desc = "A cheap inverted fingertip replacement complete with a small-factor motor and torque wrenching bit. Works on most station standard applications, but is often slower than using a hand wrench."
	toolspeed = 1.25

/obj/item/wrench/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/screwdriver/integrated
	name = "motorized fingertip screw-bit"
	desc = "A cheap inverted fingertip replacement that extends into a sturdy universal screwdriver head, complete with a small-factor motor. A bit slow, but gets the job done."
	toolspeed = 1.25

/obj/item/screwdriver/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/crowbar/integrated
	name = "integrated crowbar"
	desc = "Rumour has it that people over a thousand people died in the resulting espionage centered around the exact angular dimensions that make this feat of physics and leverage possible. Retreats back into the bearer's arm when not in use."
	toolspeed = 1.25

/obj/item/crowbar/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/multitool/integrated
	name = "integrated 'multitool' diagnostics device"
	desc = "Combining a set of fingertip probes fed back into an internal coprocessor, this useful little device has made its way into the arms of engineers and maintenance technicians galaxy-wide."
	toolspeed = 1.25

/obj/item/multitool/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/weldingtool/electric/arc_welder/integrated
	name = "integrated arc welder"
	desc = "Stripped down enough to fit inside a standard humanoid arm, this specialized tool guzzles power like nobody's business and produces a slightly weaker arc. It gets the job done, but you're putting a power cell inside your arm and signing all the OHS waivers that comes with."
	toolspeed = 1.25 //25% slower. really fucking slow, since synths can repair themselves with this

/obj/item/weldingtool/electric/arc_welder/integrated/switched_on(mob/user)
	. = ..()
	force = 12 // paxil tells me it's not a HUGE issue to do this but i still think force 15 is too much so force 12 we do

// MEDICAL

/obj/item/surgical_drapes/integrated
	name = "hardlight surgical indicators"
	desc = "A basic array of hardlight markers used in rudimentary surgical procedures where more specialized equipment isn't available, co-opted from wound analyzer hardware. Lays out the groundwork protocols for basic surgeries when levelled at a target."

/obj/item/surgical_drapes/integrated/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/surgery_initiator)
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/hemostat/integrated
	name = "integrated hemostatic clamp"
	desc = "More or less a glorified set of forceps with slightly serrated teeth and a dedicated interlocking mechanism, all miniaturized to fit inside a finger."
	toolspeed = 1.25 // this will directly affect how fast someone can tend wounds with this setup, balancejak accordingly

/obj/item/hemostat/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/retractor/integrated
	name = "fingertip retractor clamp"
	desc = "A special suite of high-grip flesh torsioning clips designed for use in field surgery situations."
	toolspeed = 1.25

/obj/item/retractor/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

// UTILITY

/obj/item/storage/bag/tray/integrated
	name = "telescoping kitchen carrier"
	desc = "First pioneered aboard the Mothic fleet and later utilized heavily in multi-armed species. Very useful for hauling around large amounts of food, and can rolls into a telescopic, hermetically-sealed tube for storage in the user's arm."

/obj/item/storage/bag/tray/integrated/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 3

/obj/item/lighter/integrated
	name = "thumbtip lighter"
	desc = "Galactic polling indicated outrageous market demand for this particular cybernetic addition - specifically a hinged false fingertip with a standard lighter housing inside, with many firms citing 'increased reproductive acquisition' as one of the primary survey results. Translated into Sol Common, this means that lighting cigarettes with your finger helps you pull. Allegedly."

/obj/item/reagent_containers/cup/rag/integrated
	name = "integrated cleaning chamois"
	desc = "Guaranteed to eliminate (most) messes. This civilian-issue cybernetic enhancement comes with a lengthy waiver about foregoing any claims to fluid damage made by the device to your internal arm comparment."

/obj/item/pen/fourcolor/integrated
	//no new desc for this one since it sets its own desc
	name = "integrated four-color pen"

/obj/item/paper_bin/integrated
	name = "integrated paper sheaf"
	desc = "Only a jacent could've been capable of the raw bureaucracy required to allow even a small paper bin to be fitted into someone's arm. Also comes with an internal routing clip to hold an extra pen, just in case you somehow go through the first one."
	total_paper = 10

/obj/item/universal_scanner/integrated
	name = "fingertip universal scanner"
	desc = "Some deckhands working the FTU distribution centers popularized this cybernetic addon after the speed improvements it yielded let them claw back the ten minute lunch breaks they'd been deprived for thirty years. Replaces the pad of the user's fourth finger with a digitized universal scanner, capable of switching between export, price, and sales tagger modes."
	paper_count = 5
	max_paper_count = 5

/obj/item/boxcutter/extended/integrated
	name = "integrated boxcutter"
	desc = "Stolen from old Terran databanks, the design for this integration was originally some kind of wrist-sheathed assassin tool released into the public domain by an unnamed bitrunner. The FTU found that it worked great as a box cutter, and so authorized it for inclusion in their Deckhand toolset."

/obj/item/stamp/integrated
	name = "fingertip 'GRANTED' stamp"
	desc = "Designed to swivel out of a specialized finger-pad mount, this stamp is the bane of budget-crunchers everywhere - for wherever it dares to touch, a loss of credits is sure to follow."

/obj/item/stamp/denied/integrated
	name = "fingertip 'DENIED' stamp"
	desc = "When the computer really, really says no."

// FORGING (why are we doing this)

/obj/item/forging/hammer/integrated
	name = "integrated metalworking hammer"
	desc = "At the request of Dwarvenkind, the Blacksteel Foundation produced a low-cost toolset that ultimately ended up becoming one of their most popular products. And it all began with this solitary hammer."

/obj/item/forging/hammer/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BLACKSTEEL)

/obj/item/forging/tongs/integrated
	name = "heat-sheathed fingertip tongs"
	desc = "Hardy heat-treated metal and integrated heatsinks allow these two fingertip replacement augs to act as one might use ordinary metallurgical tongs, resisting burns from all but the most raging forges."
	toolspeed = 2 SECONDS

/obj/item/forging/tongs/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BLACKSTEEL)

/obj/item/forging/billow/integrated
	name = "motorized mini-bellows"
	desc = "Let not its size deceive you, for the gale this hinged accordion-like aug can produce when activated is enough to stoke even the most timid fires into a frenzy. Has a health and safety warning on it which reads: 'DO NOT INSERT INTO MOUTH'."
	toolspeed = 2 SECONDS

/obj/item/forging/billow/integrated/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BLACKSTEEL)
