extends "res://El Santo/State.gd"

var direction := Vector2()
export (float) var speed
const LIMIT_L = 16
const LIMIT_R = 784
const LIMIT_U = 16
const LIMIT_D = 788

func enter(): 
	print("moving")

func evaluate(_delta): 
	direction.x = int(Input.is_action_pressed("second_right")) - int(Input.is_action_pressed("second_left"))
	direction.y = int(Input.is_action_pressed("second_down")) - int(Input.is_action_pressed("second_up"))
	if target.has_method("get_health"):
		if target.health <= 0: 
			machine.next = machine.states['dead']
	
func execute(delta): 
	target.position.x = clamp(target.position.x + direction.x * speed * delta, LIMIT_L, LIMIT_R)
	target.position.y = clamp(target.position.y + direction.y * speed * delta, LIMIT_U, LIMIT_D)
