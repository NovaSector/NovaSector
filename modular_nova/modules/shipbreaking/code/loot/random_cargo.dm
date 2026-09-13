// Only random shipping containers

/obj/effect/spawner/random/salvage/container
	name = "random shipping container"
	icon_state = "container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot,
	)

/obj/effect/spawner/random/salvage/container/medical_or_research
	name = "random medical or research shipping container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/medical_or_research,
	)

/obj/effect/spawner/random/salvage/container/construction
	name = "random construction shipping container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/construction,
	)

/obj/effect/spawner/random/salvage/container/civilian_supply
	name = "random civilian supply shipping container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/civilian_supply,
	)

/obj/effect/spawner/random/salvage/container/military
	name = "random military shipping container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/military,
	)

/obj/effect/spawner/random/salvage/container/salvage
	name = "random salvage shipping container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/salvage,
	)


// Only random crates without shipping containers

/obj/effect/spawner/random/salvage/crate_only
	name = "random crate"
	icon_state = "crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot,
		/obj/structure/closet/crate/shuttle/secured/random_loot,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot,
	)

/obj/effect/spawner/random/salvage/crate_only/medical_or_research
	name = "random medical or research crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot/medical_or_research,
		/obj/structure/closet/crate/shuttle/secured/random_loot/medical_or_research,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot/medical_or_research,
	)

/obj/effect/spawner/random/salvage/crate_only/construction
	name = "random construction crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot/construction,
		/obj/structure/closet/crate/shuttle/secured/random_loot/construction,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot/construction,
	)

/obj/effect/spawner/random/salvage/crate_only/civilian_supply
	name = "random civilian supply crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot/civilian_supply,
		/obj/structure/closet/crate/shuttle/secured/random_loot/civilian_supply,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot/civilian_supply,
	)

/obj/effect/spawner/random/salvage/crate_only/military
	name = "random military crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot/military,
		/obj/structure/closet/crate/shuttle/secured/random_loot/military,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot/military,
	)

/obj/effect/spawner/random/salvage/crate_only/salvage
	name = "random salvage crate"
	loot = list(
		/obj/structure/closet/crate/shuttle_hard/secured/random_loot/salvage,
		/obj/structure/closet/crate/shuttle/secured/random_loot/salvage,
		/obj/structure/closet/crate/shuttle/small/secured/random_loot/salvage,
	)

// Random crates and shipping containers

/obj/effect/spawner/random/salvage/container_or_crate
	name = "random crate or shipping container"
	icon_state = "container"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot = 1,
		/obj/effect/spawner/random/salvage/crate_only = 3,
	)

/obj/effect/spawner/random/salvage/container_or_crate/medical_or_research
	name = "random medical or research shipping container or crate"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/medical_or_research = 1,
		/obj/effect/spawner/random/salvage/crate_only/medical_or_research = 3,
	)

/obj/effect/spawner/random/salvage/container_or_crate/construction
	name = "random construction shipping container or crate"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/construction = 1,
		/obj/effect/spawner/random/salvage/crate_only/construction = 3,
	)

/obj/effect/spawner/random/salvage/container_or_crate/civilian_supply
	name = "random civilian supply shipping container or crate"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/civilian_supply = 1,
		/obj/effect/spawner/random/salvage/crate_only/civilian_supply = 3,
	)

/obj/effect/spawner/random/salvage/container_or_crate/military
	name = "random military shipping container or crate"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/military = 1,
		/obj/effect/spawner/random/salvage/crate_only/military = 3,
	)

/obj/effect/spawner/random/salvage/container_or_crate/salvage
	name = "random salvage shipping container or crate"
	loot = list(
		/obj/structure/closet/shipping_container/secured/random_loot/salvage = 1,
		/obj/effect/spawner/random/salvage/crate_only/salvage = 3,
	)

// Random crates and shipping containers and misc. cargo

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo
	name = "random crate/shipping container/cargo"
	icon_state = "container"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate = 4,
		/obj/effect/spawner/random/salvage/cargo_machine = 1,
	)

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo/medical_or_research
	name = "random medical or research crate/shipping container/cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate/medical_or_research = 4,
		/obj/effect/spawner/random/salvage/cargo_machine/medical_or_research = 1,
	)

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo/construction
	name = "random construction crate/shipping container/cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate/construction = 4,
		/obj/effect/spawner/random/salvage/cargo_machine/construction = 1,
	)

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo/civilian_supply
	name = "random civilian supply crate/shipping container/cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate/civilian_supply = 4,
		/obj/effect/spawner/random/salvage/civilian_supply = 1,
	)

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo/military
	name = "random military crate/shipping container/cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate/military = 4,
		/obj/effect/spawner/random/salvage/cargo_machine/military = 1,
	)

/obj/effect/spawner/random/salvage/container_or_crate_or_cargo/salvage
	name = "random salvage crate/shipping container/cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/container_or_crate/salvage = 4,
		/obj/effect/spawner/random/salvage/cargo_machine/scrap = 1,
	)

// Random crates and misc. cargo, no shipping containers

/obj/effect/spawner/random/salvage/crate_or_cargo
	name = "random crate or cargo"
	icon_state = "crate"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only = 3,
		/obj/effect/spawner/random/salvage/cargo_machine = 1,
	)

/obj/effect/spawner/random/salvage/crate_or_cargo/medical_or_research
	name = "random medical or research crate or cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only/medical_or_research = 3,
		/obj/effect/spawner/random/salvage/cargo_machine/medical_or_research = 1,
	)

/obj/effect/spawner/random/salvage/crate_or_cargo/construction
	name = "random construction crate or cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only/construction = 3,
		/obj/effect/spawner/random/salvage/cargo_machine/construction = 1,
	)

/obj/effect/spawner/random/salvage/crate_or_cargo/civilian_supply
	name = "random civilian supply crate or cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only/civilian_supply = 3,
		/obj/effect/spawner/random/salvage/civilian_supply = 1,
	)

/obj/effect/spawner/random/salvage/crate_or_cargo/military
	name = "random military crate or cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only/military = 3,
		/obj/effect/spawner/random/salvage/cargo_machine/military = 1,
	)

/obj/effect/spawner/random/salvage/crate_or_cargo/salvage
	name = "random salvage crate or cargo"
	loot = list(
		/obj/effect/spawner/random/salvage/crate_only/salvage = 3,
		/obj/effect/spawner/random/salvage/cargo_machine/scrap = 1,
	)
