extends KinematicBody2D

onready var machine: State = get_node('Machine')
var health: float = 1 setget set_health, get_health
var attack: float = 1 setget set_attack, get_attack
var bullets: float = 1

func _process(delta):
	machine.evaluate(delta)

func _physics_process(delta):
	machine.execute(delta)

func set_health(amount: float = 0): 
	health = clamp(health + amount, 0, 1)

func get_health(): 
	return health

func set_attack(amount: float = 0): 
	attack = clamp(attack + amount, 0, 1)

func get_attack(): 
	return attack
