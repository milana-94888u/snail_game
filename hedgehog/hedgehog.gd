extends CharacterBody2D


enum direction {LEFT, RIGHT}


@export var speed := 200
@export var current_direction := direction.RIGHT


func set_movement() -> void:
	$AnimatedSprite2D.play("run")
	if current_direction == direction.LEFT:
		$AnimatedSprite2D.flip_h = true
		velocity = Vector2.LEFT * speed
	else:
		$AnimatedSprite2D.flip_h = false
		velocity = Vector2.RIGHT * speed



func switch_direction() -> void:
	if current_direction == direction.LEFT:
		current_direction = direction.RIGHT
	else:
		current_direction = direction.LEFT
	set_movement()


func _ready() -> void:
	set_movement()


func _process(_delta: float) -> void:
	move_and_slide()
	if is_on_wall():
		switch_direction()
