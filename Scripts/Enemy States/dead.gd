extends State

func enter(): 
    print("enemy dead")

func evaluate(_delta): 
    if Input.is_key_pressed(KEY_1):
        machine.next = machine.states['evade']