
extends TextureFrame

var global

var time
var enemy_spawn
var max_enemy_num = 8
var enemy_num = 0

func _ready():
	time = 0.0
	enemy_spawn = 2.0
	global = get_node("/root/global")
	set_process(true)
	set_process_input(true)

func _process(delta):
	time += delta
	if time > enemy_spawn and enemy_num < max_enemy_num:
		enemy_spawn = time + 3.0
		var scene = preload("res://tank-a.scn")
		var enemy = scene.instance()
		var path = PathFollow2D.new()
		path.set_loop(false)
		get_node("/root/Level-1/WavePath-1").add_child(path)
		path.add_child(enemy)
		enemy_num += 1
	get_node("CashLabel").set_text(str("Cash: ", global.cash))
	get_node("HealthLabel").set_text(str("Health: ", global.health))
		
	if global.health <= 0:
		print("You loose!")

func _input(event):
	if event.type == InputEvent.KEY:
		if Input.is_action_pressed("pause_game"):
			get_tree().set_pause(true)
			get_node("PausePopupPanel").show()
			return
		if Input.is_action_pressed("quit_game"):
			get_tree().quit()
			return

func add_tower(pos, id):
	print("Add tower: x=", pos.x, " y=", pos.y)
	var scene = preload("res://tower-a.scn")
	var tower = scene.instance()
	tower.set_name("Tower-" + id)
	tower.set_pos(pos)
	add_child(tower)

func _on_resume_button_pressed():
	get_node("PausePopupPanel").hide()
	get_tree().set_pause(false)
	
