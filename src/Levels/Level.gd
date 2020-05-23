extends Node2D

export var id = 0
var total_coins = 0

func _ready():
	total_coins = get_tree().get_nodes_in_group("Coins").size();

func save_level_data():
	var file = File.new()
	if not file.file_exists("user://level %s.save" % id):
		save()
	file.open("user://level %s.save" % id, File.READ)
	var old = int(file.get_line())
	file.close()
	if old < $Player.coins:
		save()

func save():
	var file = File.new()
	file.open("user://level %s.save" % id, File.WRITE)
	file.store_line(str($Player.coins))
	file.store_line(str($Player.coins == total_coins))
	file.close()
