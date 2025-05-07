extends CharacterBody2D

const speed = 100
var current_dir = "none"
var enemy_attack_range = false
var attack_cooldown = true
@export var health = 100 :
	set(v):
		health = v
		if health <= 0:
			player_alive = false
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("Death")
			await $AnimatedSprite2D.animation_finished
			get_tree().quit()
			
@export var player_alive = true

var attack_ip = false

#playerstats

func _ready():
	$AnimatedSprite2D.play("Front_idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#ready function

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	if health <= 0:
		pass
	
	
func player_movement(delta):
	
	if not player_alive: return
	
	if Input.is_action_pressed("Player move right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("Player move left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("Player move down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("Player move up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

#player movement

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Side_walk_R")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Side_idle_R")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk_L")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Side_idle_L")
			
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("Front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("Back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Back_idle")

			
#player animations

func player():
	pass
	
func _on_hitbox_body_entered(body):
	if body.has_method("crab_enemy"):
		enemy_attack_range = true
		
func _on_hitbox_body_exited(body):
	if body.has_method("crab_enemy"):
		enemy_attack_range = false
		
func enemy_attack():
	if enemy_attack_range and attack_cooldown == true:
		if not player_alive: return
		health = health - 10
		attack_cooldown = false
		$attackCD.start()
		print(health)


func _on_attack_cd_timeout():
	attack_cooldown = true
	
	
func attack():
	var dir = current_dir

	
