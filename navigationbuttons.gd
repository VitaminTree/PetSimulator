extends CanvasLayer


func _on_wardrobe_pressed() -> void:
	Events.emit_signal("level_changed", "wardrobe")


func _on_home_pressed() -> void:
	Events.emit_signal("level_changed", "main")


func _on_interact_pressed() -> void:
	Events.emit_signal("level_changed", "feed")


func _on_shop_pressed() -> void:
	Events.emit_signal("level_changed", "shop")
