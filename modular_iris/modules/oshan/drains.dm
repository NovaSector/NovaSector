/obj/structure/drain/big/bigjohn
	name = "GigaDrain"
	desc = "It says Big John on it."

/obj/structure/drain/big/bigjohn/Initialize(mapload)
	. = ..()
	transform = transform.Scale(5, 5)

