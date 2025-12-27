SMODS.Joker{
    key = "ransom_note",
    atlas = "sxfjokeratlas",
    pos = { x = 4, y = 0},
    rarity = 3,
    cost = 7,
    blueprint_compat = true, 
    loc_txt = {
            name = "Ransom Note",
            text = {
                "{C:attention}Swaps{} base Mult and Chip",
                "value of poker hand {C:attention}before{}",
                "any other effects"
            }
        },
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                swap = true,
                message = "Swap!",
                colour = G.C.RARITY.Legendary
            }
        end
    end
}