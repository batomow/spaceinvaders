extends State

var timer: Timer = null 
var direction := Vector2()
var randirs = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
var sample: Array = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3] 
export (float) var speed = 25
const LIMIT_L = 16
const LIMIT_R = 784
const LIMIT_U = 16
const LIMIT_D = 788

func enter(): 
	print("enemy evading")
	sample.shuffle()
	if not timer: 
		var new_timer = Timer.new()
		new_timer.wait_time = 2
		new_timer.autostart = true
		(target as Node).add_child(new_timer)
		new_timer.connect("timeout", self, "_on_timeout")
	else: 
		timer.start()

func evaluate(_delta): 
	if Input.is_key_pressed(KEY_2): 
		machine.next = machine.states['dead']


func execute(delta): 
	if(target.position.x + direction.x * delta * speed) > LIMIT_R or (target.position.x + direction.x * delta * speed) < LIMIT_L:
		direction.x = -direction.x
	if(target.position.y + direction.y * delta * speed) > LIMIT_D or (target.position.y + direction.y * delta * speed) < LIMIT_U:
		direction.y = -direction.y

	target.position.x += direction.x * delta * speed
	target.position.y += direction.y * delta * speed

func _on_timeout(): 
	var front = sample.front()
	direction = randirs[front]
	sample.pop_front()
	sample.push_back(front)


func exit(): 
	if timer: 
		timer.stop()
