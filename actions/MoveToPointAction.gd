extends UtilityAIAction

var _actor

func start_action(actor):
	print("Moving")
	_actor = actor
	actor.nav.waypoint_reached.connect(waypoint_reached)

func waypoint_reached(details:Dictionary):
	_actor.hunger -= 0.015 #TODO: Find an appropiate amount.

func execute_action(actor, delta:float):
	if actor.nav.target_position == Vector3.ZERO:
		is_finished = true
	var direction = Vector3()
	direction = actor.nav.get_next_path_position() - actor.global_position
	direction = direction.normalized()
	actor.velocity = actor.velocity.lerp(direction * actor.SPEED, 10 * delta)
	if actor.global_position.distance_to(actor.nav.get_final_position()) <= 2.0:
		is_finished = true

func end_action(actor):
	actor.nav.waypoint_reached.disconnect(waypoint_reached)
	actor.velocity = Vector3.ZERO
	actor.nav.target_position = Vector3.ZERO

