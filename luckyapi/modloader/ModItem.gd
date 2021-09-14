extends "res://modloader/utils.gd"

var id: String
var mod_name: String
var value := 1
var values := []
var rarity := "common"
var groups := []
var texture: ImageTexture
var extra_textures := {}
var name: String
var description: String

var pick_symbols = []
var add_symbols = []
var add_coin = 0
var symbol_trigger = false


func init(modloader: Reference, params):
    self.modloader = modloader
    print("No initialization behavior for custom item defined in " + self.get_script().get_path())


func on_destroy():
    #pick_symbols:
        #push {"forced_rarity": ["rarity", "rarity", "rarity"]}
        #or push {"forced_group": "type"}
    #add_symbols:
        #push symbol type
    #add_coin
        #value to add to coins
    pass


func symbol_check(reels):
    #check reels.displayed_icons[x][y] to search symbol grid
        #reels.width
        #reels.height
    #use reels.make_clumps() to get totals of adjacent symbol types
        #reels.clumps:
            #clump.size()
    #return if conditions met
    return symbol_trigger


func update_value_text():
    pass


func add_conditional_effects():
    #Effects to add to effect queue
    pass