extends Node

func _on_loaded(): 
	var children = get_children()
	for child in children: 
		child.fire()
