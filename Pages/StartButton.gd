extends Button


func _on_pressed() -> void:
	Events.emit_signal("level_changed", "main")
