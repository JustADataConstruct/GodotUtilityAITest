extends Area3D

## If not zero, will force the amount of resources in this node.
@export var amount:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if amount == 0:
		amount = randi_range(10,30)
	$AmountLabel.text = str(amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#TODO: Use collision layers to make sure only bodies that can actually eat can toggle this.
func _on_body_entered(body):
	body.current_resource_node = self

func _on_body_exited(body):
	body.current_resource_node = null
	
func try_consume() -> bool:
	if amount > 0:
		amount -= 1
		$AmountLabel.text = str(amount)
		return true
	return false
	
