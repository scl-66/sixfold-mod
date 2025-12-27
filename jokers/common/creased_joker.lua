SMODS.Joker{
    key = "creased_joker",
    atlas = "sxfjokeratlas",
    pos = { x = 0, y = 0},
    rarity = 1,
    blueprint_compat = true, 
    loc_txt = {
            name = "Creased Joker",
            text = {
                "Played cards with", 
                "ranks {C:attention}2-8{} give {C:chips}+#1#{} Chips",
                "Played cards with ranks",
                "{C:attention}9-A{} give {C:mult}+#2#{} Mult"
            }
        },
    config = {
            extra = {
                chips = 15,
                mult = 3,
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips, -- replace #1# in the description with this value
                card.ability.extra.mult, -- replace #2# in the description with this value
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 0 and context.other_card:get_id()<= 8 then -- cards 2-8
                return {
                        chips = card.ability.extra.chips,
                }
            end
            if context.other_card:get_id() >= 9 and context.other_card:get_id()<= 14 then -- cards 9-A
                return {
                        mult = card.ability.extra.mult,
                }
            end
        end 
    end,
}