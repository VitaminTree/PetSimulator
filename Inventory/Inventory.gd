extends Resource

class_name Inventory

signal inventory_changed

# Private variable (_name), but exported?
# Without export, changes won't presist and the next time inventory is loaded
# it will be empty
@export var _items = Array() : set = set_items, get = get_all_items

func set_items(new_items):
	_items = new_items
	emit_signal("inventory_changed", self)


func get_all_items():
	return _items


func get_an_item(index):
	return _items[index]


func has_item(name : String) -> bool:
	for i in _items:
		if i.item_reference.name == name:
			return true
	return false


func item_count(name: String) -> int:
	var count = 0
	if has_item(name):
		for i in _items:
			if i.item_reference.name == name:
				count += i.quantity
	return count


func add_item(item_name, quantity):
	if quantity <= 0:
		print("Can't add a non-positive number of items")
		return
	
	var item : ItemResource = ItemManager.get_item(item_name)
	if not item:
		print("Could not find item " + item_name)
		return
	
	var remaining_quantity = quantity
	var max_stack_size = item.max_stack_size if item.stackable else 1
	
	# If item being added is stackable, seach every inventory slot for that item type.
	# Search continues until all existing stacks are filled or New_Item's quantity reaches 0
	if item.stackable:
		for i in range(_items.size()):
			# If quantity of new item reaches zero, exit loop
			if(remaining_quantity == 0):
				break
			
			# If item in slot doesn't match type of new item, skip over
			var inventory_item = _items[i]
			
			if inventory_item.item_reference.name != item.name:
				continue
			
			# If adding an amount that would exceed the max stack size
			# example (max: 10, current: 7, adding: 5)
			# add enough so current stack fills
			# set remaining quantity of new item to the remainder
			if inventory_item.quantity < max_stack_size:
				var original_quantity =  inventory_item.quantity
				inventory_item.quantity = min(original_quantity + remaining_quantity, max_stack_size)
				remaining_quantity -= inventory_item.quantity - original_quantity
	
	# If item isn't stackable OR quantity remains after filling all other stacks
	# make new entries into the inventory. 
	while remaining_quantity > 0:
		var new_item = {
			item_reference = item, 
			quantity = min(remaining_quantity, max_stack_size)
		}
		_items.append(new_item)
		remaining_quantity -= new_item.quantity
	
	emit_signal("inventory_changed", self)


func remove_item(item_name, quantity : int = 1):
	if quantity <= 0:
		print("Can't remove a non-positive amount of objects")
		return
	
	var item : ItemResource = ItemManager.get_item(item_name)
	if not item:
		print("Could not find item " + item_name)
		return
	
	var remaining_quantity = quantity
	
	var i = 0
	while i < _items.size():
		var position = _items.size() - (i + 1)
		if remaining_quantity == 0:
			break
		
		var inventory_item = _items[position]
		
		if inventory_item.item_reference.name != item.name:
			i += 1
			continue
		
		if item.stackable:
			var original_quantity =  inventory_item.quantity
			inventory_item.quantity = max(original_quantity - remaining_quantity, 0)
			if inventory_item.quantity > 0:
				emit_signal("inventory_changed", self)
				break
			remaining_quantity -= original_quantity
		else:
			remaining_quantity -= 1	
			
		_items.remove_at(position)
		
	
	emit_signal("inventory_changed", self)



# TODO:
# Searching the entire array would be costly if this needs to handle a very large amount of items
# Change Get and Set functions to search for items in the database based on name, then modify
# existing indexes if they exist.
