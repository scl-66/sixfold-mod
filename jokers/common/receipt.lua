SMODS.Joker{
    key = "receipt",
    atlas = "sxfjokeratlas",
    pos = { x = 3, y = 0},
    rarity = 1,
    cost = 4,
    blueprint_compat = true, 
    loc_txt = {
            name = "Receipt",
            text = {
                "Earn {C:money}$#1#{} if played hand",
                "contains {C:attention}5{} cards with",
                "different {C:attention}ranks{},"
            }
        },
    config = {
            extra = {
                dollars = 2,
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars, -- replace #1# in the description with this value
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and (#context.full_hand >= 5) and (context.scoring_name == "High Card") then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, this goes after the dollar modification
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}