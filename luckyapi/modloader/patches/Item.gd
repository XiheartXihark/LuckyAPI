extends "res://Item_Item.gd"

onready var modloader: Reference = get_tree().modloader

var mod_items = modloader.mod_items
var mod_item = null
var persistent_data := {}
var non_persistent_data := {}
var value_text
var multiplier_text
var bonus_text
var displayed_text_value
var displayed_multiplier_value
var displayed_bonus_value


func _ready():
	._ready()
	update_mod_item(self.type)

func update():
	.update()

func update_mod_item(new_type: String):
	if mod_items.has(type):
		mod_item = mod_items[type]
	else:
		mod_item = null


func destroy():
	if mod_item:
		var pos = get_parent().item_types.find(type)
		var popup = $"/root/Main/Pop-up Sprite/Pop-up"
		var coin_sum = $"/root/Main/Sums/Coin Sum"
		if mod_item.on_destroy:
			mod_item.on_destroy()
			if mod_item.pick_symbols.size():
				for i in mod_item.pick_symbols:
					popup.add_event("add_tile", mod_item.pick_symbols[i])
			if mod_item.add_symbols.size():
				for j in mod_item.add_symbols:
					reels.add_tile(mod_item.add_symbols[j])
			if mod_item.add_coin > 0:
				coin_sum.add_value(mod_item.add_coin)
				coin_sum.adding = true
	.destroy()


func symbol_check():
	if mod_item and mod_item.symbol_check and not disabled:
		symbol_trigger = mod_item.symbol_check(reels)
		for effect in erased_effects:
			for comp in effect.comparisons:
				if comp.a == "symbol_trigger":
					erased_effects.erase(effect)
		add_conditional_effects()
	else:
		.symbol_check()


func add_effect(effect):
    if effect.effect_dictionary != null:
        .add_effect(effect.effect_dictionary)
    else:
        .add_effect(effect)


func add_effect_for_symbol(symbol, effect):
	.add_effect_to_symbol(symbol.grid_position.y, symbol.grid_position.x, effect)

func update_value_text():
    self.value_text = null
    self.multiplier_text = null
    self.bonus_text = null
    .update_value_text()
    
    if mod_item and mod_item.has_method("update_value_text"):
        _update_value_text_inner(mod_item)
    #var patches = modloader.symbol_patches[self.type]
    #if patches:
    #    for patch in patches:
    #        if patch.has_method("update_value_text"):
    #            _update_value_text_inner(patch)

func _update_value_text_inner(item):
    item.update_value_text(self, self.values)
    if self.value_text != null and not destroyed:
        get_child(1).raw_string = self.value_text_color + str(self.value_text) + "<end>"
        get_child(1).force_update = true
        displayed_text_value = str(self.value_text)
    if self.multiplier_text != null and not destroyed:
        get_child(2).raw_string = self.multiplier_text_color + "x" + str(self.multiplier_text) + "<end>"
        get_child(2).force_update = true
        displayed_multiplier_value = str(self.multiplier_text)
    if self.bonus_text != null and not destroyed:
        get_child(3).raw_string = self.bonus_text_color + "+" + str(self.bonus_text) + "<end>"
        get_child(3).force_update = true
        displayed_bonus_value = str(self.bonus_text)

func add_conditional_effects():
	if mod_item:
		var rarities = $"/root/Main/Pop-up Sprite/Pop-up".rarity_bonuses["symbols"]
		mod_item.add_conditional_effects(self, rarities)
	else:
		.add_conditional_effects()