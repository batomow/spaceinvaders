extends TileMap

export (NodePath) var enemy_spawner_path:NodePath
export (NodePath) var enemy_cointainer_path:NodePath
var enemy_container: Node
var enemies: Array 
export (Vector2) var offset
var enemy_validation_queue = [] 

func _ready():
	enemy_container = get_node(enemy_cointainer_path)
	var enemy_spawner = get_node(enemy_spawner_path)
	var err = enemy_spawner.connect("loaded", self, "_on_loaded_enemies")
	if err: 
		printerr("Couldn't subscribe {0} to {1}".format([self.name, enemy_container.name]))

func _on_loaded_enemies()->void: 
	enemies = enemy_container.get_children()
	for enemy in enemies: 
		if (enemy is Enemy):
			enemy.grid = (self as TileMap)

func _process(delta):
	if enemy_validation_queue: 
		var front = enemy_validation_queue.pop_front()
		var result = _validate_position(front.position)
		front.requester.call(front.method, result, front.position)

func request_validation(requester:Object, method:String, position:Vector2):
	var new_request = {
		"requester": requester, 
		"method": method,
		"position": position
	}
	enemy_validation_queue.push_back(new_request)

func _validate_position(position:Vector2)->bool:
	var gridpos = (self as TileMap).world_to_map(position-offset)
	if get_cellv(gridpos) == 0: 
		print(get_cellv(gridpos))
		(self as TileMap).set_cellv(gridpos-offset, 1)
		return true
	return false 

func free_cell(position:Vector2):
	var gridpos = (self as TileMap).world_to_map(position-offset)
	(self as TileMap).set_cellv(gridpos-offset, 0)
