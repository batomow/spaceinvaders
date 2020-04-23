extends KinematicBody2D

onready var machine:State = get_node('Machine')
signal moved
var signal_queue := [] 

func _process(delta):
    machine.evaluate(delta)
    if signal_queue: 
        var top = signal_queue.front()
        emit_signal("moved", top)
        signal_queue.pop_front()

func _physics_process(delta):
    machine.execute(delta)

func _queue_signal_move(position): 
    signal_queue.push_back(position)
