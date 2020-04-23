extends TileMap

var enemies: Array 

const HEIGHT = 720
const WIDTH = 800
const CELL_SIZE = Vector2(64, 64)
var position_queue := [] 
var tiles_to_reset := [] 

func _ready():
    enemies = get_tree().get_nodes_in_group("enemies")
    for enemy in enemies: 
        enemy.connect("moved", self, "_on_enemy_moved")

func _on_enemy_moved(position): 
    position_queue.push_back(position)

func _process(_delta):
    if position_queue: 
        var top = position_queue.front()
        var cellx = top.x /  CELL_SIZE.x
        var celly = top.y / CELL_SIZE.y
        self.set_cell(cellx, celly, 1)
        tiles_to_reset.push_back(Vector2(cellx, celly))
        position_queue.pop_front()

func _on_Timer_timeout(): 
    if tiles_to_reset: 
        var top = tiles_to_reset.front()
        self.set_cell(top.x, top.y, 0)
        tiles_to_reset.pop_front()
