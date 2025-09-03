extends CharacterBody2D

var speed = 250.0
var jump_speed = -450.0
var can_jump = true

# This variable will store the player's air/ground state from the previous frame.
var was_in_air = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func jump():
	velocity.y = jump_speed
	can_jump = false

func _on_coyote_timer_timeout():
	# This function is called when the coyote timer runs out, disabling the jump.
	can_jump = false

func _physics_process(delta):
	# Apply gravity only when the player is in the air.
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- Horizontal Movement ---
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false

	if is_on_floor():
		can_jump = true
		$CoyoteTimer.stop()
	elif can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()

	# Handle the jump input.
	if Input.is_action_just_pressed("jump") and can_jump:
		Audio.play("res://sounds/hero_jump.wav")
		jump()


	move_and_slide()

	if is_on_floor():
		if abs(velocity.x) > 10:
			$AnimatedSprite2D.play("walking")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("jumping")
