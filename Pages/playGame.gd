extends Button


func _on_pressed() -> void:
	Events.emit_signal("play_game", "TicTacToe")
