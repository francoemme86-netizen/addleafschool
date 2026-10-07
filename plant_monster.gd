extends CharacterBody3D

@export var max_health: int = 100
var current_health: int

func _ready() -> void:
	current_health = max_health
	print("PlantMonster spawnato con ", current_health, " HP nell'ufficio del preside.")

# Funzione per subire danno (chiamata quando il giocatore spara o attacca)
func take_damage(amount: int) -> void:
	current_health -= amount
	print("PlantMonster ha subito ", amount, " danni! Salute residua: ", current_health)
	
	if current_health <= 0:
		die()

# Gestione della morte dell'Uomo-Pianta
func die() -> void:
	print("PlantMonster è stato sconfitto!")
	
	# Notifica il GameManager per bruciare le piante sulla botola
	var game_manager = get_node_or_null("/root/LeafmoreAcademy/GameManager")
	if game_manager != null:
		game_manager.defeat_plant_monster()
	else:
		print("GameManager non trovato!")
	
	queue_free()
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"): # Tasto Spazio / Invio
		take_damage(50) # Subisce 50 danni a pressione
