SMODS.Joker{
    key = "water_balloon",
    atlas = "sxfjokeratlas",
    pos = { x = 2, y = 0},
    rarity = 2,
    cost = 7,
    blueprint_compat = false, 
    loc_txt = {
            name = "Water Balloon",
            text = {
                "Earn {C:money}$#1#{} at end of round.",
                "If {C:attention}single hand{} scores higher",
                "than Blind requirement,", 
                "increase payout by {C:money}$#2#{}"
            }
        },
    config = {
            extra = {
                dollars = 1,
                increase = 1,
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars, -- replace #1# in the description with this value
                card.ability.extra.increase, -- replace #2# in the description with this value
            }
        }
    end,
    calculate = function (self, card, context)
        if SMODS.last_hand_oneshot and context.final_scoring_step and context.main_eval then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.increase
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
}