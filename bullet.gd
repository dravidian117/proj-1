extends Area2D

@export var speed := 600.0
var direction := Vector2.RIGHT

func _ready() -> void:
    add_to_group("bullets")
    monitoring = true
    monitorable = true
    collision_layer = 1
    collision_mask = 1
    $VisibleOnScreenNotifier2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
    body_entered.connect(_on_body_entered)
    area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
    position += direction * speed * delta

    for body in get_overlapping_bodies():
        if body.is_in_group("mobs"):
            body.queue_free()
            get_parent().add_score_for_kill()
            queue_free()
            return

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("mobs"):
        body.queue_free()
        get_parent().add_score_for_kill()
    queue_free()

func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("mobs"):
        area.queue_free()
        get_parent().add_score_for_kill()
    queue_free()
