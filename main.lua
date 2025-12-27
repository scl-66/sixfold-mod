-- joker spritesheet
SMODS.Atlas{
    key = 'sxfjokeratlas',
    path = 'SXFJokers.png',
    px = 71,
    py = 95
}

-- COMMON JOKERS
assert(SMODS.load_file("jokers/common/creased_joker.lua"))()
assert(SMODS.load_file("jokers/common/receipt.lua"))()

-- UNCOMMON JOKERS
assert(SMODS.load_file("jokers/uncommon/mirrored_joker.lua"))()
assert(SMODS.load_file("jokers/uncommon/water_balloon.lua"))()
assert(SMODS.load_file("jokers/uncommon/ransom_note.lua"))()