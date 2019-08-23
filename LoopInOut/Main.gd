extends Control

onready var player1 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player1TextEdit"
onready var player2 = $"PanelContainer/VBoxContainer/Body/Players Grid/Player2TextEdit"
onready var start_btn = $"PanelContainer/VBoxContainer/Body/Buttons/StartButton"
onready var target_cbx = $"PanelContainer/VBoxContainer/Body/Players Grid/TargetOptionButton"

func _on_DefaultButton_pressed() -> void:
	insert_defaults()
	toggle_start_button()

func _on_RulesButton_pressed() -> void:
	get_tree().change_scene("res://Help.tscn")

func _on_StartButton_pressed() -> void:
	start_game()

func _on_Player1TextEdit_text_changed(new_text: String) -> void:
	toggle_start_button()

func _on_Player2TextEdit_text_changed(new_text: String) -> void:
	toggle_start_button()

func insert_defaults() -> void:
	player1.text = "111"
	player2.text = "222"

func start_game() -> void:
	G.set_player1_name(player1.text)
	G.set_player2_name(player2.text)
	G.set_target(get_target_value())
	
	get_tree().change_scene("res://Game.tscn")

func get_target_value() -> int:
	return int(target_cbx.get_item_text(target_cbx.get_selected_id()))

func toggle_start_button() -> void:
	start_btn.disabled = player1.text.strip_edges() == ""\
			or player2.text.strip_edges() == ""