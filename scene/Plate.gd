extends Spatial
class_name Plate

signal steppedOn



func _on_Area_body_entered(body: Node) -> void:
	if visible && body.is_in_group("player"):
		GameManager.rhythmicScore += 10
		emit_signal("steppedOn", self)
