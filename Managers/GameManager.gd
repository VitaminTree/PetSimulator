extends Node

var player : CharacterBody2D

func _process(_delta):
	if not player:
		initialise_player()
		return


func initialise_player():
	print("a")
	if get_tree().get_root().has_node("Player"):
		player = get_tree().get_root().get_node("Player")
	else:
		var p = preload("res://player.tscn").instantiate()
		get_tree().root.add_child(p)
		return
#
#	Events.emit_signal("player_initialised", player)
#
	var callable = Callable(self, "_on_player_inventory_changed")
	player.inventory.connect("inventory_changed", callable)
	
	var existing_inventory = load("user://inventory.tres")
	if(existing_inventory):
		print("User inventory found.")
		player.inventory.set_items(existing_inventory.get_all_items())
		#player.inventory.remove_item("Apple", 2)
	else:
		print("No user inventory found. Default action: assign 3 apples.")
		player.inventory.add_item("Apple", 3)


func _on_player_inventory_changed(inventory):
	var err = ResourceSaver.save(inventory, "user://inventory.tres")
	if err != 0:
		print("Couldn't save inventory")
