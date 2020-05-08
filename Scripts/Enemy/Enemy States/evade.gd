extends State

var tween: Tween = null 
var direction := Vector2()
var future_position := Vector2()
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
		new_tween.connect("tween_all_completed", self, "_get_new_position")
		tween = new_tween
	_get_new_position()


func _get_new_position(): 
	var front = sample.pop_front()
	direction = randirs[front]
	sample.push_back(front)
	future_position  = target.position + direction * target.get_cell_size.call_func()  # dependency x 2
	target.validate_position.call_func(funcref(self, "_on_validated"), future_position)

func _on_validated(result:bool):
	if result == false:  # guard
		return _get_new_position()
	tween.interpolate_property(target, "position", target.position, future_position, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	if move_record.size() > 1: 
		var element = move_record.pop_front()
		target.free_cell.call_func(element) # dependency
	move_record.push_back(future_position)
