extends Control

const MINIMUM_SLOTS_IN_INVENTORY : int = 4

var template = preload("res://Inventory/InventorySlot.tscn")
@onready var grid = $Inventroy/MarginContainer/GridContainer
@onready var container : PanelContainer = $Inventroy


func _ready():
	var inv = GameManager.player.inventory
	inv.connect("inventory_changed", _on_player_inventory_changed)
	_on_player_inventory_changed(inv)
	
	Events.connect("slot_clicked", _on_inventory_slot_clicked)
	
	if GameManager.isBackpackHidden:
		container.hide()
	else:
		container.show()


func _on_inventory_slot_clicked(index: int):
	var menu = load("res://Inventory/use_menu.tscn")
	var menu_node = menu.instantiate()
	grid.add_child(menu_node)
	# Set parameters of new Menu
	menu_node.index = index
	menu_node.id.text = GameManager.player.inventory.get_an_item(index).item_reference.name
	if GameManager.player.inventory.get_an_item(index).item_reference.type != 1:
		menu_node.useButton.disabled = true

# When inventory changes, flush the slots of old information
# Draw slots again based on the new information.
func _on_player_inventory_changed(inventory): 
	for n in grid.get_children():
		n.queue_free()
	
	var draw_grids : int = max(MINIMUM_SLOTS_IN_INVENTORY, inventory._items.size())
	var slot
	
	var i : int = 0
	for item in inventory.get_all_items():
		slot = template.instantiate()
		grid.add_child(slot)
		
		if item != null:
			slot.index = i
			i += 1
			slot.set_slot_data(item)
			
		draw_grids -= 1
	
	while draw_grids > 0:
		slot = template.instantiate()
		grid.add_child(slot)
		draw_grids -= 1


func _on_texture_button_pressed() -> void:
	if GameManager.isBackpackHidden:
		container.show()
	else:
		container.hide()
	GameManager.isBackpackHidden = !GameManager.isBackpackHidden
