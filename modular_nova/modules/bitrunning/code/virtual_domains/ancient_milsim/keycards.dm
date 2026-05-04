#define MILSIM_REWARD_ROOM_ID "milsim_reward_room"
#define MILSIM_EXIT_TUNNEL_ID "milsim_exit_tunnel"

/obj/item/keycard/milsim_reward_room
	name = "reward room keycard"
	color = /obj/item/keycard/yellow::color
	puzzle_id = MILSIM_REWARD_ROOM_ID

/obj/item/keycard/milsim_reward_room/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bitrunning_objective)

/obj/machinery/door/puzzle/keycard/milsim_reward_room
	name = "Reward Room"
	puzzle_id = MILSIM_REWARD_ROOM_ID

/obj/item/keycard/milsim_exit_tunnel
	name = "exit tunnel keycard"
	color = /obj/item/keycard/blue::color
	puzzle_id = MILSIM_EXIT_TUNNEL_ID

/obj/item/keycard/milsim_exit_tunnel/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bitrunning_objective)

/obj/machinery/door/puzzle/keycard/milsim_exit_tunnel
	name = "Exit Tunnel"
	puzzle_id = MILSIM_EXIT_TUNNEL_ID

#undef MILSIM_REWARD_ROOM_ID
#undef MILSIM_EXIT_TUNNEL_ID
