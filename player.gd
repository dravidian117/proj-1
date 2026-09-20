extends Area2D

signal hit

@export var speed = 400
@export var bullet_scene: PackedScene
@export var fire_cooldown := 0.25

var screen_size
var shoot_timer := 0.0
var facing := Vector2.RIGHT

func _ready() -> void:
	screen_size = get_viewport_rect().size
	if bullet_scene == null:
		bullet_scene = preload("res://bullet.tscn")
	hide()

func _process(delta: float) -> void:
	if not visible:
		return

	shoot_timer = max(0.0, shoot_timer - delta)

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		facing = velocity
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.flip_v = velocity.y > 0

	if Input.is_action_just_pressed("shoot") and shoot_timer <= 0.0:
		shoot()

func shoot() -> void:
	if bullet_scene == null:
		bullet_scene = preload("res://bullet.tscn")
	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position + facing.normalized() * 20.0
	bullet.direction = facing.normalized()
	if bullet.direction.length() == 0:
		bullet.direction = Vector2.RIGHT
	shoot_timer = fire_cooldown

func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
