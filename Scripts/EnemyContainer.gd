extends Node

func _consume_event(event:int)->void: 
    if event == EventManager.EVENT.ENEMIES_PRELOADED: 
        var enemies = get_children()
        for enemy in enemies: 
            if enemy is Enemy:
                if not enemy._all_dependencies_ready(): 
                    printerr("Enemy: {0} didn't manage to load all dependencies" % enemy.name)
                    return
        EventManager.push(EventManager.EVENT.ENEMIES_LOADED)
