/mob/living/basic/drone
	initial_language_holder = /datum/language_holder/drone_nova
	laws = \
	"1. You may not harm any being, regardless of intent or circumstance.\n"+\
	"2. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation." //for derelict drones so they don't go to station.
	flavortext = \
	"<span class='notice'>Drones are a ghost role that are allowed to fix the station and build things.</span>\n"+\
	"<span class='notice'>Actions that are not allowed:</span>\n"+\
	"<span class='notice'>     - Interacting with round critical objects (IDs, weapons, contraband, powersinks, bombs, etc.)</span>\n"+\
	"<span class='boldwarning'>          - THIS INCLUDES SETTING UP THE SM, OR ANY MATTERS INVOLVING IT!!</span>\n"+\
	"<span class='notice'>     - Changing the health state of living beings (attacking, healing, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with non-living beings (dragging bodies, looting bodies, etc.)</span>\n"+\
	"<span class='warning'>Please keep these rules in mind, failing to do so can lead to a ban.</span>\n"+\
	"<span class='warning'><u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>\n"+\
	"<span class='notice'>Prefix your message with :b to speak in Drone Chat.</span>\n"
	var/l_store // Reference to left pocket item
	var/r_store // Reference to right pocket item

/datum/hud/dextrous/drone/New(mob/owner)
	. = ..()
	var/atom/movable/screen/inventory/inv_box

	// Left pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	static_inventory += inv_box

	// Right pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	static_inventory += inv_box
