extends Node

# Variabili di stato per tracciare i progressi nel livello
var has_pistol: bool = false
var plant_monster_defeated: bool = false

func _ready() -> void:
	print("GameManager inizializzato correttamente.")

# Chiamato dall'InteractionArea della botola (basement_door.gd)
func try_open_basement_door() -> void:
	if plant_monster_defeated:
		print("La botola si apre! Puoi scendere nei sotterranei della Leafmore Academy.")
		# Qui potremo caricare la scena dei sotterranei o gestire la transizione
	else:
		print("La porta è completamente bloccata da piante mutanti!")

# Chiamato quando il giocatore raccoglie l'arma dall'armadietto
func collect_pistol() -> void:
	has_pistol = true
	print("Hai raccolto la pistola! Ora puoi combattere l'Uomo-Pianta.")

# Chiamato quando l'Uomo-Pianta viene eliminato
func defeat_plant_monster() -> void:
	plant_monster_defeated = true
	print("L'Uomo-Pianta è stato sconfitto! Il faro si accende e brucia la massa mutante.")
	
	# Cerca il nodo MonsterPlants nell'Atrio e lo rimuove dalla scena
	var monster_plants = get_node_or_null("/root/LeafmoreAcademy/MonsterPlants")
	if monster_plants != null:
		monster_plants.queue_free()
		print("Le piante mostruose sulla botola sono state distrutte!")
	else:
		print("Attenzione: Nodo MonsterPlants non trovato nella scena.")
