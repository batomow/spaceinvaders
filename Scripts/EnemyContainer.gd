extends Node

func _consume_event(event:int)->void: 
	if event == EVENTMANAGER.EVENT.ENEMIES_PRELOADED: 
		var children = get_children()
		while not children_ready(children): 
			yield(get_tree(), "idle_frame")
		EVENTMANAGER.push(EVENTMANAGER.EVENT.ENEMIES_LOADED)

func children_ready(children:Array)->bool: 
	for child in children: 
		if not child is Enemy: 
			continue
		if not child.ready: 
			return false
	return true
