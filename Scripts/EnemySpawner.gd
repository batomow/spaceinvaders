extends Spawner

func _consume_event(event:int)->void:
    if event == EventManager.EVENT.GAME_START: 
        .spawn()
        EventManager.push(EventManager.EVENT.ENEMIES_PRELOADED)