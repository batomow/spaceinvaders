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

func validate_position(position:Vector2)->bool:
	var gridpos = (self as TileMap).world_to_map(position-offset)
	if get_cellv(gridpos) == 0: 
		(self as TileMap).set_cellv(gridpos-offset, 1)
		return true
	return false 

func _validate_position(_position: Vector2)->bool: #needs to do callback, change yield on Enemy:evade.gd 
	return false

func free_cell(position:Vector2):
	var gridpos = (self as TileMap).world_to_map(position-offset)
	(self as TileMap).set_cellv(gridpos-offset, 0)
