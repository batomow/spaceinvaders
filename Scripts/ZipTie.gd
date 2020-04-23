extends Node

export (String) var tag = "ziptie"

export (Dictionary) var cables = {} 

func add(source:Object, source_signal:String, target:Object, target_method:String, binds:Array = [ ])->bool: 
    var err = source.connect(source_signal, target, target_method, binds)
    if not err: 
        if cables.has(source.name):
        cables[source.name] = {
            "target": target.name, 
            "method": target_method
    }
    return true if err else false

func remove(source: Object, target: Object): 
    if cables.has(source.name): 
        cables

func clear(): 
    pass