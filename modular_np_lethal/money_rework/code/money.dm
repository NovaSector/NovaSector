// LETHALSTATION EDIT:
//  cash from eris
//  all credit for the money goes to kegdo for their immaculate work
//  fuck holograms

/obj/item/lethalcash
	name = "coin"
	desc = "Ironically, this is worthless."
	icon = 'modular_np_lethal/money_rework/icons/lethalmoney.dmi'
	icon_state = "lethalcash1"
	worn_icon_state = "nothing"
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/value = 0
	grind_results = list(/datum/reagent/cellulose = 10)


/obj/item/lethalcash/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/lethalcash))
		var/obj/item/lethalcash/bundle/bundle
		if(istype(W, /obj/item/lethalcash/bundle))
			bundle = W
		else
			var/obj/item/lethalcash/cash = W
			bundle = new (loc)
			bundle.value = cash.value
			qdel(cash)

		bundle.value += value
		bundle.update_icon()
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.put_in_hands(bundle)
		to_chat(user, ("You add [value] credits worth of money to the bundles.<br>It holds [bundle.value] credits now."))
		qdel(src)


/obj/item/lethalcash/Destroy()
	. = ..()
	value = 0 //if it ain't worth don't spend it


/obj/item/lethalcash/bundle
	name = "bundle of credits"
	icon_state = ""

/obj/item/lethalcash/bundle/update_icon()
	. = ..()
	cut_overlays()
	var/sum = src.value
	var/num = 0
	var/list/denominations = list(1000,500,200,100,50,20,10,5,1)
	for(var/i in denominations)
		while(sum >= i && num < 50)
			sum -= i
			num++
			var/image/banknote = image('modular_np_lethal/money_rework/icons/lethalmoney.dmi', "lethalcash[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			banknote.transform = M
			src.add_overlay(banknote)
	src.desc = "They are worth [value] credits."

/obj/item/lethalcash/bundle/attack_self()
	var/amount = input(usr, "How many credits do you want to take? (0 to [src.value])", "Take Money", 20) as num
	amount = round(clamp(amount, 0, src.value))
	if(amount==0) return 0
	else if(!Adjacent(usr))
		to_chat(usr, span_warning("You can't reach the bundle!"))
		return

	if(!value)
		qdel(src)
	if(amount in list(1000,500,200,100,50,20,10,5,1))
		var/cashtype = text2path("/obj/item/lethalcash/c[amount]")
		var/obj/cash = new cashtype (usr.loc)
		usr.put_in_hands(cash)
	else
		var/obj/item/lethalcash/bundle/bundle = new (usr.loc)
		bundle.value = amount
		bundle.update_icon()
		usr.put_in_hands(bundle)

	src.value -= amount
	src.update_icon()
	if(!value)
		qdel(src)

/obj/item/lethalcash/bundle/Initialize()
	. = ..()
	update_icon()

/obj/item/lethalcash/c1
	name = "1 credit coin"
	icon_state = "lethalcash1"
	desc = "A one-credit coin. Even a Yellow could figure this one out."
	value = 1

/obj/item/lethalcash/c5
	name = "5 credit coin"
	icon_state = "lethalcash5"
	desc = "A five-credit coin. Arguably the starting point for restaurant tips."
	value = 5

/obj/item/lethalcash/c10
	name = "10 credit coin"
	icon_state = "lethalcash10"
	desc = "A ten-credit coin. Pleasantly heavy."
	value = 10

/obj/item/lethalcash/c20
	name = "20 credit bill"
	icon_state = "lethalcash20"
	desc = "A twenty-credit bill. Often found stuffed into the bunnysuits of Black Company showgirls."
	value = 20

/obj/item/lethalcash/c50
	name = "50 credit bill"
	icon_state = "lethalcash50"
	desc = "A fifty-credit bill. The least disappointing thing to find in a cache raid."
	value = 50

/obj/item/lethalcash/c100
	name = "100 credit bill"
	icon_state = "lethalcash100"
	desc = "A one-hundred-credit bill, the lifeblood of interstellar commerce."
	value = 100

/obj/item/lethalcash/c200
	name = "200 credit bill"
	icon_state = "lethalcash200"
	desc = "A two-hundred-credit bill, depicting a Marsian sunrise."
	value = 200

/obj/item/lethalcash/c500
	name = "500 credit bill"
	icon_state = "lethalcash500"
	desc = "A five-hundred-credit bill. More of these come and go from the Spinward Territories than people."
	value = 500

/obj/item/lethalcash/c1000
	name = "1000 credit bill"
	icon_state = "lethalcash1000"
	desc = "A crumpled one-thousand-credit bill. The preferred foodstuff of government."
	value = 1000


/proc/spawn_lethal_money(sum, spawnloc, mob/living/carbon/human/H) //there's a little weirdness with the way it generates single bills but this works pretty good
	if(sum in list(1000,500,200,100,50,20,10,5,1))
		var/cashtype = text2path("/obj/item/lethalcash/c[sum]")
		var/obj/cash = new cashtype (spawnloc)
		usr.put_in_hands(cash)
	else
		var/obj/item/lethalcash/bundle/fundle = new (spawnloc)
		fundle.value = sum
		fundle.update_icon()
		usr.put_in_hands(fundle)
		if(istype(H) && !H.get_active_hand())
			H.put_in_hands(fundle)
