extends State

var tween: Tween = null 
var direction := Vector2()
var move_record := [] 
var randirs = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO]
var sample: Array = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3] 
export (float) var speed = 100

func enter(): 
	sample.shuffle()
	sample.push_front(4)
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
	direction = randirs[front]
	sample.push_back(front)
	var future_position  = target.position + direction * target.grid.cell_size
	target.grid.request_validation(self, "_on_validated", future_position)
		
func _on_validated(result:bool, future_position:Vector2):
	if result == false: 
		_on_complete()
	else: 
		tween.interpolate_property(target, "position", target.position, future_position, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		if move_record.size() > 1: 
			var element = move_record.pop_front()
			target.grid.free_cell(element)
		move_record.push_back(future_position)
