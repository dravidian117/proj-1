extends Area2D

var speed := 600.0
var direction := Vector2.RIGHT

func _ready() -> void:
    $VisibleOnScreenNotifier2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
    body_entered.connect(_on_body_entered)
    area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
    position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("mobs"):
        body.queue_free()
    queue_free()

func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("mobs"):
        area.queue_free()
    queue_free()
