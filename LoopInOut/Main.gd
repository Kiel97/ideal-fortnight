extends Control

onready var player1 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player1TextEdit"
onready var player2 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player2TextEdit"

func _ready() -> void:
	pass # Replace with function body.

func _on_DefaultButton_pressed() -> void:
	insert_defaults()

func _on_RulesButton_pressed() -> void:
	get_tree().change_scene("res://Help.tscn")

func insert_defaults() -> void:
	player1.text = "111"
	player2.text = "222"
