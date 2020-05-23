extends Control

export (PackedScene) var connector

func _ready():
	var children = $ScrollContainer/CenterContainer/HBoxContainer.get_children()
	for i in range(len(children)-1):
		var line = connector.instance()
		add_child(line)
		var offset = Vector2(children[i].rect_size.x/2, children[i].rect_size.y/2)
		line.create(children[i].rect_global_position + offset, children[i+1].rect_global_position + offset)
