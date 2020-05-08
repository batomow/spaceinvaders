extends KinematicBody2D

class_name Enemy
onready var validate_position:FuncRef = SERVICEMANAGER.request("validate_position")
onready var free_cell:FuncRef = SERVICEMANAGER.request("free_cell")
onready var get_cell_size:FuncRef = SERVICEMANAGER.request("get_cell_size")
var ready: bool = false
var consumed_events = [] 

onready var machine:State = get_node('Machine')

func _ready():
	while not validate_position.is_valid() || not free_cell.is_valid() || not get_cell_size.is_valid(): 
		yield(get_tree(), "idle_frame")
	ready = true

func _process(delta):
	machine.evaluate(delta)

func _physics_process(delta):
	machine.execute(delta)

func _consume_event(event:int)->void:  #filter for relevant events
	match event: 
		EVENTMANAGER.EVENT.ENEMIES_LOADED: consumed_events.push_back(event)