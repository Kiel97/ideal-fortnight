extends PanelContainer

signal darts_to_checkout(darts)

func _on_NoScoreButton_pressed() -> void:
	emit_signal("darts_to_checkout", 0)

func _on_OneDartButton_pressed() -> void:
	emit_signal("darts_to_checkout", 1)

func _on_TwoDartsButton_pressed() -> void:
	emit_signal("darts_to_checkout", 2)

func _on_ThreeDartsButton_pressed() -> void:
	emit_signal("darts_to_checkout", 3)