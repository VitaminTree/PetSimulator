extends Node

# Reference Array for holding one of every existing item in the project.
var items = Array()
var count : int = 0

# Opens the folder with the Item resources and set a pointer to the 1st item
# For each item in the folder, add that item to the array if not already present
func _ready():
	var directory = DirAccess.open("res://Items")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while(filename):
		if not directory.current_is_dir():
			items.append(load("res://Items/%s" % filename))
			count += 1
		
		filename = directory.get_next()

# Iterate through the reference array looking for a specific item type.
# Returns an Item with the name "item_name" if found, null otherwise
func get_item(item_name):
	for i in items:
		if i.name == item_name:
			return i
	
	return null


func get_item_from_index(index : int) -> ItemResource:
	if count > 0:
		var truncated = index % count
		return items[truncated]
	else:
		return null
	
