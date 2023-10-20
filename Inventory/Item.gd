extends Resource

class_name ItemResource

@export var name : String
@export var stackable : bool = false
@export var max_stack_size : int = 1

@export var texture : Texture
@export var mesh = Mesh

#examples of properties we can store
enum ItemType { GENERIC, CONSUMABLE, QUEST, EQUIPMENT}
@export var type : ItemType

# For consumable items, define whether it sets its stat(s) to a fixed value, or adds/subtracts from its stat(s)
enum ModifierType {ADD, SET}
@export var modifier : ModifierType
# When consumed, sets or adds to the stat in this order:
# Hunger
# Happiness
# Value of 0 (zero) is interpreted as "N/A"; Will not set a stat to 0
@export var power : Array[int]

