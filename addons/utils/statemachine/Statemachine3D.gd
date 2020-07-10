tool
extends Node2D
class_name StateMachine3D
"""
Generic Finite State Machine. Initializes states and delegates engine callbacks
(_physics_process, _unhandled_input) to the active state.
Developed using following descriptions and guidelines: https://gameprogrammingpatterns.com/state.html
"""

const statemachineGroupName: String = "stateMachine"

export var initialStateNodePath: NodePath
onready var _initialState = get_node(initialStateNodePath)

onready var currentState = _initialState


func _init() -> void:
	add_to_group(statemachineGroupName)


func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	yield(get_owner(), "ready")
	currentState.enter()


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	if get_tree().network_peer && !is_network_master():
		return
	
	currentState.unhandledInput(event)


func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	currentState.process(delta)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	currentState.physicsProcess(delta)


puppet func transitionTo(targetStatePath: NodePath, message: Dictionary = {}):
	if !has_node(targetStatePath):
		Logger.error("This state machine has no state with path: %s" % targetStatePath)
		return
	
	if get_tree().network_peer && is_network_master():
		rpc("transition_to", targetStatePath, message)
	
	var targetState = get_node(targetStatePath)
	currentState.exit()
	currentState = targetState
	targetState.enter(message)



func _get_configuration_warning() -> String:
	var properties: Array = get_property_list()
	for property in properties:
		if property.type == TYPE_NODE_PATH && !property.name.begins_with("_"):
			if !get(property.name) || get_node(get(property.name)) == null:
				return """\"%s\" has no node assigned!
				Please add one through the editor.
				""" % property.name
	
	return _check_if_children_configured(self)


func _check_if_children_configured(nodeToCheck: Node) -> String:
	for child in nodeToCheck.get_children():
		var message: String = _check_if_children_configured(child)
		if !message.empty():
			return message
	
	for property in get_property_list():
		if property.type == TYPE_NODE_PATH && !property.name.begins_with("_") && !property.name.begins_with("initialStateNodePath"):
			var nodePath: NodePath = get(property.name)
			if get_path_to(nodeToCheck) == nodePath:
				return ""
	
	if nodeToCheck == self || !nodeToCheck is State2D:
		return ""
	
	return """Child State %s is not configured!
	You don't want to hardcode statePaths!
	Add them to the state machine and reference them in the individual transitions.
	""" % nodeToCheck.name
