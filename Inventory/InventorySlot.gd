extends Control
class_name InventorySlot

@onready var icon_button : TextureButton = $IconButton
@onready var quantity : Label = $IconButton/MarginContainer/Quantity
var index : int = -1

# TODO: Revise InventorySlot to have a reference to what index it is representing.
# 		When selected, return a reference to the same index in Inventory if the 
#		slot has a valid reference.
#		Also, how do I implement selecting an item?

func set_slot_data(item_data : Dictionary):
	icon_button.texture_normal = item_data.item_reference.texture
	tooltip_text = "%s" % item_data.item_reference.name
	
	if item_data.quantity > 1:
		quantity.text = "%s" % item_data.quantity
		quantity.show()
	else:
		quantity.hide()


func _on_icon_button_pressed() -> void:
	Events.emit_signal("slot_clicked", index)
	print("Icon Button pressed")
