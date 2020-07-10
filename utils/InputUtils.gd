extends Reference
class_name InputUtils

static func isMovementInput(event: InputEvent) -> bool:
	return event.is_action("movement_backward") \
			|| event.is_action("movement_forward") \
			|| event.is_action("movement_left") \
			|| event.is_action("movement_right")


static func isMovingDiagonally(var _velocity: Vector3) -> bool:
	return abs(_velocity.z) > 0.01 && abs(_velocity.x) > 0.01
