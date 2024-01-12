extends CharacterBody3D



const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var wander_radius = 20 # Used for the IdleAction.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var agent:UtilityAIAgent
var current_action:UtilityAIAction

# For the debugging panel
@export var current_behavior_label:String
@export var top_behavior_label:String
@export var current_action_label:String
@export var export_button_restart = "Restart scene"

# Needs
@export var hunger:float = 0.5
@export var in_danger:bool = false

# Sensors
var hunger_sensor:UtilityAISensor
var is_at_eating_spot_sensor:UtilityAIBooleanSensor
var danger_sensor:UtilityAIBooleanSensor
var resource_sensor:UtilityAIBooleanSensor

@onready var nav:NavigationAgent3D = $NavigationAgent3D
@export var current_resource_node:Node3D = null

func _ready():
	agent = $UtilityAIAgent
	hunger_sensor = $UtilityAIAgent/HungerSensor
	is_at_eating_spot_sensor = $UtilityAIAgent/AtEatingSpotSensor
	danger_sensor = $UtilityAIAgent/DangerSensor
	resource_sensor = $UtilityAIAgent/EnoughResourcesSensor
	

func _process(delta):
	current_behavior_label = agent.current_behaviour_name
	top_behavior_label = agent.top_scoring_behaviour_name
	
	hunger_sensor.sensor_value = hunger
	is_at_eating_spot_sensor.boolean_value = current_resource_node != null and current_resource_node.is_in_group("food_resource")
	danger_sensor.boolean_value = in_danger
	resource_sensor.boolean_value = current_resource_node.amount > 0 if current_resource_node != null else false

	agent.evaluate_options(delta)
	agent.update_current_behaviour()
	
	if current_action != null:
		current_action.execute_action(self,delta)

func _on_utility_ai_agent_action_changed(action_node):
	if current_action != null:
		current_action.end_action(self)
	current_action = action_node
	if current_action != null:
		current_action.start_action(self)
		current_action_label = current_action.get_name()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	move_and_slide()
	
func restart():
	get_tree().reload_current_scene()



