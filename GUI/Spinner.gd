extends Control

onready var anim := $Anim
var showing: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"): 
		if not showing: 
			(anim as AnimationPlayer).play("spindown")
		else: 
			(anim as AnimationPlayer).play("spinup")

func _on_Anim_animation_finished(_anim): 
	showing = not showing 
