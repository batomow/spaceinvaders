extends TileMap

export (NodePath) var enemy_spawner_path:NodePath
export (NodePath) var enemy_cointainer_path:NodePath
var enemy_container: Node
var enemies: Array 
var enemy_validation_queue = [] 

func _ready():
	self.position = Vector2()
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

func _process(_delta):
	if enemy_validation_queue: 
		var request = enemy_validation_queue.pop_front()
		var result = _validate_position(request.param)
		request.object.call(request.method, result, request.param)

func request_validation(object:Object, method:String, param:Vector2):
	var new_request = {
		"object": object, 
		"method": method,
		"param": param
	}
	enemy_validation_queue.push_back(new_request)

func _validate_position(position:Vector2)->bool:
	var gridpos = (self as TileMap).world_to_map(position)
	if get_cellv(gridpos) == 0: 
		(self as TileMap).set_cellv(gridpos, 1)
		return true
	return false 

func free_cell(position:Vector2):
	var gridpos = (self as TileMap).world_to_map(position)
	(self as TileMap).set_cellv(gridpos, 0)
