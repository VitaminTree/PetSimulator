extends Control

@onready var hunger_label = $MarginContainer/VBoxContainer/HungerVariable
@onready var happy_label = $MarginContainer/VBoxContainer/HappinessVariable
var ceiling : int
var floor : int


func _ready() -> void:
	ceiling = GameManager.player.MAX_STAT_VALUE
	floor = GameManager.player.MIN_STAT_VALUE
	hunger_label.text = str(GameManager.player.hunger) + " / 5"
	happy_label.text = str(GameManager.player.happiness) + " / 5"
	Events.connect("modify_stat", _on_stats_modified)


func _on_stats_modified(itemType: ItemResource) -> void:
	change_hunger(itemType.modifier, itemType.power[0])
	change_happiness(itemType.modifier, itemType.power[1])


func change_hunger(isSet: bool, value : int) -> void:
	if value == 0:
		return
	
	var current = GameManager.player.hunger
	if isSet:
		current = value
	else:
		current += value
		if current > ceiling:
			current = ceiling
		if current < floor:
			current = floor
	GameManager.player.hunger = current
	hunger_label.text = str(current) + " / 5"


func change_happiness(isSet: bool, value : int) -> void:
	if value == 0:
		return
	
	var current = GameManager.player.happiness
	if isSet:
		current = value
	else:
		current += value 
		if current > ceiling:
			current = ceiling
		if current < floor:
			current = floor
	GameManager.player.happiness = current
	happy_label.text = str(current) + " / 5"
