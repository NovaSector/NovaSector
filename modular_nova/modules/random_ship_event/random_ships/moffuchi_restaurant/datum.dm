/datum/random_ship_event/moffuchi_restaurant
	name = "Moffuchi's To Go Restaurant Ship"

	ship_template_id = "restaurant_ship"
	ship_name_pool = "restaurant_names"

	message_title = "Culinary Experience Available"
	message_content = "Greetings station dwellers! This is the %SHIPNAME, Moffuchi's famous mobile restaurant! Our chefs have prepared exquisite delicacies from across the galaxy. Would you like us to dock and serve your crew?"
	arrival_announcement = "Wonderful! The ovens are heating up and our chefs are preparing to dazzle your taste buds!"
	possible_answers = list("Permission granted, welcome to our station!", "Permission denied, we're not interested in food services.")

	response_accepted = "Fantastic! Your crew is in for a treat they'll never forget. Prepare your taste buds for the journey of a lifetime!"
	response_rejected = "Such a pity! Your crew will miss out on our legendary Moffuchi special. We'll take our flavors elsewhere."

	announcement_color = "orange"
