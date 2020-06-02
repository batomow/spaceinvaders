extends Spawner

func _ready():
    var err = self.connect("loaded", get_node(container_path), "_on_loaded")
    if err: 
        print(err)
    spawn()