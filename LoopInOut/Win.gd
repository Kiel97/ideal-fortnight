extends Control

const MESSAGE = "%s wygrywa! Udalo mu sie osiagnac cel %d przy uzyciu %d lotek."

onready var stats_label : Label = $PanelContainer/VBoxContainer/StatsLabel

func _ready() -> void:
	stats_label.text = MESSAGE % [G.get_winner(), G.get_target(), G.get_darts()]

func _on_OKButton_pressed() -> void:
	get_tree().change_scene("res://Main.tscn")