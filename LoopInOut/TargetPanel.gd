extends PanelContainer

signal entered_value(value)

onready var target_value : Label = $VBoxContainer/PanelContainer/InsertedValueLabel

var keyboard_value : String = ""

func insert_digit(digit : String) -> void:
	if keyboard_value == "0":
		keyboard_value = digit
	elif keyboard_value.length() < 3:
		keyboard_value += digit
	update_label()

func clear_label() -> void:
	keyboard_value = ""
	update_label()

func update_label() -> void:
	target_value.text = keyboard_value

func _on_OneButton_pressed() -> void:
	insert_digit("1")

func _on_TwoButton_pressed() -> void:
	insert_digit("2")

func _on_ThreeButton_pressed() -> void:
	insert_digit("3")

func _on_FourButton_pressed() -> void:
	insert_digit("4")

func _on_FiveButton_pressed() -> void:
	insert_digit("5")

func _on_SixButton_pressed() -> void:
	insert_digit("6")

func _on_SevenButton_pressed() -> void:
	insert_digit("7")

func _on_EightButton_pressed() -> void:
	insert_digit("8")

func _on_NineButton_pressed() -> void:
	insert_digit("9")

func _on_ZeroButton_pressed() -> void:
	if keyboard_value != "0":
		insert_digit("0")

func _on_BackspaceButton_pressed() -> void:
	keyboard_value = keyboard_value.substr(0, keyboard_value.length() - 1)
	update_label()

func _on_OKButton_pressed() -> void:
	if keyboard_value.empty():
		emit_signal("entered_value", 0)
	else:
		if int(keyboard_value) <= 170 and not(int(keyboard_value) in [1, 159, 162, 163, 165, 166, 168, 169]):
			emit_signal("entered_value", int(keyboard_value))
	clear_label()

func _on_NoScoreButton_pressed() -> void:
	emit_signal("entered_value", 0)
