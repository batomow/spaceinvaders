extends El_Santo

class_name  Move
var direction := Vector2() 
var target: Node2D
export(int) var speed = 100

func _ready():
	target = get_parent()
	
func _process(_delta):
	direction.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	direction.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))

func _physics_process(delta):
	target.position += direction * speed * delta
