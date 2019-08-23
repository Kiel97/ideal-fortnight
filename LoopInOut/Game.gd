extends Control

const NAME_DARTS : String = "%s (%d)"

var player1_darts : int = 0
var player1_target : int = 0
var player2_darts : int = 0
var player2_target : int = 0

var player_turn : int = 1

onready var player1_name_label : Label = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Player1Label
onready var player1_remaining_label : Label = $PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/Player1RemainingLabel
onready var player1_target_label : Label = $PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/Player1Target
onready var player1_turn : ColorRect = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Player1Turn

onready var player2_name_label : Label = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Player2Label
onready var player2_remaining_label : Label = $PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/Player2RemainingLabel
onready var player2_target_label : Label = $PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/Player2Target
onready var player2_turn : ColorRect = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Player2Turn

onready var player1_remaining : int = G.get_target()
onready var player1_name : String = G.get_player1_name()

onready var player2_remaining : int = G.get_target()
onready var player2_name : String = G.get_player2_name()

func _ready() -> void:
	player1_name_label.text = NAME_DARTS % [player1_name, player1_darts]
	player2_name_label.text = NAME_DARTS % [player2_name, player2_darts]
	
	player1_remaining_label.text = str(player1_remaining)
	player2_remaining_label.text = str(player2_remaining)
	
	player1_target_label.text = str(player1_target)
	player2_target_label.text = str(player2_target)
	
	player1_turn.visible = true
	player2_turn.visible = false