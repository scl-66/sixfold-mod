-- #region WATER BALLOON
SMODS.Joker {
    key = "water_balloon",
    atlas = "sxfjokeratlas",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    config = {
        extra = {
            dollars = 1,
            increase = 1,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,  -- replace #1# in the description with this value
                card.ability.extra.increase, -- replace #2# in the description with this value
            }
        }
    end,
    calculate = function(self, card, context)
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
SMODS.Joker {
    key = "ransom_note",
    atlas = "sxfjokeratlas",
    pos = { x = 4, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
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
SMODS.Joker {
    key = "valentine_card",
    atlas = "sxfjokeratlas",
    pos = { x = 5, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
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
                card.ability.extra.mult,      -- replace #2# in the description with this value
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
SMODS.Joker {
    key = "thankful_leaf",
    atlas = "sxfjokeratlas",
    pos = { x = 6, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    config = {
        extra = {
            chip_gain = 30,
            chips = 0,
            suit = "Spades",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_gain, -- replace #1# in the description with this value
                card.ability.extra.chips,     -- replace #2# in the description with this value
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
SMODS.Joker {
    key = "radiant_firework",
    atlas = "sxfjokeratlas",
    pos = { x = 7, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    config = {
        extra = {
            xmult_gain = 0.2,
            xmult = 1,
            suit = "Diamonds",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain, -- replace #1# in the description with this value
                card.ability.extra.xmult,      -- replace #2# in the description with this value
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
SMODS.Joker {
    key = "fortunate_clover",
    atlas = "sxfjokeratlas",
    pos = { x = 8, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
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

-- #region MR. RORSCHACH (NEEDS SPRITE)
-- TODO: make this joker's effect on Wild Cards eventually work with poker hands
SMODS.Joker {
    key = "mr_rorschach",
    atlas = "sxfjokeratlas",
    pos = { x = 0, y = 1 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
}
-- #endregion

-- #region POP ART
SMODS.Joker {
    key = "pop_art",
    atlas = "sxfjokeratlas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            poker_hand = "High Card",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, 'poker_hands'), -- replace #1# in the description with this value
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            for i = 1, #context.scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                local this_card = context.scoring_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        this_card:flip()
                        play_sound('card1', percent)
                        this_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.15)
            SMODS.calculate_effect({ message = "Rank UP!", colour = G.C.ORANGE }, card)
            delay(0.15)
            for i = 1, #context.scoring_hand do
                -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                assert(SMODS.modify_rank(context.scoring_hand[i], 1, true))
            end

            for i = 1, #context.scoring_hand do
                local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                local this_card = context.scoring_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        -- change sprite
                        this_card:set_sprites(nil, G.P_CARDS[this_card.config.card_key])
                        -- flip cards back over
                        this_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        this_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
            return {
                message = localize('k_reset')
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
    end,
}
-- #endregion

-- #region ELDRITCH JOKER (UNFINISHED)
SMODS.Joker {
    key = "eldritch_joker",
    atlas = "sxfjokeratlas",
    pos = { x = 4, y = 1 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    config = {
        extra = {
            xmult_gain = 1.25,
            xmult = 1,
            sacrificed_joker_count = 0
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain, -- replace #1# in the description with this value
                (card.ability.extra.xmult_gain * (card.ability.extra.sacrificed_joker_count or 0)) + 1
            }
        }
    end,
    ---[[
    update = function(self, card, dt)
        -- get number of jokers left of eldritch_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card and i > 1 then
                card.ability.extra.sacrificed_joker_count = i - 1
                for j = 1, card.ability.extra.sacrificed_joker_count do
                    SMODS.debuff_card(G.jokers.cards[j], true, 'j_sxf_eldritch_joker')
                end
            elseif G.jokers.cards[i] == card and i == 1 then
                card.ability.extra.sacrificed_joker_count = 0
            end
            if i < #G.jokers.cards then
                for k = i, #G.jokers.cards do
                    SMODS.debuff_card(G.jokers.cards[k], "prevent_debuff", 'j_sxf_eldritch_joker')
                end
            end
        end
    end,
    --]]
    calculate = function(self, card, context)
        if context.joker_main then
            -- give xmult
            return {
                xmult = (card.ability.extra.xmult_gain * (card.ability.extra.sacrificed_joker_count or 0)) + 1
            }
        end
    end
}
-- #endregion
