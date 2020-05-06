extends State

func enter():
    print("enemy idle")

func evaluate(_delta): 
    if target.ready: 
        machine.next = machine.states['evade']

