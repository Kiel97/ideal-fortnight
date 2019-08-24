extends Control

export var active_color := Color("ffffff")
export var inactive_color := Color("888888")

const NAME_DARTS : String = "%s (%d)"

enum game_states {TARGET, CONQUER}
enum player_turns {PLAYER1, PLAYER2}

var player1_darts : int = 0 setget set_player1_darts
var player1_target : int = 0 setget set_player1_target
var player2_darts : int = 0 setget set_player2_darts
var player2_target : int = 0 setget set_player2_target

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
	
	self.player1_darts = 0
	self.player2_darts = 0
	
	self.player1_target = 0
	self.player2_target = 0
	
	player1_remaining_label.text = str(player1_remaining)
	player2_remaining_label.text = str(player2_remaining)

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
	player_turn = value

func next_player() -> void:
	if self.player_turn == player_turns.PLAYER1:
		self.player_turn = player_turns.PLAYER2
	else:
		self.player_turn = player_turns.PLAYER1

func set_player1_darts(value: int) -> void:
	player1_darts = value
	player1_name_label.text = NAME_DARTS % [player1_name, player1_darts]

func set_player2_darts(value: int) -> void:
	player2_darts = value
	player2_name_label.text = NAME_DARTS % [player2_name, player2_darts]

func set_player1_target(value: int) -> void:
	player1_target = value
	player1_target_label.text = str(player1_target)

func set_player2_target(value: int) -> void:
	player2_target = value
	player2_target_label.text = str(player2_target)

func _on_TargetPanel_entered_value(value) -> void:
	if player_turn == player_turns.PLAYER1:
		self.player1_darts += 3
		self.player1_target = value
	else:
		self.player2_darts += 3
		self.player2_target = value
	next_player()