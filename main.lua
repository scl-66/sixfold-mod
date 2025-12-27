-- joker spritesheet
SMODS.Atlas{
    key = 'sxfjokeratlas',
    path = 'SXFJokers.png',
    px = 71,
    py = 95
}

assert(SMODS.load_file("jokers/common/creased_joker.lua"))()
assert(SMODS.load_file("jokers/uncommon/mirrored_joker.lua"))()