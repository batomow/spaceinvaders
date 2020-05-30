extends Control
onready var children = get_children()
var alphar = range(0, 14, 2) 
const alphac = PI/6
var positions := [] 
onready var tween: Tween= get_node("../Tween")
var repeats = 0
var current_num = 0
var blocked := false
var spin_dir = 1

func _ready():
	var alpha := [] 
	for a in alphar: 
		alpha.push_back(a*alphac)
	
	for a in alpha: 
		positions.push_back(Vector2(
			sin(a)*50+22,
			cos(a)*50
		))
	
	var index = 0
	for child in children: 
		(child as Button).rect_position = positions.pop_back()
		var deg = -rad2deg(alpha.pop_back())
		(child as Button).rect_rotation = deg if index > 3 else deg + 180
		child.visible = false
		index += 1

func spin(): 
	(tween as Tween).interpolate_property(
		self, "rect_rotation",
		self.rect_rotation,
		self.rect_rotation + (spin_dir*60), 
		0.5, 
		Tween.TRANS_BOUNCE, 
		Tween.EASE_IN_OUT)
	(tween as Tween).start()

func _on_Button_pressed(num):
	if not blocked: 
		var dif = current_num - num
		print(dif)
		spin_dir = 1 if dif > 0 else -1
		repeats = int(abs(dif)) % 4
		if repeats > 0:
			current_num = num
			blocked = true
			spin()

func _on_Tween_tween_completed(_x, _y): 
	repeats -= 1
	if repeats == 0: 
		blocked = false
	else: 
		spin()
