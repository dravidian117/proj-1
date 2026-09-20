extends Node

@export var mob_scene: PackedScene
var score = 0

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	for child in get_children():
		if child.is_in_group("mobs"):
			child.queue_free()
	for bullet in get_tree().get_nodes_in_group("bullets"):
		bullet.queue_free()
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()

func _ready() -> void:
	if mob_scene == null:
		mob_scene = load("res://Mob.tscn")

	$Player.hit.connect(game_over)
	$HUD.start_game.connect(new_game)
	$MobTimer.timeout.connect(_on_mob_timer_timeout)
	$ScoreTimer.timeout.connect(_on_score_timer_timeout)
	$StartTimer.timeout.connect(_on_start_timer_timeout)

	$HUD.update_score(score)
	$HUD.show_message("Dodge the Creeps!")

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	if mob_scene == null:
		return

	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	mob.rotation = direction + randf_range(-PI / 4, PI / 4)

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(mob.rotation)
	mob.add_to_group("mobs")
	add_child(mob)

func add_score_for_kill() -> void:
	score += 1
	$HUD.update_score(score)
