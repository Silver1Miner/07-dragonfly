extends VBoxContainer

signal offer_refused()
signal offer_made(value)
var current_value = 0
var base_value = 1000
var percent = 0

onready var hundredthousand = $Dial/HundredThousand
onready var tenthousand = $Dial/TenThousand
onready var thousand = $Dial/Thousand
onready var hundred = $Dial/Hundred
onready var ten = $Dial/Ten
onready var ones = $Dial/One

func _ready() -> void:
	for node in $Dial.get_children():
		if node.connect("value_changed", self, "_on_value_changed") != OK:
			push_error("dial connect fail")

func _on_value_changed(_value) -> void:
	calculate_dial_value()
	percent = current_value / base_value * 100
	$Percentage.text = str(round(percent)) + "% of Wholesale Price"

func set_dial_value(value) -> void:
	var padded = "%0*d" % [6, value]
	hundredthousand.value = float(padded[0])
	tenthousand.value = float(padded[1])
	thousand.value = float(padded[2])
	hundred.value = float(padded[3])
	ten.value = float(padded[4])
	ones.value = float(padded[5])

func calculate_dial_value() -> void:
	current_value = 0
	current_value += float(ones.value)
	current_value += float(ten.value) * 10
	current_value += float(hundred.value) * 100
	current_value += float(thousand.value) * 1000
	current_value += float(tenthousand.value) * 10000
	current_value += float(hundredthousand.value) * 100000

func _on_Decline_pressed() -> void:
	emit_signal("offer_refused")

func _on_Offer_pressed() -> void:
	calculate_dial_value()
	emit_signal("offer_made", current_value)
