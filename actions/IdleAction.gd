extends UtilityAIAction

var moving:bool = false
var position:Vector3 = Vector3.ZERO

func start_action(actor) -> void:
	pass
	
# TODO: Separate this in two different actions: SelectRandomPoint and GoToPoint(reutilizable)

func execute_action(actor, delta:float) -> void:
	var direction = Vector3()
	if !moving:
		position = Vector3(randf_range(actor.global_position.x - actor.wander_radius, actor.global_position.x + actor.wander_radius),0,randf_range(actor.global_position.z - actor.wander_radius, actor.global_position.z + actor.wander_radius))
		actor.nav.target_position = position
		moving = true
	if moving:
		direction = actor.nav.get_next_path_position() - actor.global_position
		direction = direction.normalized()
		actor.velocity = actor.velocity.lerp(direction * actor.SPEED, 10 * delta)
		
		if actor.global_position.distance_to(position) < 3.0:
			is_finished = true

func end_action(actor) -> void:
	moving = false
	actor.velocity = Vector3.ZERO
	position = Vector3.ZERO
