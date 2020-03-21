extends Node2D

var slots: Array = []

func _ready() -> void:
	Game.hand = self


func attach(object) -> bool:
	if object and len(slots) < Status.handLimit:
		object.get_parent().remove_child(object)
		add_child(object)
		slots.append(object)
		object.position = Vector2(Status.card_size.x * slots.find(object), 0)
		return true
	return false
