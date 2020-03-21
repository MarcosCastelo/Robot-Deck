extends Node2D

var card_list: Array = [];

func _ready() -> void:
	for card_h in range(Status.table_h):
		for card_w in range(Status.table_w):
			var card = Resources.card.instance()
			$CardsPosition.add_child(card)
			card.position = Vector2(card_w * (Status.card_size.x + 10), card_h * (Status.card_size.y + 10))



