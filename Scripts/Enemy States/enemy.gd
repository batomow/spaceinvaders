extends KinematicBody2D

onready var machine:State = get_node('Machine')
var signal_queue := [] 

func _process(delta):
    machine.evaluate(delta)

func _physics_process(delta):
    machine.execute(delta)
