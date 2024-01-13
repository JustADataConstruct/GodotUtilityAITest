extends Window

@export var agent:CharacterBody3D
var _ai_agent
var nodes:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	title = agent.name
	_ai_agent = agent.get_node("UtilityAIAgent")
	var root = %DebugTree.create_item()
	root.set_text(0,"Behaviours")
	for x in _ai_agent.get_children():
		if x is UtilityAIBehaviour:
			var i = %DebugTree.create_item(root)
			i.set_text(0,x.name)
			nodes[x.name] = {"node":x,"tree":i}
			for y in x.get_children():
				var i2 = %DebugTree.create_item(i)
				i2.set_text(0,y.name)
				nodes[y.name] = {"node":y,"tree":i2}
				if y.get_child_count() > 0:
					for z in y.get_children():
						var i3 = %DebugTree.create_item(i2)
						i3.set_text(0,z.name)
						nodes[z.name] = {"node":z,"tree":i3}
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !visible:
		return
	var cbn = _ai_agent.current_behaviour_name
	var can = _ai_agent.get_current_action_node().name if _ai_agent.get_current_action_node() != null else ""
	for x in nodes.keys():
		var node = nodes[x].node
		var tree_item = nodes[x].tree
		if !node is UtilityAIAction:
			var value = str(floor(node.score*100)) + "%" if !%FloatRadio.button_pressed else str(node.score)
			#tree_item.set_text(0,node.name + ": " + str(floor(node.score*100)) + "%")
			tree_item.set_text(0,node.name + ": " + value)
		if node.name == cbn or node.name == can:
			tree_item.set_custom_color(0,Color.GREEN)
		else:
			tree_item.set_custom_color(0,Color.WHITE)
	%HungerContainer.get_node("HungerLabel").text = "Hunger: %.3f" % agent.hunger

func _on_close_requested():
	hide()

func _on_hunger_button_pressed():
	agent.hunger = float(%HungerContainer.get_node("HungerValue").text)
