extends Control

@onready var actual_item1: Label = $ItemsforSale/VBoxContainer/Item1/ActualItem
@onready var price1: Label = $ItemsforSale/VBoxContainer/Item1/Price
@onready var qnty_num1: Label = $ItemsforSale/VBoxContainer/Item1/QntyNum

@onready var actual_item2: Label = $ItemsforSale/VBoxContainer/Item2/ActualItem
@onready var price2: Label = $ItemsforSale/VBoxContainer/Item2/Price
@onready var qnty_num2: Label = $ItemsforSale/VBoxContainer/Item2/QntyNum

@onready var actual_item3: Label = $ItemsforSale/VBoxContainer/Item3/ActualItem
@onready var price3: Label = $ItemsforSale/VBoxContainer/Item3/Price
@onready var qnty_num3: Label = $ItemsforSale/VBoxContainer/Item3/QntyNum

@onready var actual_item4: Label = $ItemsforSale/VBoxContainer/Item4/ActualItem
@onready var price4: Label = $ItemsforSale/VBoxContainer/Item4/Price
@onready var qnty_num4: Label = $ItemsforSale/VBoxContainer/Item4/QntyNum

@onready var actual_item5: Label = $ItemsforSale/VBoxContainer/Item5/ActualItem
@onready var price5: Label = $ItemsforSale/VBoxContainer/Item5/Price
@onready var quantity5: Label = $ItemsforSale/VBoxContainer/Item5/Quantity

@onready var actual_item6: Label = $ItemsforSale/VBoxContainer/Item6/ActualItem
@onready var price6: Label = $ItemsforSale/VBoxContainer/Item6/Price
@onready var qnty_num6: Label = $ItemsforSale/VBoxContainer/Item6/QntyNum

@onready var actual_item7: Label = $ItemsforSale/VBoxContainer/Item7/ActualItem
@onready var price7: Label = $ItemsforSale/VBoxContainer/Item7/Price
@onready var qnty_num7: Label = $ItemsforSale/VBoxContainer/Item7/QntyNum

var save_dir : String = "res://"
var save_file_name : String = "skipper.json"
var character := {}

var items_for_sale := []

var test : = {"name" : "Basic Rock", "cost" : 5.00}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data(save_dir+save_file_name) # Replace with function body.
	setup_shop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_data(path: String):
	if FileAccess.file_exists(path):
		#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, "secKey")
		var file = FileAccess.open(path, FileAccess.READ)
		if file == null:
			print(FileAccess.get_open_error())
			return
		var content = file.get_as_text()
		file.close()
		var data = JSON.parse_string(content)
		if data == null:
			printerr("cannot parse %s as json")
			return
		else:
			character = data
			print(str(character))
	else:
		printerr("Cannot Open File")
		#get_tree().change_scene_to_file("res://char_creation.tscn")

func setup_shop() -> void:
	items_for_sale = [{"name" : "Basic Rock", "cost" : 5.00},
					{"name" : "Dumb Rock", "cost" : 0.50},
					{"name" : "Pet Rock", "cost" : 50.00},
					{"name" : "Candy Rock", "cost" : 3.00},
					{"name" : "Toy Rock", "cost" : 15.00},
					{"name" : "Shiny Rock", "cost" : 80.00},
					{"name" : "The Rock", "cost" : 12.00},
					{"name" : "Hamburger Bun", "cost" : 8.99},
					{"name" : "Silly Rock", "cost" : 10.00},
					{"name" : "Expensive Rock", "cost" : 999.99}]
	items_for_sale.shuffle()
	while items_for_sale.size() > 7:
		items_for_sale.pop_back()
	print(str(items_for_sale))
	
	actual_item1.text = items_for_sale[0]["name"]
	price1.text = str(items_for_sale[0]["cost"])
	qnty_num1.text = str(5)

	actual_item2.text = items_for_sale[1]["name"]
	price2.text = str(items_for_sale[1]["cost"])
	qnty_num2.text = str(5)

	actual_item3.text = items_for_sale[2]["name"]
	price3.text = str(items_for_sale[2]["cost"])
	qnty_num3.text = str(5)

	actual_item4.text = items_for_sale[3]["name"]
	price4.text = str(items_for_sale[3]["cost"])
	qnty_num4.text = str(5)

	actual_item5.text = items_for_sale[4]["name"]
	price5.text = str(items_for_sale[4]["cost"])
	quantity5.text = str(5)

	actual_item6.text = items_for_sale[5]["name"]
	price6.text = str(items_for_sale[5]["cost"])
	qnty_num6.text = str(5)

	actual_item7.text = items_for_sale[6]["name"]
	price7.text = str(items_for_sale[6]["cost"])
	qnty_num7.text = str(5)
	
