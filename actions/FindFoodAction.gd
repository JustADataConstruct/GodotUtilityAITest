extends UtilityAIAction

func start_action(actor) -> void:
	print("Find Food")

func execute_action(actor, delta:float) -> void:
	#TODO: Search for the closest food source.
	actor.nav.target_position = Vector3(%FoodResource.global_position)
	is_finished = true

func end_action(actor) -> void:
	pass

