/client/proc/add_mentor_verbs()
	if(mentor_datum)
		ASSIGN_GAME_VERB(src, /client, cmd_mentor_say)
		ASSIGN_GAME_VERB(src, /client, cmd_mentor_dementor)

/client/proc/remove_mentor_verbs()
	UNASSIGN_GAME_VERB(src, /client, cmd_mentor_say)
	UNASSIGN_GAME_VERB(src, /client, cmd_mentor_dementor)
