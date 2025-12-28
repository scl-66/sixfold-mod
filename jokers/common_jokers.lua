-- #region CREASED JOKER
SMODS.Joker{
    key = "creased_joker",
    atlas = "sxfjokeratlas",
    pos = { x = 0, y = 0},
    rarity = 1,
    cost = 5,
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
-- #endregion

-- #region RECEIPT
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
        local _played_cards = {}
        local is_dupe = nil

        if context.before and (#context.full_hand >= 5) then
            --create table of played card ranks for this hand
            for i = 1, #context.full_hand do
                _played_cards[i] = context.full_hand[i].base.value
            end

            -- check for dupe ranks
            for i = 1, #_played_cards do
                for j = i + 1, #_played_cards do
                    if _played_cards[i] == _played_cards[j] then
                        is_dupe = true
                        break
                    end
                end
            end

            -- no dupe ranks were detected, grant money
            if is_dupe == nil then
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
    end
}
-- #endregion