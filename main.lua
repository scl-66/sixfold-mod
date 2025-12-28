-- joker spritesheet
SMODS.Atlas{
    key = 'sxfjokeratlas',
    path = 'SXFJokers.png',
    px = 71,
    py = 95
}

assert(SMODS.load_file("jokers/common_jokers.lua"))()
assert(SMODS.load_file("jokers/uncommon_jokers.lua"))()
assert(SMODS.load_file("jokers/rare_jokers.lua"))()