extends State

func enter(): 
	print("trapped")

func evaluate(_delta): 
	if Input.is_key_pressed(KEY_3): 
		machine.next = machine.states['dead']
