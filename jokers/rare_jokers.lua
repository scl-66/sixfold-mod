-- #region WATER BALLOON
SMODS.Joker{
    key = "water_balloon",
    atlas = "sxfjokeratlas",
    pos = { x = 2, y = 0},
    rarity = 3,
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
-- #endregion

-- #region RANSOM NOTE
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
-- #endregion

-- #region VALENTINE CARD
SMODS.Joker{
    key = "valentine_card",
    atlas = "sxfjokeratlas",
    pos = { x = 5, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = false, 
    loc_txt = {
            name = "Valentine Card",
            text = {
                "If {C:attention}first hand{} of round is a",
                "single {C:hearts}Heart{} card,",
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
-- #endregion

-- #region THANKFUL LEAF (NEEDS SPRITE)
SMODS.Joker{
    key = "thankful_leaf",
    atlas = "sxfjokeratlas",
    pos = { x = 7, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = false, 
    loc_txt = {
            name = "Thankful Leaf",
            text = {
                "If {C:attention}first hand{} of round is a",
                "single {C:spades}spade{} card,",
                "destroy it and add",
                "{C:chips}+#1#{} Chips to this Joker",
                "{C:inactive}Currently{} {C:chips}+#2#{} {C:inactive}Chips{}"
            }
        },
    config = {
            extra = {
                chip_gain = 50,
                chips = 0,
                suit = "Spades",
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_gain, -- replace #1# in the description with this value
                card.ability.extra.chips, -- replace #2# in the description with this value
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
                -- destroy card, upgrade joker chips
                SMODS.destroy_cards(context.full_hand[1])
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain

                -- upgrade message
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
-- #endregion

-- #region RADIANT FIREWORK (NEEDS SPRITE)
SMODS.Joker{
    key = "radiant_firework",
    atlas = "sxfjokeratlas",
    pos = { x = 7, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = false, 
    loc_txt = {
            name = "Radiant Firework",
            text = {
                "If {C:attention}first hand{} of round is a",
                "single {C:diamonds}Diamond{} card,",
                "destroy it and add",
                "{X:mult,C:white}X#1#{} Mult to this Joker",
                "{C:inactive}Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult{}"
            }
        },
    config = {
            extra = {
                xmult_gain = 0.25,
                xmult = 1,
                suit = "Diamonds",
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain, -- replace #1# in the description with this value
                card.ability.extra.xmult, -- replace #2# in the description with this value
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
                -- destroy card, upgrade joker xmult
                SMODS.destroy_cards(context.full_hand[1])
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain

                -- upgrade message
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
-- #endregion

-- #region FORTUNATE CLOVER (NEEDS SPRITE)
SMODS.Joker{
    key = "fortunate_clover",
    atlas = "sxfjokeratlas",
    pos = { x = 7, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = false, 
    loc_txt = {
            name = "Fortunate Clover",
            text = {
                "If {C:attention}first hand{} of round is a",
                "single {C:clubs}Club{} card,",
                "destroy it and add",
                "{C:money}$#1#{} to this Joker's sell value",
            }
        },
    config = {
            extra = {
                price = 6,
                suit = "Diamonds",
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.price, -- replace #1# in the description with this value
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
                -- destroy card, upgrade joker xmult
                SMODS.destroy_cards(context.full_hand[1])
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()

                -- upgrade message
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MONEY,
                }
            end
        end
    end
}
-- #endregion