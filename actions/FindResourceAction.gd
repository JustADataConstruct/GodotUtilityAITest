extends UtilityAIAction

@export var resource:String

func start_action(actor) -> void:
	print("Find Resource: {res}".format({"res":resource}))

func execute_action(actor, delta:float) -> void:
	var closest_node = null
	var closest_node_distance = 0.0
	for i in get_tree().get_nodes_in_group(resource):
		var current_node_distance = actor.global_position.distance_to(i.global_position)
		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance	
	if closest_node != null:
		actor.nav.target_position = Vector3(closest_node.global_position)
		is_finished = true

func end_action(actor) -> void:
	pass

