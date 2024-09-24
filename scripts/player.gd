extends KinematicBody2D

const GRAVITY := 10
var jump_force := 400
var velocity := Vector2.ZERO
var speed := 100

onready var anim:= $anim as AnimatedSprite
onready var screen_size = get_viewport_rect().size
	
func move(delta):
	
		# Проверка нажатия клавиш влево и вправо
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction = -1  # Движение влево
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1  # Движение вправо

	# Если нажата клавиша, двигаем персонажа
	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction * speed, 0.5)
		anim.scale.x = -input_direction  # Поворачиваем анимацию в сторону движения
	else:
		velocity.x = lerp(velocity.x, 0, 0.5)  # Плавная остановка
	
	
	velocity.y += GRAVITY 
	
	var collison = move_and_collide(velocity*delta)
	
	if velocity.y >0:
		anim.play("fall")
	else:
		anim.play("idle")
		
	if collison:
		velocity.y = -jump_force * collison.collider.jump_force
		if collison.collider.has_method("response"):
			collison.collider.response()
		
func _physics_process(delta: float) -> void:
	move(delta)	
	position.x = wrapf(position.x, 0, screen_size.x)

func die():
	#get_tree().reload_current_scene()
	velocity = Vector2.ZERO
	set_collision_mask_bit(1,false)
