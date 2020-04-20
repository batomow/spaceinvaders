extends State

func enter(): 
    print("substate")

func evaluate(_delta): 
    if Input.is_key_pressed(KEY_6): 
        machine.next = machine.states['substate2']