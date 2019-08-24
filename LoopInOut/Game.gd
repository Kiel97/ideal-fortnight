extends Control

export var active_color := Color("ffffff")
export var inactive_color := Color("888888")

const NAME_DARTS : String = "%s (%d)"

enum game_states {TARGET, CONQUER}
enum player_turns {PLAYER1, PLAYER2}

var player1_darts : int = 0
var player1_target : int = 0
var player2_darts : int = 0
var player2_target : int = 0

var player_turn : int = player_turns.PLAYER1 setget set_player_turn
var player1_gamestate : int = game_states.TARGET
var player2_gamestate : int = game_states.TARGET

onready var player1_name_label : Label = $PanelContainer/VBoxContainer/PlayersHeader/HBoxContainer/Player1Label
onready var player1_remaining_label : Label = $PanelContainer/VBoxContainer/ScoreBoards/Player1Score/VBoxContainer/Player1RemainingLabel
onready var player1_target_label : Label = $PanelContainer/VBoxContainer/ScoreBoards/Player1Score/VBoxContainer/Player1Target
onready var player1_turn : ColorRect = $PanelContainer/VBoxContainer/PlayersHeader/HBoxContainer/Player1Turn

onready var player2_name_label : Label = $PanelContainer/VBoxContainer/PlayersHeader/HBoxContainer/Player2Label
onready var player2_remaining_label : Label = $PanelContainer/VBoxContainer/ScoreBoards/Player2Score/VBoxContainer/Player2RemainingLabel
onready var player2_target_label : Label = $PanelContainer/VBoxContainer/ScoreBoards/Player2Score/VBoxContainer/Player2Target
onready var player2_turn : ColorRect = $PanelContainer/VBoxContainer/PlayersHeader/HBoxContainer/Player2Turn

onready var target_panel : PanelContainer = $PanelContainer/VBoxContainer/TargetPanel
onready var conquer_panel : PanelContainer = $PanelContainer/VBoxContainer/ConquerPanel

onready var player1_remaining : int = G.get_target()
onready var player1_name : String = G.get_player1_name()

onready var player2_remaining : int = G.get_target()
onready var player2_name : String = G.get_player2_name()

func _ready() -> void:
	self.player_turn = player_turns.PLAYER1
	
	player1_name_label.text = NAME_DARTS % [player1_name, player1_darts]
	player2_name_label.text = NAME_DARTS % [player2_name, player2_darts]
	
	player1_remaining_label.text = str(player1_remaining)
	player2_remaining_label.text = str(player2_remaining)
	
	player1_target_label.text = str(player1_target)
	player2_target_label.text = str(player2_target)

func set_player_turn(value : int) -> void:
	player1_turn.visible = not value
	player2_turn.visible = value
	
	if value == player_turns.PLAYER1:
		if player1_gamestate == game_states.TARGET:
			conquer_panel.visible = false
			target_panel.visible = true
			player1_target_label.set("custom_colors/font_color", inactive_color)
			player1_remaining_label.set("custom_colors/font_color", active_color)
		else:
			target_panel.visible = false
			conquer_panel.visible = true
			player1_target_label.set("custom_colors/font_color", active_color)
			player1_remaining_label.set("custom_colors/font_color", inactive_color)
	else:
		if player2_gamestate == game_states.TARGET:
			conquer_panel.visible = false
			target_panel.visible = true
			player2_target_label.set("custom_colors/font_color", inactive_color)
			player2_remaining_label.set("custom_colors/font_color", active_color)
		else:
			target_panel.visible = false
			conquer_panel.visible = true
			player2_target_label.set("custom_colors/font_color", active_color)
			player2_remaining_label.set("custom_colors/font_color", inactive_color)