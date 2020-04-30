extends TileMap

export (NodePath) var enemy_spawner_path:NodePath
export (NodePath) var enemy_cointainer_path:NodePath
var enemy_container: Node
var enemies: Array 

const HEIGHT = 720
const WIDTH = 800
const CELL_SIZE = Vector2(64, 64)

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
	
