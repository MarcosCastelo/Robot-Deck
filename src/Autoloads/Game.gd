extends Node

onready var hand: Node2D
onready var robot: Node2D
	
func attach_on_hand(object) -> bool:
	if hand:
		if object.attachedParent:
			object.attachedParent.remove_child(object)
		object.attachedParent = hand
		return hand.attach(object)
	return false


func attach_on_robot(object, slot) -> bool:
	if robot:
		if object.attachedParent:
			object.attachedParent.remove_child(object)
		object.attachedParent = robot
		return robot.attach(object, slot)
	return false
