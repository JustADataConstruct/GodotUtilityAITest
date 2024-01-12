extends UtilityAIAction

const eat_time_max:float = 2.0
var eat_time:float = 2.0

func start_action(actor) -> void:
	print("Eat")

func execute_action(actor, delta:float) -> void:
	if actor.in_danger or actor.current_resource_node == null:
		is_finished = true
	eat_time -= delta
	if eat_time <= 0.0:
		if actor.current_resource_node.try_consume(): # TODO: This probably could be done on a miriad of different and better ways.
			actor.hunger += 0.1
			eat_time = eat_time_max
		else:
			is_finished = true

	if actor.hunger >= 0.9:
		is_finished = true

func end_action(actor) -> void:
	actor.current_resource_node = null
	eat_time = eat_time_max
