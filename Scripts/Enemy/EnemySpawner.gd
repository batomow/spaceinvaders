extends Spawner

func _consume_event(event:int)->void:
    if event == EVENTMANAGER.EVENT.GAME_START: 
        .spawn()
        EVENTMANAGER.push(EVENTMANAGER.EVENT.ENEMIES_PRELOADED)