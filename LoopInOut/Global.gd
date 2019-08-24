extends Node

var player1_name : String setget set_player1_name, get_player1_name
var player2_name : String setget set_player2_name, get_player2_name
var target : int setget set_target, get_target

var winner : String setget set_winner, get_winner
var darts : int setget set_darts, get_darts

func set_player1_name(value : String) -> void:
	player1_name = value

func set_player2_name(value : String) -> void:
	player2_name = value

func set_target(value : int) -> void:
	target = value

func set_winner(value : String) -> void:
	winner = value

func set_darts(value : int) -> void:
	darts = value

func get_player1_name() -> String:
	return player1_name

func get_player2_name() -> String:
	return player2_name

func get_target() -> int:
	return target

func get_winner() -> String:
	return winner

func get_darts() -> int:
	return darts