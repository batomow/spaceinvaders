extends State

func enter(): 
    print("dead")


func evaluate(_delta): 
    if Input.is_key_pressed(KEY_1): 
        machine.next = machine.states['move']
    if Input.is_key_pressed(KEY_4): 
        machine.next = machine.states['machine']