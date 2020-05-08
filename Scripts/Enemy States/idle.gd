extends State

func evaluate(_delta):  #consume relevant events for this state
    if target.consumed_events: 
        var front = target.consumed_events.pop_front()
        if front == EVENTMANAGER.EVENT.ENEMIES_LOADED: 
            machine.next = machine.states["evade"]