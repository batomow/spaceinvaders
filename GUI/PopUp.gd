extends Popup

onready var anim := $Anim
var showing: bool = false

func _process(_delta):
    if Input.is_action_just_pressed("ui_accept"): 
        if not showing: 
            self.popup()
            (anim as AnimationPlayer).play("popup")
        else: 
            (anim as AnimationPlayer).play("PopDown")

func _on_Anim_animation_finished(_anim): 
    if showing: 
        self.popup()
    showing = not showing 
    
