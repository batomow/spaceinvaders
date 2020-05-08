extends TileMap

var enemies: Array 
var enemy_validation_queue = [] 

func _process(_delta):
	if enemy_validation_queue: 
		var request = enemy_validation_queue.pop_front()
		var result = _validate_position(request[1])
		(request[0] as FuncRef).call_func(result)

func validate_position(callback:FuncRef, param:Vector2):
	enemy_validation_queue.push_back([callback, param])

func _validate_position(position:Vector2)->bool:
	var gridpos = (self as TileMap).world_to_map(position)
	if get_cellv(gridpos) == 0: 
		(self as TileMap).set_cellv(gridpos, 1)
		return true
	return false 

func free_cell(position:Vector2):
	var gridpos = (self as TileMap).world_to_map(position)
	(self as TileMap).set_cellv(gridpos, 0)

func get_cell_size():
	return cell_size
