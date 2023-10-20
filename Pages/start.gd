extends Node

@onready var current_level = $StartMenu

func _ready() -> void:
	Events.connect("level_changed", _on_level_change)


func _on_level_change(next_level_name: String):
	var next = load("res://Pages/" +next_level_name +".tscn")
	var temp = next.instantiate()
	add_child(temp)
	
	current_level.queue_free()
	current_level = temp
