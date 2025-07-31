/obj/item/gun/ballistic/revolver/c38
	w_class = WEIGHT_CLASS_SMALL // concealed carry blickinator

/obj/item/gun/ballistic/revolver/russian/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	. = ..()
	user.set_suicide(TRUE)
	user.final_checkout(src)
