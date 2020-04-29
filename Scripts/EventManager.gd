extends Node

signal upated
var _event_queue: Array = [] 

enum EVENT{
    GAME_START,
    ENEMIES_LOADED, 
    ITEMS_LOADED,
    PLAYER_READY,
    PLAYER_DEAD
}

func _ready():
    push(EVENT.GAME_START)

func push(event:int):
    _event_queue.push_back(event)
    emit_signal("upated")
