extends State

var timer: Timer = null 
var direction := Vector2()
var last_position := Vector2()
var randirs = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
var sample: Array = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3] 
export (float) var speed = 100
const LIMIT_L = 16
const LIMIT_U = 16
const LIMIT_R = 784
const LIMIT_D = 788

func enter(): 
	print("enemy evading")
	sample.shuffle()
	if not timer: 
		var new_timer = Timer.new()
		new_timer.wait_time = 1
		new_timer.autostart = true
		(target as Node).add_child(new_timer)
		new_timer.connect("timeout", self, "_on_timeout")
	else: 
		timer.start()

func evaluate(_delta): 
	if Input.is_key_pressed(KEY_2): 
		machine.next = machine.states['dead']


func execute(delta): 
	target.position += direction * delta * speed

func _on_timeout(): 
	var front = sample.pop_front()
	if last_position:
		(target as Enemy).grid.free_cell(last_position)
	while not (target as Enemy).grid.validate_position(target.position + randirs[front]) or not _validate_frame(target.position, randirs[front]):
		front = sample.pop_front()
		sample.push_back(front)
		yield(get_tree(), "idle_frame")
	direction = randirs[front]
	last_position = target.position + direction
	sample.push_back(front)

func _validate_frame(position:Vector2, _direction:Vector2)->bool: 
	var future_pos = (position - target.grid.offset * target.grid.cell_size + _direction*target.grid.cell_size)
	if (future_pos.y > LIMIT_U && future_pos.y < LIMIT_D && future_pos.x > LIMIT_L && future_pos.x < LIMIT_R):
		return true
	return false

func exit(): 
	if timer: 
		timer.stop()

