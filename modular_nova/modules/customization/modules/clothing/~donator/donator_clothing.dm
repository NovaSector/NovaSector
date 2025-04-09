/**************NOVA SECTOR REWARDS**************/
//SUITS
/obj/item/clothing/suit/hooded/wintercoat/colourable
	name = "custom winter coat"
	icon_state = "winter_coat"
	icon = null
	worn_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/colourable
	greyscale_config = /datum/greyscale_config/winter_coat
	greyscale_config_worn = /datum/greyscale_config/winter_coat_worn
	greyscale_colors = "#666666#CCBBAA#0000FF"
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	/// Whether the hood is flipped up
	var/hood_up = FALSE

/// Called when the hood is worn
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_up(obj/item/clothing/head/hooded/hood)
	hood_up = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_down(obj/item/clothing/head/hooded/hood)
	hood_up = FALSE

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/colourable/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()

	if(!hood)
		return

	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/colourable
	icon_state = "hood_winter"
	greyscale_config = /datum/greyscale_config/winter_hood
	greyscale_config_worn = /datum/greyscale_config/winter_hood/worn

// NECK

/obj/item/clothing/neck/cloak/colourable
	name = "colourable cloak"
	icon_state = "gags_cloak"
	greyscale_config = /datum/greyscale_config/cloak
	greyscale_config_worn = /datum/greyscale_config/cloak/worn
	greyscale_colors = "#917A57#4e412e#4e412e"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/cloak/colourable/veil
	name = "colourable veil"
	icon_state = "gags_veil"
	greyscale_config = /datum/greyscale_config/cloak/veil
	greyscale_config_worn = /datum/greyscale_config/cloak/veil/worn

/obj/item/clothing/neck/cloak/colourable/boat
	name = "colourable boatcloak"
	icon_state = "gags_boat"
	greyscale_config = /datum/greyscale_config/cloak/boat
	greyscale_config_worn = /datum/greyscale_config/cloak/boat/worn

/obj/item/clothing/neck/cloak/colourable/shroud
	name = "colourable shroud"
	icon_state = "gags_shroud"
	greyscale_config = /datum/greyscale_config/cloak/shroud
	greyscale_config_worn = /datum/greyscale_config/cloak/shroud/worn

/**************CKEY EXCLUSIVES*************/

// Donation reward for Grunnyyy
/obj/item/clothing/suit/jacket/ryddid
	name = "Ryddid"
	desc = "An old worn out piece of clothing belonging to a certain small demon."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "darkcoat"
	inhand_icon_state = "greatcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Grunnyyy
/obj/item/clothing/neck/cloak/grunnyyy
	name = "black and red cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward
// might make it have some flavour functionality in future, a'la rewritable piece of paper - JOKES ON YOU I'M MAKING IT DRAW
// Note from thedragmeme- The fact this can actually draw is epic, Im making this an item accessable to all donors so if an actual coder could make it print out drawings or make it save the drawings to the library that would be epic
/obj/item/canvas/drawingtablet
	name = "drawing tablet"
	desc = "A portable tablet that allows you to draw. Legends say these can earn the owner a fortune in some sectors of space."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "drawingtablet"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	actions_types = list(/datum/action/item_action/dtselectcolor,/datum/action/item_action/dtcolormenu,/datum/action/item_action/dtcleargrid)
	pixel_x = 0
	pixel_y = 0
	width = 28
	height = 26
	nooverlayupdates = TRUE
	var/currentcolor = "#ffffff"
	var/list/colors = list("Eraser" = "#ffffff")

/obj/item/canvas/drawingtablet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/dtselectcolor))
		currentcolor = input(user, "", "Choose Color", currentcolor) as color|null
	else if(istype(action, /datum/action/item_action/dtcolormenu))
		var/list/selects = colors.Copy()
		selects["Save"] = "Save"
		selects["Delete"] = "Delete"
		var/selection = input(user, "", "Color Menu", currentcolor) as null|anything in selects
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(selection)
			if("Save")
				var/name = input(user, "", "Name the color!", "Pastel Purple") as text|null
				if(name)
					colors[name] = currentcolor
			if("Delete")
				var/delet = input(user, "", "Color Menu", currentcolor) as null|anything in colors
				if(delet)
					colors.Remove(delet)
			if(null)
				return
			else
				currentcolor = colors[selection]
	else if(istype(action, /datum/action/item_action/dtcleargrid))
		var/yesnomaybe = tgui_alert("Are you sure you wanna clear the canvas?", "", list("Yes", "No", "Maybe"))
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(yesnomaybe)
			if("Yes")
				reset_grid()
				SStgui.update_uis(src)
			if("No")
				return
			if("Maybe")
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				audible_message(span_warning("The [src] buzzes!"))
				return

/obj/item/canvas/drawingtablet/get_paint_tool_color()
	return currentcolor

/obj/item/canvas/drawingtablet/finalize()
	return // no finalizing this piece

/obj/structure/sign/painting/frame_canvas(mob/user,obj/item/canvas/new_canvas)
	if(istype(new_canvas, /obj/item/canvas/drawingtablet)) // NO FINALIZING THIS BITCH.
		return FALSE
	else
		return ..()

/obj/item/canvas/var/nooverlayupdates = FALSE

/obj/item/canvas/update_overlays()
	if(nooverlayupdates)
		return
	. = ..()

/datum/action/item_action/dtselectcolor
	name = "Change Color"
	desc = "Change your color."
	button_icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcolormenu
	name = "Color Menu"
	desc = "Select, save, or delete a color in your tablet's color menu!"
	button_icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcleargrid
	name = "Clear Canvas"
	desc = "Clear the canvas of your drawing tablet."
	button_icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

// Donation reward for DrpMstr
/obj/item/clothing/suit/costume/butter
	name = "butter costume"
	desc = "Made from only the highest quality cardboard. Caution, contents include Slime and Butter, do not ingest."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "butterbox"
	inhand_icon_state = "butterbox"

//Donation reward for Thedragmeme
/obj/item/bouquet/stellar
	name = "stellar bouquet"
	desc = "An elaborate mix of flowers that shimmer delicately in the light. Topped with a silver moon."
	icon_state = "starbouquet"
	inhand_icon_state = "starbouquet"
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'

// Donation reward for Thedragmeme
/obj/item/clothing/neck/padded
	name = "feathered serenity cloak"
	desc = "A meticulously handcrafted cloak that is lined with subtle pockets filled with feathers and down. Its design matches common styles from the followers of Univitarium."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "paddedscarf"
	inhand_icon_state = "paddedscarf"
	/// The typepath of the hood that gets created
	var/hood_type = /obj/item/clothing/head/hooded/padded

/obj/item/clothing/neck/padded/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/toggle_attached_clothing,\
		deployable_type = hood_type,\
		equipped_slot = ITEM_SLOT_HEAD,\
		action_name = "Toggle Hood",\
		on_deployed = CALLBACK(src, PROC_REF(on_deployed)),\
	)

//Bandaid fix because obscurity is broken D:
/obj/item/clothing/neck/padded/proc/on_deployed()
	var/mob/wearer = loc
	wearer.update_body()

//Donation reward for Thedragmeme
//Have I reached suspiciously wealthy furry status yet? /j
/obj/item/clothing/under/sweater_dress
	name = "virgin killer sweater"
	desc = "A meticulously knitted sweater that shows off ALL the right places. This is BARELY considered work attire."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "virginslayer"
	inhand_icon_state = "virginslayer"

/obj/item/clothing/suit/jacket/bomber_donor
	name = "old hoodie"
	desc = "A somewhat well worn jacket, appears to be way too big considering who owns it."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "bomber"
	inhand_icon_state = "bomber"

//Donation reward for Thedragmeme, gift for ActualVanguard
/obj/item/clothing/neck/padded/security
	name = "vanguard cloak"
	desc = "A meticulously handcrafted cloak that is lined with subtle pockets filled with feathers and down. Oddly enough, you always feel comfortable regardless of the weather. Even odder, there is an ever so faint scent of wet rock on the interior of the cloak."
	icon_state = "paddedsec"
	inhand_icon_state = "paddedsec"
	hood_type = /obj/item/clothing/head/hooded/padded/security

/obj/item/clothing/head/hooded/padded/security
	name = "vanguard cloak hood"
	icon_state = "paddedsechood"

/obj/item/clothing/head/hooded/padded
	name = "feathered serenity hood"
	icon_state = "paddedhood"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

// Donation reward for Thedragmeme
/obj/item/clothing/under/padded
	name = "feathered serenity suit"
	desc = "A meticulously handcrafted suit that is lined on the inside with feathers and down."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "paddedunder"
	inhand_icon_state = "paddedunder"

// Donation reward for Thedragmeme
/obj/item/clothing/shoes/jackboots/padded
	name = "serenity jackboots"
	desc = "Thick boots that is lined with feathers and down. Good footwear almost anticipating harsh weather."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "paddedboots"
	inhand_icon_state = "paddedboots"

// Donation reward for Thedragmeme and snailomi
/obj/item/clothing/gloves/padded
	name = "serenity gloves"
	desc = "A pair of gloves lined with soft to the touch fur."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "paddedgloves"
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	inhand_icon_state = "paddedgloves"

// Donation reward for snailomi
/obj/item/clothing/under/padded/alt
	name = "feathered serenity dress"
	desc = "A meticulously handcrafted dress that is lined on the inside with feathers and down. Twirling in this dress provides a satisfying result!"
	icon_state = "paddeddress"
	inhand_icon_state = "paddeddress"

// Donation reward for snailomi
/obj/item/clothing/neck/padded/alt
	name = "feathered serenity cloak"
	desc = "A meticulously handcrafted cloak that is lined with subtle pockets filled with feathers and down. Its design matches common styles from the followers of Univitarium."
	icon_state = "paddedscarfalt"
	inhand_icon_state = "paddedscarfalt"
	hood_type = /obj/item/clothing/head/hooded/padded/alt

/obj/item/clothing/head/hooded/padded/alt
	name = "feathered serenity hood"
	icon_state = "paddedhoodalt"

/datum/armor/clothing_under/none

/obj/item/clothing/shoes/jackboots/heel
	name = "high-heeled jackboots"
	desc = "Almost like regular jackboots... why are they on a high heel?"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "heel-jackboots"
	supports_variations_flags = NONE
	uses_advanced_reskins = FALSE
	unique_reskin = NONE

/obj/item/clothing/shoes/jackboots/heel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/master_files/sound/effects/heel1.ogg' = 1, 'modular_nova/master_files/sound/effects/heel2.ogg' = 1), 50)

// Donation reward for Bloodrite
/obj/item/clothing/shoes/clown_shoes/britches
	desc = "The prankster's standard-issue clowning shoes. They look extraordinarily cute. Ctrl-click to toggle waddle dampeners."
	name = "Britches' shoes"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "clown_shoes_cute"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/under/rank/civilian/clown/britches
	name = "Britches' dress"
	desc = "<i>'HONK!' (but cute)</i>"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "clowndress"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/mask/gas/britches
	name = "Britches' mask"
	desc = "A true prankster's facial attire. Cute."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "cute_mask"
	inhand_icon_state = null
	dye_color = "clown"
	supports_variations_flags = NONE
	clothing_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

/******CALIGRA DONATIONS******/
// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight
	name = "\improper FIR-36 half-face rebreather"
	desc = "A close-fitting respirator designed by Forestfel Intersystem Industries and originally meant for Ixian Tajarans, the FIR-36 Rebreather is commonly used by Military and Civilian Personnel alike. It reeks of Militarism."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "fir36"
	actions_types = list(/datum/action/item_action/adjust)
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS //same flags as actual sec hailer gas mask
	flags_inv = HIDEFACE | HIDESNOUT
	flags_cover = NONE
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/mask/gas/nightlight/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/nightlight/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/nightlight/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to adjust it.")

/obj/item/clothing/mask/gas/nightlight/alldono //different itempath so regular donators can have it, too

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight/fir22
	name = "\improper FIR-22 full-face rebreather"
	desc = "A full-face respirator designed by Forestfel Intersystem Industries and originally meant for Ixian Tajarans, the FIR-22 Rebreather is a snout-covering variant often seen used by Tajaran Military Personnel. It reeks of militarism."
	icon_state = "fir22"

/obj/item/clothing/mask/gas/caligram_visage_mask
	name = "\improper Caligram visage mask"
	desc = "An Ixian Tajaran mask commonly worn by Talicana monks that features a braided internals line and food consumption port. It bears the blue and red rank-stripes of a Caligram First Ensign."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "caligram_visage"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS //same flags as actual sec hailer gas mask
	flags_inv = HIDEFACE | HIDESNOUT
	flags_cover = NONE
	visor_flags = MASKCOVERSEYES | PEPPERPROOF
	visor_flags_inv = HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	tint = 0

// Donation reward for Raxraus
/obj/item/clothing/head/caligram_cap
	name = "\improper Caligram softcap"
	desc = "A Caligram's Fleet-branded hat."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "caligram_cap_tan"
	unique_reskin = list(
		"Tan" = "caligram_cap_tan",
		"Navy" = "caligram_cap_navy",
	)

// Donation reward for Raxraus
/obj/item/clothing/under/jumpsuit/caligram_fatigues
	name = "\improper Caligram fatigues"
	desc = "A set of work fatigues bearing a Caligram's Fleet insigna on an armband. Lacks the typical Tajaran extravagance."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "caligram_fatigues_tan"
	worn_icon_state = "caligram_fatigues_tan"
	unique_reskin = list(
		"Tan" = "caligram_fatigues_tan",
		"Navy" = "caligram_fatigues_navy",
	)

// Donation reward for Raxraus
/obj/item/clothing/suit/jacket/caligram_parka
	name = "\improper Caligram parka"
	desc = "A parka with a fancy belt and '/Caligram's Fleet/' stitched onto its armband."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_tan"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	unique_reskin = list(
		"Tan" = "caligram_parka_tan",
		"Navy" = "caligram_parka_navy",
	)

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/caligram_parka_vest
	name = "\improper Caligram armored parka"
	desc = "A parka with a fancy belt, a lightly armored vest and '/Caligram's Fleet/' stitched onto its armband."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_vest_tan"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	unique_reskin = list(
		"Tan" = "caligram_parka_vest_tan",
		"Navy" = "caligram_parka_vest_navy",
	)


// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/brasspriest
	name = "brasspriest coat"
	desc = "A reddish coat with brass-clad parts embed into said coat. You can hear the faint noise of some cogs turning from time to time inside."
	icon_state = "brasspriest"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS

// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/hydrogenrobes
	name = "metallic-hydrogen robes"
	desc = "An incredibly shiny dress that seems to be covered in a very thin sheet of metallic hydrogen all over the textiles. Not very protective."
	icon_state = "hydrogenrobes"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'

// Donation reward for ChillyLobster

/obj/item/clothing/under/wetsuit_norm
	name = "fitted wetsuit"
	desc = "A fitted wetsuit for trapping in heat and water. Protects against outside elements ever-so-slightly."
	icon_state = "wetsuit"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for TheOOZ
/obj/item/clothing/mask/animal/wolf
	name = "wolf mask"
	desc = "A dark mask in the shape of a wolf's head."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "kindle"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	inhand_icon_state = "gasmask_captain"
	animal_type = "wolf"
	unique_death = 'modular_nova/master_files/sound/effects/wolfhead_curse.ogg'
	visor_flags_inv = HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	use_radio_beeps_tts = TRUE

/obj/item/clothing/mask/animal/wolf/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/mask/gas/sechailer/sechailer_type = /obj/item/clothing/mask/gas/sechailer
	voice_filter = initial(sechailer_type.voice_filter)

// Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "skull of an ashdrake"
	desc = "How did they get this?"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "Blutigen wraps"
	desc = "The one who wears these had everything and yet lost it all..."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "Blutigen kimono"
	desc = "For the eyes bestowed upon this shall seek adventure..."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "Dragon undergarments"
	desc = "The Dragon wears the sexy?"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/gloves/ring/hypno
	var/list/spans = list()
	actions_types = list(/datum/action/item_action/hypno_whisper)

// Donation reward for CoffeePot
/obj/item/clothing/gloves/ring/hypno/coffeepot
	name = "hypnodemon's ring"
	desc = "A pallid, softly desaturated-looking gold ring that doesn't look like it belongs. It's hard to put one's finger on why it feels at odds with the world around it - the shine coming off it looks like it could be a mismatch with the lighting in the room, or it could be that it seems to glint and twinkle occasionally when there's no obvious reason for it to - though only when you're not really looking."
	spans = list("velvet")

// Donation reward for Bippys
/obj/item/clothing/gloves/ring/hypno/bippys
	name = "hypnobot hexnut"
	desc = "A silver bolt component that once belonged to a very peculiar IPC. It's large enough to be worn as a ring on nearly any finger, and is said to amplify the voice of one's mind to another's in the softness of a Whisper..."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	spans = list("hexnut")

/datum/action/item_action/hypno_whisper
	name = "Hypnotic Whisper"

/obj/item/clothing/gloves/ring/hypno/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a hypnotic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

// Donation reward for SlippyJoe
/obj/item/clothing/head/avipilot
	name = "smuggler's flying cap"
	desc = "Shockingly, despite space winds, and the lack of any practicality, this pilot cap seems to be fairly well standing, there's a rabbit head seemingly stamped into the side of it."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "avipilotup"
	inhand_icon_state = "rus_ushanka"
	flags_inv = HIDEEARS|HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT //about as warm as an ushanka
	actions_types = list(/datum/action/item_action/adjust)
	supports_variations_flags = NONE
	var/goggles = FALSE

/obj/item/clothing/head/avipilot/proc/adjust_goggles(mob/living/carbon/user)
	if(user?.incapacitated)
		return
	if(goggles)
		icon_state = "avipilotup"
		to_chat(user, span_notice("You put all your effort into pulling the goggles up."))
	else
		icon_state = "avipilotdown"
		to_chat(user, span_notice("You focus all your willpower to put the goggles down on your eyes."))
	goggles = !goggles
	if(user)
		user.update_worn_head()
		user.update_mob_action_buttons()

/obj/item/clothing/head/avipilot/ui_action_click(mob/living/carbon/user, action)
	adjust_goggles(user)

/obj/item/clothing/head/avipilot/attack_self(mob/living/carbon/user)
	adjust_goggles(user)

// Donation reward for NetraKyram - public use allowed via the command vendor
/obj/item/clothing/under/rank/captain/dress
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	name = "captain's dress"
	desc = "It's a blue dress with some worn-gold markings denoting the rank of \"Captain\"."
	icon_state = "dress_cap_s"
	worn_icon_state = "dress_cap_s"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

// Donation reward for NetraKyram
/obj/item/clothing/under/rank/blueshield/netra
	name = "black and silver armored dress"
	desc = "An ankle length black and silver dress, made out of some shiny synthetic material with inlaid kevlar shards and silver reinforcements, a silver ring surrounds the collar, and it doesn't appear to have a zipper... How does somebody put this thing on anyways?"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "silver_dress"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation reward for NetraKyram
/obj/item/clothing/gloves/netra
	name = "black and silver gloves"
	desc = "Some black gloves with silver reinforcements, made of a shiny synthetic material."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "silver_dress_gloves"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for NetraKyram
/obj/item/clothing/shoes/jackboots/netra
	name = "polished jackboots"
	desc = "Some standard issue jackboots, spit-shined to a reflective sheen, wreaking of the scent of silicon parade polish."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	icon_state = "silver_dress_boots"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	supports_variations_flags = NONE
	uses_advanced_reskins = FALSE


/****************LEGACY REWARDS***************/
// Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "Kiara's cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

// Donation reward for inferno707
/obj/item/clothing/neck/inferno_collar
	name = "Kiara's collar"
	desc = "A soft black collar that seems to stretch to fit whoever wears it."
	icon_state = "infcollar"
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	alternate_worn_layer = UNDER_SUIT_LAYER
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/inferno_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small)
	atom_storage.set_holdable(/obj/item/food/cookie)
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/inferno_collar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Kiara", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

// Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "Insignia Of Steele"
	desc = "An intricate pendant given to those who help a key member of the Steele Corporation."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

// Donation reward for inferno707
/obj/item/toy/darksabre
	name = "Kiara's sabre"
	desc = "This blade looks as dangerous as its owner."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_nova/master_files/icons/donator/obj/custom.dmi', "darksheath-darksabre")

// Donation reward for inferno707
/obj/item/storage/belt/sabre/darksabre
	name = "ornate sheathe"
	desc = "An ornate and rather sinister looking sabre sheathe."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksheath"
	worn_icon_state = "darksheath"

/obj/item/storage/belt/sabre/darksabre/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/toy/darksabre
		))

/obj/item/storage/belt/sabre/darksabre/PopulateContents()
	new /obj/item/toy/darksabre(src)
	update_icon()

// Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "dark armor"
	desc = "A dark, non-functional piece of armor sporting a red and black finish."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	supports_variations_flags = NONE
	armor_type = /datum/armor/none

// Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "It's an odd ceramic mask. Set in the internal side are several suspicious electronics branded by Steele Tech."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	supports_variations_flags = NONE

/obj/item/clothing/mask/hheart/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Toggle the color of the hollow heart."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_worn_mask()
		ooser.update_mob_action_buttons()
		to_chat(ooser, span_notice("You toggle the [src] to [possible_colors[c_color_index]]."))

// Donation reward for asky / Zulie
/obj/item/clothing/suit/hooded/cloak/zuliecloak
	name = "Project: Zul-E"
	desc = "A standard version of a prototype cloak given out by Nanotrasen higher ups. It's surprisingly thick and heavy for a cloak despite having most of its tech stripped. It also comes with a bluespace trinket which calls its accompanying hat onto the user. A worn inscription on the inside of the cloak reads 'Fleuret' ...the rest is faded away."
	icon_state = "zuliecloak"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/zuliecloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE

/obj/item/clothing/head/hooded/cloakhood/zuliecloak
	name = "NT special issue"
	desc = "This hat is unquestionably the best one, bluespaced to and from CentCom. It smells of Fish and Tea with a hint of antagonism"
	icon_state = "zuliecap"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = null
	supports_variations_flags = NONE

// Donation reward for Lyricalpaws
/obj/item/clothing/neck/cloak/healercloak
	name = "legendary healer's cloak"
	desc = "Worn by the most skilled professional medics on the station, this legendary cloak is only attainable by becoming the pinnacle of healing. This status symbol represents the wearer has spent countless years perfecting their craft of helping the sick and wounded."
	icon_state = "healercloak"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'

// Donation reward for Kathrin Bailey / Floof Ball
/obj/item/clothing/under/custom/lannese
	name = "Lannese dress"
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "lannese"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	inhand_icon_state = "firefighter"
	can_adjust = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|LEGS|FEET

/obj/item/clothing/under/custom/lannese/vambrace
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan. Shiny vambraces included!"
	icon_state = "lannese_vambrace"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET

// Donation reward for Hacker T.Dog
/obj/item/clothing/suit/scraparmour
	name = "scrap armour"
	desc = "A shoddily crafted piece of armour. It provides no benefit apart from being clunky."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "scraparmor"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "scraparmor"
	body_parts_covered = CHEST

// Donation reward for Enzoman
/obj/item/clothing/mask/luchador/enzo
	name = "mask of El Red Templar"
	desc = "A mask belonging to El Red Templar, a warrior of lucha. Taking it from him is not recommended."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "luchador"
	worn_icon_state = "luchador"
	clothing_flags = MASKINTERNALS
	supports_variations_flags = NONE

// Donation Reward for Grand Vegeta
/obj/item/clothing/under/mikubikini
	name = "starlight singer bikini"
	desc = " "
	icon_state = "mikubikini"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_state = "mikubikini"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation Reward for Grand Vegeta
/obj/item/clothing/suit/mikujacket
	name = "starlight singer jacket"
	desc = " "
	icon_state = "mikujacket"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mikujacket"

// Donation Reward for Grand Vegeta
/obj/item/clothing/head/mikuhair
	name = "starlight singer hair"
	desc = " "
	icon_state = "mikuhair"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mikuhair"
	flags_inv = HIDEHAIR

// Donation Reward for Grand Vegeta
/obj/item/clothing/gloves/mikugloves
	name = "starlight singer gloves"
	desc = " "
	icon_state = "mikugloves"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'
	worn_icon_state = "mikugloves"

// Donation Reward for Grand Vegeta
/obj/item/clothing/shoes/sneakers/mikuleggings
	name = "starlight singer leggings"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	desc = " "
	icon_state = "mikuleggings"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	worn_icon_state = "mikuleggings"

// Donation reward for CandleJax
/obj/item/clothing/mask/gas/CMCP_mask
	name = "\improper CMCP 'Oni' Faceplate"
	desc = "A modular faceplate mount. Typically meant to be attached to field platforms."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "yoni"
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	use_radio_beeps_tts = TRUE
	flags_inv = NONE

/obj/item/clothing/mask/gas/CMCP_mask/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/mask/gas/sechailer/sechailer_type = /obj/item/clothing/mask/gas/sechailer
	voice_filter = initial(sechailer_type.voice_filter)

// Donation reward for Koruu
/obj/item/clothing/mask/gas/signalis_gaiter
	name = "synthetic nanofiber gaiter"
	desc = "A slim black synthetic cloth that covers the mouth. Often in used by the S.O.K.O Models. "
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "siggaiter"
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	actions_types = list(/datum/action/item_action/adjust)
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	use_radio_beeps_tts = TRUE
	flags_inv = NONE
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/mask/gas/signalis_gaiter/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/mask/gas/sechailer/sechailer_type = /obj/item/clothing/mask/gas/sechailer
	voice_filter = initial(sechailer_type.voice_filter)

/obj/item/clothing/mask/gas/signalis_gaiter/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/signalis_gaiter/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/signalis_gaiter/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to adjust it.")

// Donation reward for Koruu
/obj/item/clothing/under/bodysuit_koruu
	name = "synthetic nanofiber Automaton bodysuit"
	desc = "A slim and body fitting suit often equipped by most Automaton Units. Durable, with an emphasis on flexibility, but it can be seen as rather risqué."
	body_parts_covered = CHEST|GROIN
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "bodysuitkoruu"
	unique_reskin = list(
		"Navy" = "bodysuitkoruu",
		"White" = "bodysuitkoruu_alt",
	)

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax2
	name = "azulean's environment helmet"
	desc = "An Azulean-made Enviro-Helmet, adjusted for the unique skull shape typical of the species. Alongside the standard features, it includes an embossment of the Azulean Crest on the back of the helmet."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "anahead"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax
	name = "emission's containment suit"
	desc = "A modified envirosuit featuring a reserved color scheme."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "emissionsuit"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax2
	name = "azulean's environment suit"
	desc = "A form-fitting and modified bodysuit designed to fit the Akulean body. Embossments of the formal crest of the Kingdom of Agurkrral are seen on the shoulderpads."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "ana_envirosuit"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/jax2
	name = "xuracorp hazard underfitting"
	desc = "A hazard suit fitted with bio-resistant fibers. Utilizes self-sterilizing pumps fitted in the back."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "plasmaman_jax"

// Donation reward for snakebitenn
/datum/action/item_action/adjust/psychomalicek/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/clothing/mask/gas/psycho_malice/psycho_malice = target
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		psycho_malice.adjust_mask(usr)
	else
		psycho_malice.reskin_obj(usr)

/obj/item/clothing/mask/gas/psycho_malice
	name = "composite filtration mask"
	desc = "Less of a mask and more of a second face, this device was primarily useful for climate-adjustment and keeping unwanted gasses and particulates out of whoever it's on. However, it's since been adapted into a faceplate for use by humanoid machines."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "psychomalice"
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	flags_inv = HIDEEARS|HIDEEYES|HIDESNOUT|HIDEFACIALHAIR
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	interaction_flags_click = NEED_DEXTERITY
	/// Whether or not the mask is currently being layered over (or under!) hair. FALSE/null means the mask is layered over the hair (this is how it starts off).
	var/wear_hair_over

/obj/item/clothing/mask/gas/psycho_malice/examine(mob/user)
	. = ..()
	. += span_notice("You can toggle its ability to muffle your TTS voice with <b>control click</b>.")

/obj/item/clothing/mask/gas/psycho_malice/item_ctrl_click(mob/user)
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING
	if(user.get_active_held_item() != src)
		to_chat(user, span_warning("You must hold the [src] in your hand to do this!"))
		return CLICK_ACTION_BLOCKING
	voice_filter = voice_filter ? null : initial(voice_filter)
	to_chat(user, span_notice("Mask voice muffling [voice_filter ? "enabled" : "disabled"]."))
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/psycho_malice/Initialize(mapload)
	. = ..()
	register_context()
	if(wear_hair_over)
		alternate_worn_layer = BACK_LAYER

/obj/item/clothing/mask/gas/psycho_malice/click_alt_secondary(mob/user)
	adjust_mask(user)

//this moves the mask above or below the hair layer
/obj/item/clothing/mask/gas/psycho_malice/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated)
		var/is_worn = user.wear_mask == src
		wear_hair_over = !wear_hair_over
		if(wear_hair_over)
			alternate_worn_layer = BACK_LAYER
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair over the mask.")
		else
			alternate_worn_layer = initial(alternate_worn_layer)
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair under the mask.")

		user.update_worn_mask()

/obj/item/clothing/mask/gas/psycho_malice/dropped(mob/living/carbon/human/user)
	var/prev_alternate_worn_layer = alternate_worn_layer
	. = ..()
	alternate_worn_layer = prev_alternate_worn_layer

// Donation reward for Raxraus
/obj/item/clothing/shoes/combat/rax
	name = "tactical boots"
	desc = "Tactical and sleek. This model seems to resemble an armament manufacturer retired long ago."
	icon = 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/feet.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/feet_digi.dmi'
	icon_state = "armadyne_boots"
	worn_icon_state = "armadyne_boots"

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/warden/rax
	name = "peacekeeper jacket"
	desc = "A navy-blue armored jacket with blue shoulder designations."

// Donation reward for Raxraus
/obj/item/clothing/under/rank/security/rax
	name = "banded uniform"
	desc = "Personalized and tailored to fit, this uniform is designed to protect without compromising its stylishness."
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "hos_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for DeltaTri
/obj/item/clothing/suit/jacket/delta
	name = "grey winter hoodie"
	desc = "A plain old grey hoodie. It has some puffing on the inside, and a animal fur trim around half of the hood."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "greycoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for Cherno_00
/obj/item/clothing/suit/jacket/cherno
	name = "silver-buttoned coat"
	desc = "A comfy-looking blue coat. It looks a bit fancy, with shiny silver buttons and a few belts!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "chernocoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for GoldenAlpharex
/obj/item/clothing/glasses/welding/steampunk_goggles
	name = "steampunk goggles"
	desc = "This really feels like something you'd expect to see sitting on top of a certain ginger's head... They have a rather fancy brass trim around the lenses."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "goldengoggles"
	slot_flags = ITEM_SLOT_EYES | ITEM_SLOT_HEAD // Making it fit in both first just so it can properly fit on the head slot in the loadout
	flash_protect = FLASH_PROTECTION_NONE
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null // Don't want that to go in the autolathe
	visor_vars_to_toggle = 0
	tint = 0

	/// Was welding protection added yet?
	var/welding_upgraded = FALSE
	/// Was welding protection toggled on, if welding_upgraded is TRUE?
	var/welding_protection = FALSE
	/// The sound played when toggling the shutters.
	var/shutters_sound = 'sound/effects/clock_tick.ogg'

/obj/item/clothing/glasses/welding/steampunk_goggles/Initialize(mapload)
	. = ..()
	visor_toggling()

/obj/item/clothing/glasses/welding/steampunk_goggles/examine(mob/user)
	. = ..()
	if(welding_upgraded)
		. += "It has been upgraded with welding shutters, which are currently [welding_protection ? "closed" : "opened"]."

/obj/item/clothing/glasses/welding/steampunk_goggles/item_action_slot_check(slot, mob/user)
	. = ..()
	if(. && (slot & ITEM_SLOT_HEAD))
		return FALSE

/obj/item/clothing/glasses/welding/steampunk_goggles/attack_self(mob/user)
	if(user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_warning("You can't seem to slip those on your eyes from the top of your head!"))
		return
	. = ..()

/obj/item/clothing/glasses/welding/steampunk_goggles/visor_toggling()
	. = ..()
	slot_flags = up ? ITEM_SLOT_EYES | ITEM_SLOT_HEAD : ITEM_SLOT_EYES
	toggle_vision_effects()

/obj/item/clothing/glasses/welding/steampunk_goggles/adjust_visor(mob/user)
	. = ..()
	handle_sight_updating(user)

/obj/item/clothing/glasses/welding/steampunk_goggles/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/clothing/glasses/welding))
		return ..()

	if(welding_upgraded)
		to_chat(user, span_warning("\The [src] was already upgraded to have welding protection!"))
		return
	qdel(attacking_item)
	welding_upgraded = TRUE
	to_chat(user, span_notice("You upgrade \the [src] with some welding shutters, offering you the ability to toggle welding protection!"))
	actions += new /datum/action/item_action/toggle_steampunk_goggles_welding_protection(src)

/// Proc that handles the whole toggling the welding protection on and off, with user feedback.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_shutters(mob/user)
	if(!can_use(user) || !user)
		return FALSE
	if(!toggle_welding_protection(user))
		return FALSE

	to_chat(user, span_notice("You slide \the [src]'s welding shutters slider, [welding_protection ? "closing" : "opening"] them."))
	playsound(user, shutters_sound, 100, TRUE)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.update_worn_head()
	update_item_action_buttons()
	return TRUE

/// This is the proc that handles toggling the welding protection, while also making sure to update the sight of a mob wearing it.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_welding_protection(mob/user)
	if(!welding_upgraded)
		return FALSE
	welding_protection = !welding_protection

	visor_vars_to_toggle = welding_protection ? VISOR_FLASHPROTECT | VISOR_TINT : initial(visor_vars_to_toggle)
	toggle_vision_effects()
	// We also need to make sure the user has their vision modified. We already checked that there was a user, so this is safe.
	handle_sight_updating(user)
	return TRUE

/// Proc handling changing the flash protection and the tint of the goggles.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_vision_effects()
	if(welding_protection)
		if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
			flash_protect = up ? FLASH_PROTECTION_NONE : FLASH_PROTECTION_WELDER
	else
		flash_protect = FLASH_PROTECTION_NONE
	tint = flash_protect

/// Proc handling to update the sight of the user, while forcing an update_tint() call every time, due to how the welding protection toggle works.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/handle_sight_updating(mob/user)
	if(user && (user.get_item_by_slot(ITEM_SLOT_HEAD) == src || user.get_item_by_slot(ITEM_SLOT_EYES) == src))
		user.update_sight()
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			carbon_user.update_tint()
			carbon_user.update_worn_head()

/obj/item/clothing/glasses/welding/steampunk_goggles/ui_action_click(mob/user, actiontype, is_welding_toggle = FALSE)
	if(!is_welding_toggle)
		return ..()
	else
		toggle_shutters(user)

/// Action button for toggling the welding shutters (aka, welding protection) on or off.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection
	name = "Toggle Welding Shutters"

/// We need to do a bit of code duplication here to ensure that we do the right kind of ui_action_click(), while keeping it modular.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection/Trigger(trigger_flags)
	if(!IsAvailable())
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	if(!target || !istype(target, /obj/item/clothing/glasses/welding/steampunk_goggles))
		return FALSE

	var/obj/item/clothing/glasses/welding/steampunk_goggles/goggles = target
	goggles.ui_action_click(owner, src, is_welding_toggle = TRUE)
	return TRUE

// End of the code for GoldenAlpharex's donator item :^)

// Donation reward for MyGuy49
/obj/item/clothing/suit/cloak/ashencloak
	name = "ashen wastewalker cloak"
	desc = "A cloak of advanced make. Clearly beyond what ashwalkers are capable of, it was probably pulled from a downed vessel or something. It seems to have been reinforced with goliath hide and watcher sinew, and the hood has been torn off."
	icon_state = "ashencloak"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|LEGS|ARMS
	supports_variations_flags = NONE

//Donation reward for Hacker T.Dog
/obj/item/clothing/head/nanotrasen_consultant/hubert
	name = "CC ensign's cap"
	desc = "A tailor made peaked cap, denoting the rank of Ensign."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "CCofficerhat"

//Donation reward for Hacker T.Dog
/obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	name = "CC ensign's armoured vest"
	desc = "A tailor made Ensign's armoured vest, providing the same protection - but in a more stylish fashion."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "CCvest"

//Donation reward for Hacker T.Dog
/obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	name = "CC ensign's uniform"
	desc = "A tailor-made Ensign's uniform, various medals and chains hang down from it."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "CCofficer"

// Donation reward for Cherno_00
/obj/item/clothing/head/costume/ushanka/frosty
	name = "blue ushanka"
	desc = "A dark blue ushanka with a hand-stitched snowflake on the front. Cool to the touch."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "fushankadown"
	upsprite = "fushankaup"
	downsprite = "fushankadown"

// Donation reward for M97screwsyourparents
/obj/item/clothing/neck/cross
	name = "silver cross"
	desc = "A silver cross to be worn on a chain around your neck. Certain to bring you favour from up above."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "cross"

// Donation reward for gamerguy14948
/obj/item/storage/belt/fannypack/occult
	name = "trinket belt"
	desc = "A belt covered in various trinkets collected through time. Doesn't look like there's much space for anything else nowadays."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/belt.dmi'
	icon_state = "occultfannypack"
	worn_icon_state = "occultfannypack"

// Donation reward for gamerguy14948
/obj/item/clothing/under/occult
	name = "occult collector's outfit"
	desc = "A set of clothes fit for someone dapper that isn't afraid of getting dirty."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "occultoutfit"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/head/hooded/occult
	name = "hood"
	desc = "Certainly makes you look more ominous."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "occulthood"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/suit/hooded/occult
	name = "occult collector's coat"
	desc = "A big, heavy coat lined with leather and ivory cloth, adorned with a hood. It looks dusty."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "occultcoat"
	hoodtype = /obj/item/clothing/head/hooded/occult
	supports_variations_flags = NONE

// Donation reward for Octus
/obj/item/clothing/mask/breath/vox/octus
	name = "sinister visor"
	desc = "Skrektastic."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	worn_icon_vox = 'modular_nova/master_files/icons/donator/mob/clothing/mask_vox.dmi'
	icon_state = "death"

// Donation reward for 1ceres
/obj/item/clothing/glasses/rosecolored
	name = "rose-colored glasses"
	desc = "Goggle-shaped glasses that seem to have a HUD-like feed in some odd line-based script. It doesn’t look like they were made by NT."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rose"

// Donation reward for Fuzlet
/obj/item/card/fuzzy_license
	name = "license to hug"
	desc = "A very official looking license. Not actually endorsed by Nanotrasen."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "license"

	var/possible_types = list(
		"hug",
		"snuggle",
		"cuddle",
		"kiss",
		"feed Dan Kelly",
		"hoard Shinzo Shore",
		"spoil friends",
		"hold hands",
		"have this license",
		"squeak",
		"cute",
		"pat",
		"administer plushies",
		"distribute cookies",
		"sex",
		"weh")

/obj/item/card/fuzzy_license/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [src.name]."), span_notice("You show \the [src.name]."))
	add_fingerprint(user)

/obj/item/card/fuzzy_license/attackby(obj/item/used, mob/living/user, params)
	if(user.ckey != "fuzlet")
		return

	if(istype(used, /obj/item/pen) || istype(used, /obj/item/toy/crayon))
		var/choice = input(user, "Select the license type", "License Type Selection") as null|anything in possible_types
		if(!isnull(choice))
			name = "license to [choice]"

// Donation reward for 1ceres
/obj/item/clothing/suit/jacket/gorlex_harness
	name = "engine technician harness"
	desc = "A blood-red engineering technician harness. You can't seem to figure out a use to it, but it seems to seal magnetically in some places."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "gorlexharness"

// Donation reward for 1ceres
/obj/item/poster/korpstech
	name = "\improper Empire Enhancements poster"
	poster_type = /obj/structure/sign/poster/contraband/korpstech
	icon = 'modular_nova/modules/aesthetics/posters/contraband.dmi'
	icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/korpstech
	name = "Empire Enhancements"
	desc = "This poster bears a huge, pink helix on it, with smaller text underneath it that mentions some alleged genetic advancements from a long time ago."
	icon = 'modular_nova/modules/aesthetics/posters/contraband.dmi'
	icon_state = "korpsposter"
	never_random = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/korpstech, 32)

// Donation reward for Kay-Nite
/obj/item/clothing/glasses/eyepatch/rosecolored
	name = "rose-colored eyepatch"
	desc = "A customized eyepatch with a bright pink HUD floating in front of it. It looks like there's more to it than just an eyepatch, considering the materials it's made of."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rosepatch"
	base_icon_state = "rosepatch"

// Donation reward for Cimika
/obj/item/clothing/suit/toggle/labcoat/nova/tenrai
	name = "Tenrai labcoat"
	desc = "A labcoat crafted from a variety of pristine materials, sewn together with a frightening amount of skill. The fabric is aery, smooth as silk, and exceptionally pleasant to the touch. The golden stripes are visible in the dark, working as a beacon to the injured. A small label on the inside of it reads \"Tenrai Kitsunes Supremacy\"."
	base_icon_state = "tenraicoat"
	icon_state = "tenraicoat"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/nova/tenrai/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

//Donation reward for RealWinterFrost
/obj/item/clothing/neck/cloak/fluffycloak
	name = "Cloak of the Fluffy One"
	desc = "Hugs and kisses is only what this one knows, may their hugs be for all and not for their own \"For Fuffy Use Only\"."
	icon_state = "fluffycloak"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/fluffycloak/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)


/obj/item/clothing/mask/gas/larpswat
	name = "Foam Force SWAT Mask"
	desc = "What seems to be a SWAT mask at first, is actually a gasmask that has replica parts of a SWAT mask made from cheap plastic. Hey at least it looks good if you enjoy looking like a security larper."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "larpswat"
	supports_variations_flags = NONE

// Donation reward for Cimika, on behalf of tf4
/obj/item/clothing/neck/fishpendant
	name = "fish necklace"
	desc = "A simple, silver necklace with a blue tuna pendant.\n\"L. Alazawi\" is inscribed on the back. You get the feeling it would go well with potatoes and green beans."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "fishpendant"

// Donation reward for Weredoggo
/obj/item/hairbrush/tactical
	name = "tactical hairbrush"
	desc = "Sometimes, after a brush with death, a good grooming is just the thing for tactical stress relief. "
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "tacticalbrush"
	inhand_icon_state = "tacticalbrush"

// Donation reward for ultimarifox
/obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	name = "black and red turtleneck"
	desc = "A black turtleneck with red livery attached. Reminds you of a time before the color blue. It seems padded to hell and back as well."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "hosaltred"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	name = "red-tinted giga HUD gar glasses"
	desc = "GIGA GAR glasses with a security hud implanted in the lens. Reminds you of a time before the color blue."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "supergarsred"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/eyes.dmi'

//Donation reward for Konstyantyn
/obj/item/clothing/accessory/badge/holo/jade
	name = "jade holobadge"
	desc = "A strangely green holobadge. 'Lieutenant Uriah' is stamped onto it, above the letters JS."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "greenbadge"

// Donation reward for Dudewithatude
/obj/item/clothing/suit/toggle/rainbowcoat
	name = "rainbow coat"
	desc = "A wonderfully brilliant coat that displays the color of the rainbow!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "rainbowcoat"
	base_icon_state = "rainbowcoat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/head/recruiter_cap
	name = "recruiter cap"
	desc = "Hey, free college!"
	icon_state = "officerhat"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "officerhat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/suit/toggle/recruiter_jacket
	name = "recruiter jacket"
	desc = "Hey, free college!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "officerjacket"
	base_icon_state = "officerjacket"

// Donation reward for M97screwsyourparents
/obj/item/clothing/under/recruiter_uniform
	name = "recruiter uniform"
	desc = "Hey, free college!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "oldmarine_whites"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null

//Donation reward for Tetrako
/obj/item/clothing/under/nt_idol_skirt
	name = "\improper NT Idol's suitskirt"
	desc = "This outfit resembles much the same as other ranking NT Officers, but comes with certain bells and whistles, like frills around the dress, slight puffs around the shoulders and most importantly, several golden buckles to accentuate the green! The only thing fit for NT's very own idols to wear!"
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for SlippyJoe
/obj/item/clothing/accessory/hypno_watch
	name = "cracked pocket watch"
	desc = "A shining pocket watch, cast in gold and embossed with metallic swirls that almost seem  amethyst under the right light... There's a button on the top to unlatch the front panel, although all that's inside is a layer of cracked glass, the argent hands stuck pointing to 7:07 PM. The brushed silver of these arrows almost seems to swirl if one's gaze lingers for too long. Despite its inert appearance, the eerie mechanical sound of gears turning and clicking in place seems to quietly ring out from the artifact. In the right hands..."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/hypno_watch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a hypnotic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

/obj/item/clothing/accessory/hypno_watch/examine()
	. = ..()
	. += span_boldwarning("Who knows what it could be used for?")

// Donation reward for BoisterousBeebz

/obj/item/clothing/under/bubbly_clown/skirt
	name = "bubbly clown dress"
	desc = "A bright and cheerful clown dress, honk!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bubbly_clown_dress"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Sweetsoulbrother
/obj/item/coin/donator/marsoc
	name = "MARSOC Challenge Coin"
	desc = "This is a challenge coin given to all MARSOC members upon honorable separation from the Corps. \
			The coin has the insignia of the Marine Special Operations Command on one side, and the Sol Federation Marine Corps logo on the other. \
			This one has an engraving on the Marine Corps logo side, etched in a circle around it: \
			\"To Staff Sargent Henry Rockwell, for his exemplary service to the Special Operations community and his outstanding moral fiber \
			and shining example to the core values of the Sol Federation Marine Corps.\""
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	sideslist = list("MARSOC", "SFMC")

// Donation reward for Kay-Nite
/obj/item/clothing/under/tactichill
	name = "tactichill jacket"
	desc = "The brighter variant of the tacticool clotheswear, for when you want to look even cooler than usual and still operate at the same time."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "tactichill"

// Donation reward for thedragmeme and snailom
/obj/item/clothing/shoes/fancy_heels/drag
	desc = "A fancy pair of high heels. Clack clack clack... definitely turning a lot of heads."

/obj/item/clothing/shoes/fancy_heels/drag/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_nova/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)

// Donation reward for Razurath

/obj/item/clothing/under/bimpcap
	name = "Formal Matte Black Captain Uniform"
	desc = "A professional looking matte black uniform cladded with medals of distintive service and valor, only worn by the highest of station officials."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bimpcap"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Nikohyena
/obj/item/clothing/glasses/gold_aviators
	name = "purple and gold aviators"
	desc = "A round pair of gold aviator glasses, the lenses having been applied with a gem-like purple tint."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "goldaviator"

// Donation reward for Sigmar Alkahest
/obj/item/clothing/under/costume/nova/kimono/sigmar
	name = "short-sleeved kimono"
	desc = "A traditional ancient Earth Japanese Kimono. It's white with a gold trim and burnished gold ivy pattern."
	icon_state = "kimono-gold"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'

// Donation reward for Sigmar Alkahest
/obj/item/clothing/head/hooded/sigmarcoat
	name = "black raincoat hood"
	desc = "Certainly makes you look more ominous."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "long-coat-hood"
	supports_variations_flags = NONE

// Donation reward for Sigmar Alkahest
/obj/item/clothing/suit/hooded/sigmarcoat
	name = "black open-faced raincoat"
	desc = "A light black raincoat. You didn't even know they're made in this color."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "long-coat"
	hoodtype = /obj/item/clothing/head/hooded/sigmarcoat
	supports_variations_flags = NONE

// Donation reward for Sonicgotnuked

/obj/item/clothing/gloves/ring/hypno/nuke
	name = "suspiciously glossy ring"
	desc = "This ring oozes with an assertive edge as sharp light bends along the smooth, black bronze. Like the finger that wears it, an exceptional amount of polish repels nearly all the light that glances along its surface. If you look closer, a slight golden hue indicates the precious metals inside the alloy."
	icon = 'modular_nova/master_files/icons/obj/ring.dmi'
	icon_state = "ringblack"
	spans = list("glossy")

//reward for SomeRandomOwl
/obj/item/clothing/head/costume/owlhat
	name = "starry witch hat"
	desc = "A cute witch hat typically worn by a random owl that can sometimes be spotted on station."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_teshari = 'modular_nova/master_files/icons/donator/mob/clothing/head_teshari.dmi'
	icon_state = "owlhat"
	worn_y_offset = 2

//Donation reward for Razurath
/obj/item/clothing/head/razurathhat
	name = "Golden Nanotrasen Officer Cap"
	desc = "A Nanotrasen officer cap. Now darker, golder, and cooler!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "razurath_hat"

//Donation reward for Razurath
/obj/item/clothing/suit/razurathcoat
	name = "Golden Nanotrasen Officer Coat"
	desc = "A fancy Nanotrasen officer coat. Now darker, golder, and cooler than ever!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "razurath_coat"

// Donation reward for MaSvedish
/obj/item/holocigarette/masvedishcigar
	name = "holocigar"
	desc = "A soft buzzing device that, using holodeck technology, replicates a slow burn cigar. Now with less-shock technology. It has a small inscription of 'MG' on the golden label."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/mask.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	inhand_icon_state = "masvedishcigar_off"
	worn_icon_state = "masvedishcigar_off"
	icon_state = "masvedishcigar_off"
	icon_on = "masvedishcigar_on"
	icon_off = "masvedishcigar_off"

// Donation reward for LT3
/obj/item/clothing/suit/armor/skyy
	name = "silver jacket mk II"
	desc = "A jacket for those with a commanding presence. Made of synthetic fabric, it's interwoven with a special alloy that provides extra protection and style."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/skyy
	name = "silver jacket"
	desc = "A jacket for those with a commanding presence. Made of synthetic fabric, it's interwoven with a special alloy that provides extra protection and style."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/pants/skyy
	name = "silver jeans"
	desc = "A pair of jeans for those with a commanding presence. Made of shining, silver denim, it's interwoven with a special alloy that provides extra protection and style."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "lt3_jeans"
	inhand_icon_state = "lt3_jeans"

/obj/item/clothing/gloves/skyy
	name = "charcoal fingerless gloves"
	desc = "Valuing form over function, these gloves barely cover more than the palm of your hand."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "lt3_gloves"

// Donation reward for Lolpopomg101
/obj/item/clothing/suit/hooded/colorblockhoodie
	name = "color-block hoodie"
	desc = "A soft pastel color-block hoodie from an unrecognizable brand."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "colorblockhoodie"
	hoodtype = /obj/item/clothing/head/hooded/colorblockhoodie
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/colorblockhoodie
	name = "hood"
	desc = "Very soft on the inside!"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "colorblockhood"
	flags_inv = HIDEHAIR

/obj/item/clothing/suit/toggle/digicoat
	toggle_noun = "holo-display"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Public donation reward for Razurath
/obj/item/clothing/suit/toggle/digicoat/glitched
	name = "hacked digicoat"
	desc = "Glitched images display across the back. Cool!"
	base_icon_state = "digicoat_glitched"
	icon_state = "digicoat_glitched"

/obj/item/clothing/suit/toggle/digicoat/nanotrasen
	name = "nanotrasen digicoat"
	desc = "A company jacket of popular design."
	base_icon_state = "digicoat_nt"
	icon_state = "digicoat_nt"

/obj/item/clothing/suit/toggle/digicoat/interdyne
	name = "interdyne digicoat"
	desc = "A sinister colored jacket from a familiar company."
	base_icon_state = "digicoat_interdyne"
	icon_state = "digicoat_interdyne"

/obj/item/clothing/suit/armor/hos/elofy
	name = "solar admiral coat"
	desc = "A traditional naval officer uniform of the late 63rd Expeditionary Fleet. This faithful recreation bears the admiral's crest of the Luna Wolves Legion. It is uniquely tailored to the form of a certain wolf girl."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "coat_blackblue"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black-Blue" = list(
			RESKIN_ICON_STATE = "coat_blackblue",
			RESKIN_WORN_ICON_STATE = "coat_blackblue"
		),
		"Black-Red" = list(
			RESKIN_ICON_STATE = "coat_blackred",
			RESKIN_WORN_ICON_STATE = "coat_blackred"
		),
		"White-Red" = list(
			RESKIN_ICON_STATE = "coat_whitered",
			RESKIN_WORN_ICON_STATE = "coat_whitered"
		),
		"White-Blue" = list(
			RESKIN_ICON_STATE = "coat_whiteblue",
			RESKIN_WORN_ICON_STATE = "coat_whiteblue"
		)
	)

/obj/item/clothing/suit/armor/hos/elofy/examine_more(mob/user)
	. = ..()
	. += "It seems particularly soft and has subtle ballistic fibers intwined with the soft fabric that is perfectedly tailored to the body that wears it. Each golden engraving seems to reflect against your eyes with a slightly blinding flare. This is part of a full set of Luna Wolves Legion battle garb."


/obj/item/clothing/head/hats/hos/elofy
	name = "solar admiral hat"
	icon ='modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "hat_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White" = list(
			RESKIN_ICON_STATE = "hat_white",
			RESKIN_WORN_ICON_STATE = "hat_white"
		),
		"Black" = list(
			RESKIN_ICON_STATE = "hat_black",
			RESKIN_WORN_ICON_STATE = "hat_black"
		)
	)


/obj/item/clothing/gloves/elofy
	name = "solar admiral gloves"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "gloves_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White" = list(
			RESKIN_ICON_STATE = "gloves_white",
			RESKIN_WORN_ICON_STATE = "gloves_white"
		),
		"Black" = list(
			RESKIN_ICON_STATE = "gloves_black",
			RESKIN_WORN_ICON_STATE = "gloves_black"
		)
	)

/obj/item/clothing/shoes/jackboots/elofy
	name = "solar admiral boots"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "boots_blackblue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black-Red" = list(
			RESKIN_ICON_STATE = "boots_blackred",
			RESKIN_WORN_ICON_STATE = "boots_blackred"
		),
		"White-Red" = list(
			RESKIN_ICON_STATE = "boots_whitered",
			RESKIN_WORN_ICON_STATE = "boots_whitered"
		),
		"White-Blue" = list(
			RESKIN_ICON_STATE = "boots_whiteblue",
			RESKIN_WORN_ICON_STATE = "boots_whiteblue"
		)
	)

// Donation reward for grasshand
/obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
	name = "noble gambeson"
	desc = "These clothes make you feel a little closer to space."

/obj/item/clothing/shoes/jackboots/noble
	name = "noble boots"
	desc = "These boots make you feel like you can walk on space."
	icon_state = "archerboots"
	inhand_icon_state = "archerboots"

// Donation reward for nikotheguydude
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "vickyred"
	name = "nobility dresscoat"
	desc = "An elaborate coat composed of a silky yet firm material. \
		The fabric is quite thin, and provides negligible protection or insulation, \
		but is pleasant on the skin.\nWhile extremely well made, it seems quite \
		fragile, and rather <i>expensive</i>. You get the feeling it might not \
		<b>survive a washing machine</b> without specialized treatment."
	special_desc = "Its buttons are pressed with some kind of sigil - which, to those knowledgeable in \
		Tiziran politics or nobility, would be recognizable as the <b>Kor'Yesh emblem</b>, \
		a relatively <i>minor house of nobility</i> within <i>Tizira</i>.\n\n\
		On a closer inspection, it would appear the interior is modified with protective material and mounting points \
		most often found on medical labcoats."
	limb_integrity = 100 // note that this is usually disabled by having it set to 0, so this is just strictly worse
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/Initialize(mapload)
	. = ..()

	qdel(GetComponent(/datum/component/toggle_icon)) // we dont have a toggle icon

#define NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED 2500

// this is based on an in-joke with the character whom inspires this donator item, where they need a fuckton of money to wash their coat. this takes it literally
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/machine_wash(obj/machinery/washing_machine/washer)

	var/total_credits = 0
	var/list/obj/item/money_to_delete = list()
	for (var/obj/item/holochip/chip in washer)
		total_credits += chip.get_item_credit_value()
		money_to_delete += chip
		if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
			break
	if (total_credits < NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
		for (var/obj/item/stack/spacecash/cash in washer)
			total_credits += cash.get_item_credit_value()
			money_to_delete += cash
			if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
				break

	var/message
	var/sound_effect_path
	var/sound_effect_volume
	if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED) // all is well
		message = span_notice("[src] seems to absorb the raw capital from its surroundings, and is successfully washed!")
		sound_effect_path = 'sound/effects/whirthunk.ogg'
		sound_effect_volume = 40
		for (var/obj/item/entry_to_delete as anything in money_to_delete)
			qdel(entry_to_delete)
	else // IT COSTS ME A THOUSAND CREDITS TO WASH THIS!! HALF MY BUDGET IS DRY CLEANING
		message = span_warning("[src]'s delicate fabric is shredded by [washer]! How terrible!")
		sound_effect_path = 'sound/effects/cloth_rip.ogg'
		sound_effect_volume = 30
		for (var/zone as anything in cover_flags2body_zones(body_parts_covered))
			take_damage_zone(zone, limb_integrity * 1.1, BRUTE) // fucking shreds it

	var/turf/our_turf = get_turf(src)
	our_turf.visible_message(message)
	playsound(src, sound_effect_path, sound_effect_volume, FALSE)

	return ..()

/obj/item/clothing/under/costume/dragon_maid
	name = "dragon maid uniform"
	desc = "A uniform for a kitchen maid, stylized to have draconic detailing."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "dragon_maid"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

#undef NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED

//  Donation reward for vexcint
/obj/item/clothing/head/anubite
	name = "\improper Anubite headpiece"
	desc = "A dark coloured headpiece with golden accents. Its features seem reminiscent of the god Anubis."
	icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "anubite_headpiece"
	worn_icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_y_offset = 4

//  Donator reward Smol42

/obj/item/clothing/neck/trenchcoat
	name = "Secure Trenchcoat"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "trenchcoat"
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Snow" = list(
			RESKIN_ICON_STATE = "trenchcoat_white",
			RESKIN_WORN_ICON_STATE = "trenchcoat_white"
		),
		"Tin" = list(
			RESKIN_ICON_STATE = "trenchcoat_tin",
			RESKIN_WORN_ICON_STATE = "trenchcoat_tin"
		),
		"Blue" = list(
			RESKIN_ICON_STATE = "trenchcoat_blue",
			RESKIN_WORN_ICON_STATE = "trenchcoat_blue"
		)
	)

//Donation reward for Jasohavents
/obj/item/clothing/under/rank/cargo/qm/skirt/old
	name = "quartermaster's jumpskirt"
	desc = "It seems somebody has kept a couple outdated quartermaster uniforms. They smell of Rum and Smoke."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'

//Donation reward for Jasohavents
/obj/item/food/griddle_toast/toaster_implant
	name = "toast"
	desc = "Thick cut bread, toasted to perfection."
	food_reagents = list(/datum/reagent/consumable/nutriment = 1)
//it's meant to be practically non-functional in terms of giving any ingame advantage, but it seems food needs to have *something* in it to be edible
//it *can* be a whole thing with a "gridle" that only accepts bread from the user's hand but I can't be assed to implement it for a one-off gimmick donator item

#define TOASTER_IMPLANT_COOLDOWN (3 MINUTES)
/obj/item/implant/toaster
	name = "toaster implant"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	COOLDOWN_DECLARE(toast_cooldown)

/obj/item/implant/toaster/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Toaster-O brand toaster module<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Serves you a delicious toasted slice of bread."}
	return dat

/obj/item/implant/toaster/activate()
	. = ..()
	if(!COOLDOWN_FINISHED(src, toast_cooldown))
		imp_in.show_message(span_notice("You're not quite ready to toast another toast yet."))
		return

	var/obj/item/food/griddle_toast/toaster_implant/toast = new(get_turf(imp_in))
	var/adjective = pick("crispy", "delicious", "fresh")
	imp_in.visible_message(span_notice("[imp_in] ejects a [adjective] toast!"), span_notice("With the familiar \"ding\", the toaster ejects a [adjective] toast."))

	playsound(imp_in, 'sound/machines/ding.ogg', vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	toast.throw_at(get_turf(imp_in), 2, 3)
	COOLDOWN_START(src, toast_cooldown, TOASTER_IMPLANT_COOLDOWN)

/obj/item/implanter/toaster
	name = "implanter (toaster)"
	imp_type = /obj/item/implant/toaster

/obj/item/implantcase/toaster
	name = "implant case - 'Toaster'"
	desc = "A glass case containing a toaster implant. Sweet."
	imp_type = /obj/item/implant/toaster

#undef TOASTER_IMPLANT_COOLDOWN

// donator item for Sciamach
/obj/item/organ/cyberimp/arm/shard/donator/theurgic_crystal
	name = "theurgic stone"
	desc = "An eerie crystalline shard that pulses with theurgic energies. Tendrils of crimson energy seem to dance along its surface."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "crystal"
	items_to_create = list(/obj/item/knife/razor_claws/donator/theurgic_knife)
	extend_sound = 'sound/items/haunted/ghostitemattack.ogg'
	retract_sound = 'sound/items/haunted/ghostitemattack.ogg'

/obj/item/knife/razor_claws/donator/theurgic_knife
	name = "cursed ritual knife"
	desc = "A large carving or flensing dagger made of a heavy, dusty material. It seems to emit a soft, eerie crimson glow."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	righthand_file = 'modular_nova/modules/modular_ert/icons/pizza/righthand.dmi'
	lefthand_file = 'modular_nova/modules/modular_ert/icons/pizza/lefthand.dmi'
	icon_state = "dagger"
	inhand_icon_state = "hotknife"
	toggle_sound = 'sound/items/haunted/ghostitemattack.ogg'

/obj/item/knife/razor_claws/donator/theurgic_knife/attack_self(mob/user)
	. = ..()
	inhand_icon_state = src::inhand_icon_state // Don't have a precision variant for this, just always use base

// donator reward for ignari
/obj/item/clothing/under/rem
	name = "\improper M.I.A. limiter"
	desc = "Manufactured from durable synthetic threads, this outfit seems to be very poor at transmitting physical stimuli to the wearer. \
		The material appears to be extremely compressive, possibly aiding in masking any features underneath."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "ignari_rem"
	can_adjust = FALSE

/obj/item/clothing/shoes/rem_shoes
	name = "\improper M.I.A. heels"
	desc = "A pair of form fitting heels. They appear to bear no distinguishing identifiers."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "rem_shoes"

/obj/item/clothing/shoes/rem_shoes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_nova/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)

/obj/item/clothing/under/bwake
	name = "\improper Compression bodysuit"
	desc = "A bodysuit made of weaved bluespace threads and latex. The suit appears to be exceptionally insulating, and seals quite neatly around the wearer's body."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "bwake_uniform"
	can_adjust = FALSE

// Donator reward for Latinfishy
/obj/item/clothing/under/syndicate/tacticool/skirt/long
	name = "long tacticool skirtleneck"
	desc = "A sleek, navy blue turtleneck complete with an extra long black skirt. Just looking at it makes you want to watch your step in case you -trip-."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "tacticool_skirtleneck_long"
	unique_reskin = null

// donator reward for AlvCyktor
/obj/item/clothing/under/techpants
	name = "techwear pants"
	desc = "A pair of pants with some belts and fake pouches for added aesthetics."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "techpants"
	can_adjust = FALSE

/obj/item/storage/backpack/satchel/drop_pouch
	name = "drop pouch"
	desc = "A tactical pouch attached to a belt."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/belt.dmi'
	icon_state = "dropbag"

/obj/item/clothing/suit/replica_parade_jacket
	name = "replica parade jacket"
	desc = "Ever see command staff in a fancy parade jacket and think to yourself, \"I want that\" without having to steal it? Here's your chance. Made from the finest synthleather and synthwool, it cost far more than most people care to admit they paid."
	icon_state = "r_parade_jacket"
	greyscale_config = /datum/greyscale_config/replica_parade_jacket
	greyscale_config_worn = /datum/greyscale_config/replica_parade_jacket/worn
	greyscale_colors = "#b0c5ff#434343"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/replica_parade_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// donation reward for deadmon
/obj/item/clothing/suit/hooded/seva/melon
	name = "sundowner SEVA suit"
	desc = "A SEVA suit originally designed for SolFed's Army Corps of Engineers to be used in CBRN environments. This suit seems to have had its typical armor plating and anti-radiation lining removed in favor of movement. "
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	icon_state = "seva_melon"
	hoodtype = /obj/item/clothing/head/hooded/seva/melon
	hood_up_affix = ""

/obj/item/clothing/head/hooded/seva/melon
	name = "sundowner hood"
	desc = "Designed for the SolFed Army Corps of Engineers, the original version came with armor plates and a hardened glass faceplate. This one has been scaled down, unfortunately."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_muzzled = 'modular_nova/master_files/icons/donator/mob/clothing/head_muzzled.dmi'
	icon_state = "seva_melon"

/obj/item/clothing/suit/chokha
	name = "\improper Iseurian chokha"
	desc = "A ceremonial woolen coat sporting a high neck and decorative gunpowder cases on the breast. The label on this one bears the Iseurian Revolutionary flag."
	icon_state = "chokha"
	greyscale_config = /datum/greyscale_config/chokha
	greyscale_config_worn = /datum/greyscale_config/chokha/worn
	greyscale_colors = "#1c1c1c#491618#1c1c1c#491618"
	flags_1 = IS_PLAYER_COLORABLE_1

//donator reward for Desminus

/obj/item/clothing/suit/toggle/desminus
	name = "jómsvíking coat"
	desc = "A long, woolen coat. Made for those who pillaged and plundered countless people in their age. It was built to stand the test of time. This one is white as pure snow, adorned with the whiskers of a black drake and with every silken stitch hand woven."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	icon_state = "jomcoat"

/obj/item/clothing/suit/toggle/desminus2
	name = "elderwood garment"
	desc = "A cloak forged from the finest strands of elderwood trees. It is woven in an old elven style, with reinforced hides to keep nomadic tribes warm in bitter winters. It can be opened up to keep cool in the more temperate summers. On the collar is a silken weave with the engraving: Ad Avalon Infinitum."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	icon_state = "eldercoat"

//donator reward for cosmiclaer
/obj/item/clothing/under/pants/half_leotard_cosmiclaer
	name = "one-sleeved leotard"
	desc = "A fancy, top-of-the-line leotard that some barbarian lopped one of the arms off of."
	icon_state = "half_leotard"
	greyscale_config = /datum/greyscale_config/half_leotard
	greyscale_config_worn = /datum/greyscale_config/half_leotard/worn
	greyscale_colors = "#80C7D0"
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = NONE
	body_parts_covered = CHEST|ARM_RIGHT|HAND_RIGHT|GROIN

/obj/item/clothing/under/costume/shendyt
	name = "shendyt"
	desc = "Traditional clothing straight from Iaret's home planet. Made from a cotton that's quite effective at insulating against outside temperatures, they have the only disadvantage of being fairly poorly covering.\
	<br> Inspired by an ancient culture of old Earth, it's obvious that some modifications were made to the original model. Nevertheless, their bearer wears them with pride. "
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "shendyt"
	inhand_icon_state = "labcoat"
	can_adjust = FALSE
	supports_variations_flags = NONE
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/under/costume/shendyt/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/bracelets/costume_accessory = new(src)
	attach_accessory(costume_accessory)

/obj/item/clothing/accessory/bracelets
	name = "golden bracelets"
	desc = "An assortment of bracelets, necklaces and other small gold (if not precious metal) jewels. Most often worn as a complement to a shendyt, \
	it is possible to come across their owner ringing like a chime if they should happen to lose this garment."
	icon_state = "bracelets"
	attachment_slot = NONE
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'

// Donation reward for jaklz
/obj/item/clothing/neck/tattered
	name = "worn corporate cloak"
	desc = "A worn, battle-torn cloak. Complete with light red trimmings, tears, burns, and even some holes through out it's design, it clearly has seen better days. You can practically smell the despair, a hint of welding fuel, and a bit of a pine smell."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "tattered_cloak"
	inhand_icon_state = "tattered_cloak"

// Donation reward for Sharkoink, shork

/obj/item/clothing/neck/noble_mantle
	name = "noble mantle"
	desc = "A noble mantle for a loyal and hearty Dragonshark."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/cloaks.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "noble_mantle"
	inhand_icon_state = "noble_mantle"

/obj/item/clothing/suit/armor/hos/trenchcoat/melon
	name = "\improper Command Armor Vest"
	desc = "An armor vest with improved armor plates. Designed for use by command units."
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "vest_com_melon"

/obj/item/clothing/suit/hooded/explorer/melon
	name = "anomalous materials protection suit"
	desc = "A suit originally designed for the SolFed Army to be used in CBRN environments. This suit still has it's protective plates installed. It's clear that this suit has been patched up over many years."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	icon_state = "explorer_melon"
	hoodtype = /obj/item/clothing/head/hooded/explorer/melon
	hood_up_affix = ""

/obj/item/clothing/head/hooded/explorer/melon
	name = "\improper AMPS hood"
	desc = "Designed to give soldiers protection in anomalous and dangerous areas, the AMPS hood features materials that make it resistant to attack."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "explorer_melon"

/obj/item/clothing/under/dress/heirloomdagmar
	name = "heirloom dress"
	desc = "An early 21st century dress in a vintage style, part of the Ms. Ann Thorpe Overbearing Granny Summer collection. A travel look for an overbearing matchmaker."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	alternate_worn_layer = ABOVE_SHOES_LAYER
	icon_state = "dagmardress_a"

/obj/item/clothing/under/dress/neoflapperdagmar
	name = "neo-flapper dress"
	desc = "Part of a shameful and best left forgotten nostalgic fashion movement among the Martian elite, nearly all traces of which were scrubbed from the holonet. Even recognizing this puts you at risk."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	alternate_worn_layer = ABOVE_SHOES_LAYER
	icon_state = "dagmardress_b"

/obj/item/clothing/under/dress/ambassadordagmar
	name = "ambassador's dress"
	desc = "Eveningwear for a cardshark or someone who refuses to take ‘No Dogs Allowed’ for an answer. A Martian fusion style evening gown, from cheating at blackjack to welcoming a diplomat delegation, you'll find every card trick already up its ample furisode sleeves."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	alternate_worn_layer = ABOVE_SHOES_LAYER
	icon_state = "dagmardress_c"
