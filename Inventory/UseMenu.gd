extends Control

# !!! For Nodes that are children of the PanelContainer,
# !!!	Control > Mouse > Filter must be set to "Pass" or "Ignore"
# !!! 	Nodes with their own GUI input events (Buttons, etc) set to PASS only

@onready var id = $PanelContainer/MarginContainer/VBoxContainer/ItemName
@onready var container = $PanelContainer
@onready var useButton = $PanelContainer/MarginContainer/VBoxContainer/UseButton
var index : int
var isMouseInTheBox: bool

# If We're in the correct scene to use items,
# 	and the index provided has an item that is defined as a CONSUMABLE
#		enable the use button
func _ready() -> void:
	if get_tree().get_first_node_in_group("ConsumablesOK"):
		useButton.disabled = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not isMouseInTheBox:
			queue_free()
			print("Left button was clicked at ", event.position)


func _on_use_button_pressed() -> void:
	var item = GameManager.player.inventory.get_an_item(index).item_reference
	Events.emit_signal("modify_stat", item)
	GameManager.player.inventory.remove_item(item.name)

func _on_sell_button_pressed() -> void:
	var item = GameManager.player.inventory.get_an_item(index)
	GameManager.player.inventory.remove_item(item.item_reference.name, 1)
	GameManager.player.inventory.add_item("Money", 100)


func _on_panel_container_mouse_entered() -> void:
	isMouseInTheBox = true


func _on_panel_container_mouse_exited() -> void:
	isMouseInTheBox = false
