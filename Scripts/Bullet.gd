extends KinematicBody2D

const READY = 0
const FIRED = 0
const DONE = 0
var state:int = READY

const SPEED = 64 #pixels

onready var timer: Timer  = $Timer

func _init():
    set_process(false)

func _ready(): 
    timer.wait_time = 3

func _process(delta): 
    var collision = (self as KinematicBody2D).move_and_collide(Vector2.DOWN * SPEED*delta)
    if collision: 
        print("collided")

func fire():
    self.set_process(true)
    state = FIRED