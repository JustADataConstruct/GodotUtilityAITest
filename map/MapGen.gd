extends Node3D

@onready var res = [
	preload("res://resources/TileFloor.tscn"),
	preload("res://resources/TileTree.tscn"),
	preload("res://resources/FoodResource.tscn")
]
# Called when the node enters the scene tree for the first time.
func _ready():
	regenerate()

func regenerate():
	for x in $Surface/Tiles.get_children():
		x.queue_free()
	randomize()
	var start_x = $Surface/Floor.get_aabb().position.x
	var start_z = $Surface/Floor.get_aabb().position.z
	
	var end_x = $Surface/Floor.get_aabb().end.x
	var end_z = $Surface/Floor.get_aabb().end.z
	
	for x in range(start_x,end_x,5):
		for z in range(start_z,end_z,5):
			var r = res[randi()%res.size()].instantiate()
			$Surface/Tiles.add_child(r)
			r.global_position = Vector3(x+2.5,0.55,z+2.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_pressed():
	regenerate()
