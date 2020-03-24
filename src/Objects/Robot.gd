extends Node2D

export(Array, NodePath) var slots;

func _ready() -> void:
	Game.robot = self
	set_process_input(true)


func attach(object, slot) -> bool:
	if object and slot.get_child_count() < 2:
		object.get_parent().remove_child(object)
		slot.add_child(object)
		object.position = Vector2.ZERO
		return true
	return false

func getSlots() -> Array:
	var list_of_slots = []
	for slot in slots:
		var dict_of_slots = {"position": Vector2.ZERO, "slot": null}
		dict_of_slots["position"] = get_node(slot).position
		dict_of_slots["slot"] = get_node(slot)
		list_of_slots.append(dict_of_slots)
	return list_of_slots
