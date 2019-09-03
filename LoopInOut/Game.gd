extends Control

export var active_color := Color("ffffff")
export var inactive_color := Color("888888")

const NAME_DARTS : String = "%s (%d)"

enum game_states {TARGET, CONQUER}
enum player_turns {PLAYER1, PLAYER2}

var last_action : Dictionary = {}

var players : int = 2 setget set_players_playing

var player1_darts : int = 0 setget set_player1_darts
var player1_target : int = 0 setget set_player1_target
var player2_darts : int = 0 setget set_player2_darts
var player2_target : int = 0 setget set_player2_target
var player1_remaining : int setget set_player1_remaining
var player2_remaining : int setget set_player2_remaining

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
onready var player2_scoreboard : PanelContainer = $PanelContainer/VBoxContainer/ScoreBoards/Player2Score

onready var target_panel : PanelContainer = $PanelContainer/VBoxContainer/TargetPanel
onready var conquer_panel : PanelContainer = $PanelContainer/VBoxContainer/ConquerPanel

func _ready() -> void:
	self.player_turn = player_turns.PLAYER1
	
	self.players = G.get_players_playing()
	
	self.player1_darts = 0
	self.player2_darts = 0
	
	self.player1_target = 0
	self.player2_target = 0
	
	self.player1_remaining = G.get_target()
	self.player2_remaining = G.get_target()

func set_players_playing(value : int) -> void:
	players = value
	
	player2_name_label.visible = players == 2
#	player2_turn.visible = players == 2
	player2_scoreboard.visible = players == 2

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
	if self.players == 2 and self.player_turn == player_turns.PLAYER1:
		self.player_turn = player_turns.PLAYER2
	else:
		self.player_turn = player_turns.PLAYER1

func set_player1_darts(value: int) -> void:
	player1_darts = value
	player1_name_label.text = NAME_DARTS % [G.get_player1_name(), player1_darts]

func set_player2_darts(value: int) -> void:
	player2_darts = value
	player2_name_label.text = NAME_DARTS % [G.get_player2_name(), player2_darts]

func set_player1_target(value: int) -> void:
	player1_target = value
	player1_target_label.text = str(player1_target)

func set_player2_target(value: int) -> void:
	player2_target = value
	player2_target_label.text = str(player2_target)

func set_player1_remaining(value: int) -> void:
	player1_remaining = value
	player1_remaining_label.text = str(player1_remaining)

func set_player2_remaining(value: int) -> void:
	player2_remaining = value
	player2_remaining_label.text = str(player2_remaining)

func _on_TargetPanel_entered_value(value) -> void:
	if player_turn == player_turns.PLAYER1:
		if value == 0:
			self.player1_darts += 3
		elif value > 1 and value <= player1_remaining and value != player1_remaining - 1:
			self.player1_target = value
			player1_gamestate = game_states.CONQUER
			self.player1_darts += 3
		else:
			return
	else:
		if value == 0:
			self.player2_darts += 3
		elif value > 1 and value <= player2_remaining and value != player2_remaining - 1:
			self.player2_target = value
			player2_gamestate = game_states.CONQUER
			self.player2_darts += 3
		else:
			return
	save_last_action(player_turn, game_states.TARGET, value, 3)
	next_player()

func _on_ConquerPanel_darts_to_checkout(darts) -> void:
	if darts == 0:
		if player_turn == player_turns.PLAYER1:
			self.player1_darts += 3
		else:
			self.player2_darts += 3
		save_last_action(player_turn, game_states.CONQUER)
		next_player()
	else:
		if player_turn == player_turns.PLAYER1:
			if can_checkout(darts, self.player1_target):
				save_last_action(player_turn, game_states.CONQUER, self.player1_target, darts)
				self.player1_darts += darts
				if self.player1_remaining == self.player1_target:
					player1_wins()
				self.player1_remaining -= self.player1_target
				self.player1_target = 0
				player1_gamestate = game_states.TARGET
				next_player()
		else:
			if can_checkout(darts, self.player2_target):
				save_last_action(player_turn, game_states.CONQUER, self.player2_target, darts)			
				self.player2_darts += darts
				if self.player2_remaining == self.player2_target:
					player2_wins()
				self.player2_remaining -= self.player2_target
				self.player2_target = 0
				player2_gamestate = game_states.TARGET
				next_player()

func player1_wins() -> void:
	G.set_winner(G.get_player1_name())
	G.set_darts(self.player1_darts)
	get_tree().change_scene("res://Win.tscn")

func player2_wins() -> void:
	G.set_winner(G.get_player2_name())
	G.set_darts(self.player2_darts)
	get_tree().change_scene("res://Win.tscn")

func can_checkout(darts, score) -> bool:
	return ((darts == 1 and score % 2 == 0 and (score <= 40 or score == 50)) or\
			(darts == 2 and (score < 99 or score in [100, 101, 104, 107, 110])) or\
			(darts == 3))
			
func _on_UndoButton_pressed() -> void:
	undo_last_action()

func save_last_action(player: int, type: int, value:int=0, darts:int=3) -> void:
	last_action = {'player': player,
					'type': type,
					'value': value,
					'darts': darts}

func undo_last_action() -> void:
	print(last_action)