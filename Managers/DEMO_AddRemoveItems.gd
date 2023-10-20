extends MarginContainer

func _on_button_pressed():
	GameManager.player.inventory.add_item("Apple", 8)


func _on_button_2_pressed():
	GameManager.player.inventory.remove_item("Apple", 8)
	

func _on_button_3_pressed():
	GameManager.player.inventory.add_item("Fish", 1)


func _on_button_4_pressed():
	GameManager.player.inventory.remove_item("Fish", 8)
	GameManager.player.inventory.remove_item("Baby Yoda", 2)


func _on_money_add_pressed() -> void:
	GameManager.player.inventory.add_item("Money", 500)


func _on_money_remove_pressed() -> void:
	GameManager.player.inventory.remove_item("Money", 500)
