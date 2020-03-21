extends Node

onready var hand: Node2D
	
func attach_on_hand(object) -> bool:
	if hand:
		return hand.attach(object)
	return false
