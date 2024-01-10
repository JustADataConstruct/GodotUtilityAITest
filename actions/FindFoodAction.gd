extends UtilityAIAction

const SPEED = 5.0

func start_action(actor) -> void:
	print("Find Food")

func execute_action(actor, delta:float) -> void:
	var direction = Vector3()
	actor.nav.target_position = Vector3(%FoodResource.global_position)
	direction = actor.nav.get_next_path_position() - actor.global_position
	direction = direction.normalized()
	actor.velocity = actor.velocity.lerp(direction * actor.SPEED, 10 * delta)
	if actor.on_eating_spot == true:
		is_finished = true
	

func end_action(actor) -> void:
	actor.velocity = Vector3.ZERO
