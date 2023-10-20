extends Control

@onready var nametag = $Name
@onready var image = $HBoxContainer/Icon
@onready var desc = $Description
@onready var cost = $Price

@export var merchandise :Array[ItemResource]
@export var description :Array[String]
@export var price :Array[int]

var itemsForSale : int
var currentItem : ItemResource
var select = 0

func _ready() -> void:
	itemsForSale = merchandise.size()
	switch_item(0)

func switch_item(index : int) -> void:
	currentItem = merchandise[index]
	if currentItem:
		nametag.text = currentItem.name
		image.texture = currentItem.texture
		desc.text = description[index]
		cost.text = "Cost: " + str(price[index])


func _on_next_pressed() -> void:
	select+=1
	select %= itemsForSale
	switch_item(select)


func _on_previous_pressed() -> void:
	select-=1
	select %= itemsForSale
	switch_item(select)


func _on_buy_pressed() -> void:
	var playerMoney = GameManager.player.inventory.item_count("Money")
	var value = price[select]
	if playerMoney < value:
		print("Player can't afford this item\nCosts: " + str(value) +"\nHas: " + str(playerMoney) + "\n")
		return
	
	GameManager.player.inventory.add_item(currentItem.name, 1)
	GameManager.player.inventory.remove_item("Money", value)
