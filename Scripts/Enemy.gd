extends KinematicBody2D

class_name Enemy

onready var machine:State = get_node('Machine')
var ready := false

#====== Dependencies ========#
var grid: TileMap
#======= VVVVVVVVVV =========#

func _process(delta):
    machine.evaluate(delta)

func _physics_process(delta):
    machine.execute(delta)

func _all_dependencies_ready()->bool: 
    if grid: 
        return true
    return false

func _consume_event(event:int)->void: 
    if event == EventManager.EVENT.ENEMIES_LOADED: 
        ready = true