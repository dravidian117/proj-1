extends CanvasLayer

signal start_game

@onready var score_label: Label = $ScoreLabel
@onready var message: Label = $Message
@onready var start_button: Button = $StartButton
@onready var message_timer: Timer = $MessageTimer

func _ready() -> void:
    message.text = "Dodge the Creeps!"
    message.show()
    start_button.show()
    update_score(0)

func show_message(text: String) -> void:
    message.text = text
    message.show()
    message_timer.start()

func show_game_over() -> void:
    show_message("Game Over")
    await message_timer.timeout
    show_message("Dodge the Creeps!")
    start_button.show()

func update_score(score: int) -> void:
    score_label.text = str(score)

func _on_message_timer_timeout() -> void:
    message.hide()

func _on_start_button_pressed() -> void:
    start_button.hide()
    start_game.emit()
