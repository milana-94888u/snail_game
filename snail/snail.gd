extends CharacterBody2D


signal grape_picked(grape: Grape)


const MAX_HEALTH := 3


@export var speed := 80
@export var health := 1


func go_right() -> void:
	$AnimatedSprite2D.play("right")
	velocity = Vector2.RIGHT * speed


func go_down() -> void:
	$AnimatedSprite2D.play("down")
	velocity = Vector2.DOWN * speed

func go_left() -> void:
	$AnimatedSprite2D.play("left")
	velocity = Vector2.LEFT * speed

func go_up() -> void:
	$AnimatedSprite2D.play("up")
	velocity = Vector2.UP * speed


func move() -> void:
	if not $AudioCrawl.playing:
		$AudioCrawl.play()
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		go_right()
		move()
	elif Input.is_action_pressed("ui_down"):
		go_down()
		move()
	elif Input.is_action_pressed("ui_left"):
		go_left()
		move()
	elif Input.is_action_pressed("ui_up"):
		go_up()
		move()
	else:
		if $AudioCrawl.playing:
			$AudioCrawl.stop()


func _on_snail_area_area_entered(area: Area2D) -> void:
	if area is HedgehogArea:
		if Globals.intro_finished:
			$AudioHedgehog.play()
			$AudioDie.play()
			health -= 1
			if health <= 0:
				get_tree().reload_current_scene()
			else:
				velocity *= - 100
				if $AnimatedSprite2D.animation == "right":
					$AnimatedSprite2D.play("left")
				elif $AnimatedSprite2D.animation == "down":
					$AnimatedSprite2D.play("up")
				elif $AnimatedSprite2D.animation == "left":
					$AnimatedSprite2D.play("right")
				elif $AnimatedSprite2D.animation == "up":
					$AnimatedSprite2D.play("down")
				move_and_slide()
			$Control/VBoxContainer/Health/ProgressBar.value = health
		else:
			get_tree().change_scene_to_file("res://cinematic/intro_cinematic.tscn")
	elif area is Grape:
		$AudioEat.play()
		$Control/VBoxContainer/Grapes/ProgressBar.value += 1
		grape_picked.emit(area)


func _on_house_area_entered(area: Area2D) -> void:
	if area == $SnailArea:
		get_tree().change_scene_to_file("res://cinematic/outro_cinematic.tscn")
