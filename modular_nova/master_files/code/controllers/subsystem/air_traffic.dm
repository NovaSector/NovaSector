SUBSYSTEM_DEF(atc)
	name = "Air Traffic Control"
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME
	wait = 2 SECONDS
	flags = SS_BACKGROUND

	VAR_PRIVATE/next_tick = 0
	VAR_PRIVATE/datum/atc_chatter_type/chatter_datum = new() // don't change, override the chatter_box() proc
	VAR_PRIVATE/delay_min = 20 MINUTES				//How long between ATC traffic, minimum
	VAR_PRIVATE/delay_max = 30 MINUTES				//Ditto, maximum
							//Shorter delays means more traffic, which gives the impression of a busier system, but also means a lot more radio noise
	VAR_PRIVATE/backoff_delay = 5 MINUTES			//How long to back off if we can't talk and want to.  Default is 5 mins.
	VAR_PRIVATE/initial_delay = 10 MINUTES			//How long to wait before sending the first message of the shift.

	//define a block of frequencies so we can have them be static instead of being random for each call
	var/ertchannel
	var/medchannel
	var/engchannel
	var/secchannel
	var/sdfchannel

	var/mob/atc_voice/talking_head

/datum/controller/subsystem/atc/Initialize()
	//generate our static event frequencies for the shift. alternately they can be completely fixed, up in the core block
	ertchannel = "[rand(700,749)].[rand(1,9)]"
	medchannel = "[rand(750,799)].[rand(1,9)]"
	engchannel = "[rand(800,849)].[rand(1,9)]"
	secchannel = "[rand(850,899)].[rand(1,9)]"
	sdfchannel = "[rand(900,999)].[rand(1,9)]"
	talking_head = new /mob/atc_voice(src)
	talking_head.name = "Traffic Control"
	return SS_INIT_SUCCESS

/datum/controller/subsystem/atc/fire()
	if(times_fired < 1)
		return
	if(times_fired == 1)
		next_tick = world.time + initial_delay
		INVOKE_ASYNC(src,PROC_REF(shift_starting))
		return
	if(world.time < next_tick)
		return
	next_tick = world.time + rand(delay_min,delay_max)
	INVOKE_ASYNC(src,PROC_REF(random_convo))

/datum/controller/subsystem/atc/proc/shift_starting()
	new /datum/atc_chatter/shift_start(null,null)

/datum/controller/subsystem/atc/proc/shift_ending()
	new /datum/atc_chatter/shift_end(null,null)

/datum/controller/subsystem/atc/proc/random_convo()
	// Pick from the organizations in the LOREMASTER, so we can find out what these ships are doing
	var/one = pick(loremaster.organizations) //These will pick an index, not an instance
	var/two = pick(loremaster.organizations)
	var/datum/lore/organization/source = loremaster.organizations[one] //Resolve to the instances
	var/datum/lore/organization/secondary = loremaster.organizations[two] //repurposed for new fun stuff

	//Random chance things for variety
	var/path = chatter_datum.chatter_box(source.org_type,secondary.org_type)
	new path(source,secondary)

/datum/controller/subsystem/atc/proc/msg(var/message)
	ASSERT(message)
	if(talking_head)
		talking_head.say(message)
	else
		// Fallback to direct announcement if talking_head is not available
		var/obj/machinery/announcement_system/aas = get_announcement_system()
		if(aas)
			aas.broadcast("[message]", list(RADIO_CHANNEL_COMMON))
