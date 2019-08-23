extends Node

var player1_name : String setget set_player1_name, get_player1_name
var player2_name : String setget set_player2_name, get_player2_name
var target : int setget set_target, get_target

func set_player1_name(value : String) -> void:
	player1_name = value

func set_player2_name(value : String) -> void:
	player2_name = value

func set_target(value : int) -> void:
	target = value

func get_player1_name() -> String:
	return player1_name

func get_player2_name() -> String:
	return player2_name

func get_target() -> int:
	return target