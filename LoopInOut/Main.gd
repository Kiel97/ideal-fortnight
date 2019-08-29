extends Control

onready var player1 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player1TextEdit"
onready var player2 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player2TextEdit"
onready var start_btn = $"PanelContainer/VBoxContainer/Body/Buttons/StartButton"
onready var target_cbx = $"PanelContainer/VBoxContainer/Body/Players Grid/TargetOptionButton"

func _on_RulesButton_pressed() -> void:
	get_tree().change_scene("res://Help.tscn")

func _on_StartButton_pressed() -> void:
	if not player1.text.strip_edges():
		player1.text = "111"
	if not player2.text.strip_edges():
		player2.text = "222"
	start_game()

func start_game() -> void:
	G.set_player1_name(player1.text)
	G.set_player2_name(player2.text)
	G.set_target(get_target_value())
	
	get_tree().change_scene("res://Game.tscn")

func get_target_value() -> int:
	return int(target_cbx.get_item_text(target_cbx.get_selected_id()))