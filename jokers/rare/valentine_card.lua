SMODS.Joker{
    key = "valentine_card",
    atlas = "sxfjokeratlas",
    pos = { x = 5, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = true, 
    loc_txt = {
            name = "Valentine Card",
            text = {
                "If {C:attention}first hand{} of round is a",
                "single {C:heart}Heart{} card,",
                "destroy it and add",
                "{C:mult}+#1#{} Mult to this Joker",
                "{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
            }
        },
    config = {
            extra = {
                mult_gain = 8,
                mult = 0,
                suit = "Hearts",
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain, -- replace #1# in the description with this value
                card.ability.extra.mult, -- replace #2# in the description with this value
                localize(card.ability.extra.suit, "suits_singular")
            }
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.before then
            if not context.blueprint and #context.full_hand == 1 
            and context.full_hand[1]:is_suit(card.ability.extra.suit) 
            and G.GAME.current_round.hands_played == 0 then
                -- destroy card, upgrade joker mult
                SMODS.destroy_cards(context.full_hand[1])
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain

                -- upgrade message
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}