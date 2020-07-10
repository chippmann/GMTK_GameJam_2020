extends State3D
class_name MoveState


func physicsProcess(delta: float) -> void:
	var parentState := _getTypedParentState()
	if !parentState.hasMovementInput():
		_getStatemachine().transitionTo(_getStatemachine().idleState)
		return
	
	parentState._inputVelocity.z = (Input.get_action_strength("movement_forward") - Input.get_action_strength("movement_backward")) * parentState.movementSpeed * parentState._movementMultiplicator
	parentState._inputVelocity.x = (Input.get_action_strength("movement_left") - Input.get_action_strength("movement_right")) * parentState.movementSpeed * parentState._movementMultiplicator
	
	if InputUtils.isMovingDiagonally(parentState._velocity):
		parentState._inputVelocity.z /= sqrt(PI)
		parentState._inputVelocity.x /= sqrt(PI)
	parentState.physicsProcess(delta)


func _getTypedParentState() -> MovementState:
	return _parentState as MovementState


func _getStatemachine() -> PlayerStateMachine:
	return _stateMachine as PlayerStateMachine
