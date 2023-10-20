extends CharacterBody2D

const MAX_STAT_VALUE = 5
const MIN_STAT_VALUE = 1

var inventory_resource = load("res://Inventory/Inventory.gd")
var inventory = inventory_resource.new()

var hunger : int = 3
var happiness : int = 3

func _ready() -> void:
	pass

