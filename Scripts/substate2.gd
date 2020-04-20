extends State

func enter(): 
	print("substate2")

func evaluate(_delta):
	if Input.is_key_pressed(KEY_5): 
		machine.next = machine.states['substate']
	if Input.is_key_pressed(KEY_1): 
		machine.machine.next = machine.machine.states['move']
	if Input.is_key_pressed(KEY_7): 
		machine.machine.next = machine.machine.states['last']
	
