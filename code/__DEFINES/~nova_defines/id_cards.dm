/// Buffed wildcard slot define for Chameleon/Agent ID grey cards. Can hold 4 common, 2 command and 1 captain access.
#define WILDCARD_LIMIT_CHAMELEON_PLUS list( \
	WILDCARD_NAME_COMMON = list(limit = 4, usage = list()), \
	WILDCARD_NAME_COMMAND = list(limit = 2, usage = list()), \
	WILDCARD_NAME_CAPTAIN = list(limit = 1, usage = list()) \
)

/// Used for NT Rep/Blueshield ID cards
#define WILDCARD_LIMIT_FAKECENTCOM list( \
	WILDCARD_NAME_COMMON = list(limit = 3, usage = list()), \
	WILDCARD_NAME_COMMAND = list(limit = 1, usage = list()), \
	WILDCARD_NAME_CENTCOM = list(limit = 1, usage = list()) \
)
