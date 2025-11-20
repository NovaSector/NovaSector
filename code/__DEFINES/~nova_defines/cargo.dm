// Bitflags for what each supplypack is allowed to be bought from
#define CARGO_CONSOLE_NT		(1<<0)
#define CARGO_CONSOLE_INTERDYNE	(1<<1)
#define CARGO_CONSOLE_TARKON	(1<<2)
#define CARGO_CONSOLE_DS2		(1<<3)
#define CARGO_CONSOLE_PDA		(1<<4) // Ideally, this has nothing assigned to it, as PDA's are obtainable by others and access is also easily obtainable.
#define CARGO_CONSOLE_NO		(1<<5) // Do not add this one to the _ALL define, its used to soft block stuff.
#define CARGO_CONSOLE_ALL (CARGO_CONSOLE_NT|CARGO_CONSOLE_INTERDYNE|CARGO_CONSOLE_TARKON|CARGO_CONSOLE_DS2|CARGO_CONSOLE_PDA) // Remember to update this one when a new one is added.
