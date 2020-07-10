extends Node2D
class_name State2D
"""
State interface to use in Hierarchical and Finite State Machines.
The lowest leaf tries to handle callbacks, and if it can't, it delegates the work to its parent.
It's up to the user to call the parent state's functions, e.g. `_parent.physics_process(delta)`
Use State as a child of a FiniteStateMachine node or other States in case of a Hierarchical State Machine.
Developed using following descriptions and guidelines: https://gameprogrammingpatterns.com/state.html
"""

onready var _stateMachine = _assignStateMachine(self) #not typed so states can override get_statemachine to get the correctly typed statemachine
onready var _parentState: State2D = _getParentState()


func _ready() -> void:
	if Engine.is_editor_hint(): return
	yield(owner, "ready")


"""
virtual method to be overriden by inheritant class
called when the state gets active
use this to initialize state specific values and trigger start functions
"""
func enter(_message: Dictionary = {}) -> void:
	pass


"""
virtual method to be overriden by inheritant class
a state can handle user input inside this function
"""
func unhandledInput(_event: InputEvent) -> void:
	pass


"""
virtual method to be overriden by inheritant class
a custom process function which gets called when the state machine's _process gets called
it deferres the call to the current active state (or multiple state in case of Hierarchical State Machine)
we dont want to use the engines _process because we want the state machine to handle which states process gets called
"""
func process(_delta: float) -> void:
	pass


"""
virtual method to be overriden by inheritant class
a custom physics function which gets called when the state machine's _physics_process gets called
it deferres the call to the current active state (or multiple state in case of Hierarchical State Machine)
we dont want to use the engines _physics_process because we want the state machine to handle which states physics_process gets called
"""
func physicsProcess(_delta: float) -> void:
	pass


"""
virtual method to be overriden by inheritant class
called when the state is not active anymore
use this to cleanup state specific values and trigger end functions
"""
func exit() -> void:
	pass



"""
Gets the state machine
If parent is a state machine return it
otherwise get the state machine from the parent and maybe its parent until we have a state machine (ex. Hierarchical State Machine)
"""
func _assignStateMachine(node: Node) -> StateMachine2D:
	if node && !node.is_in_group(StateMachine2D.statemachineGroupName):
		return _assignStateMachine(node.get_parent())
	
	return node as StateMachine2D


func _getParentState(): #returns State? | because of bad typing support in gdscript no return type is defined...
	var stateClass := load("res://addons/utils/statemachine/State2D.gd")
	var script = (get_parent().get_script() as Script).get_base_script()
	if (get_parent().get_script() as Script).get_base_script() == stateClass:
		return get_parent()
	
	return null
