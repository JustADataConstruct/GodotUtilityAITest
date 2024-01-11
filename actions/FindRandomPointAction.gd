extends UtilityAIAction

func start_action(actor):
	print("Find Random")

func execute_action(actor, delta:float):
	actor.nav.target_position = Vector3(randf_range(actor.global_position.x - actor.wander_radius, actor.global_position.x + actor.wander_radius),0,randf_range(actor.global_position.z - actor.wander_radius, actor.global_position.z + actor.wander_radius))
	is_finished = true

func end_action(actor):
	pass

