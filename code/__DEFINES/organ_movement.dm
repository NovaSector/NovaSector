/// Delete the organ if replaced
#define DELETE_IF_REPLACED (1<<0)
/// When deleting a brain, we don't delete the identity and the player can keep playing
#define NO_ID_TRANSFER (1<<1)
/// Organ inserted by the abductors surgery
#define FROM_ABDUCTOR_SURGERY (1<<2)
// NOVA EDIT ADDITION START
/// Removing the organ will not cause it to be removed from mutant_bodyparts.
#define KEEP_IN_MUTANT_BODYPARTS (1<<3)
// NOVA EDIT ADDITION END
