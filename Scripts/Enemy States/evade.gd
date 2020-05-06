extends State

var tween: Tween = null 
var direction := Vector2()
var current_position : = Vector2()
var past_position := Vector2()
var paster_position :=Vector2()
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
	if not tween: 
		var new_tween = Tween.new()
		(target as Node).add_child(new_tween)
		new_tween.connect("tween_all_completed", self, "_on_complete")
		tween = new_tween
	_on_complete()

func evaluate(_delta): 
	if Input.is_key_pressed(KEY_2): 
		machine.next = machine.states['dead']

func _on_complete(): 
	var front = sample.pop_front()
	# while not _validate_frame(target.position, randirs[front]): #validate that frame is within bounds
	# 	sample.push_back(front)
	# 	front = sample.pop_front()
	# 	yield(get_tree(), "idle_frame")
	direction = randirs[front]
	sample.push_back(front)
	var future_position  = target.position + direction * target.grid.cell_size
	target.grid.request_validation(self, "_on_validated", future_position)
		
func _on_validated(result:bool, future_position:Vector2):
	if not result: 
		_on_complete()
	else: 
		tween.interpolate_property(target, "position", target.position, future_position, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()

func _validate_frame(position:Vector2, _direction:Vector2)->bool: 
	var future_pos = (position - target.grid.offset * target.grid.cell_size + _direction*target.grid.cell_size)
	if (future_pos.y > LIMIT_U && future_pos.y < LIMIT_D && future_pos.x > LIMIT_L && future_pos.x < LIMIT_R):
		return true
	return false
