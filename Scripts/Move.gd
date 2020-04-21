extends "res://El Santo/State.gd"

var direction := Vector2()
export (float) var speed

func enter(): 
	print("moving")

func evaluate(_delta): 
	direction.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	direction.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	if target.has_method("get_health"):
		if target.health <= 0: 
			machine.next = machine.states['dead']
	

	
func execute(_delta): 
	target.position += direction * speed * _delta
