SMODS.Joker{
    key = "mirrored_joker",
    atlas = "sxfjokeratlas",
    pos = { x = 1, y = 0},
    rarity = 2,
    blueprint_compat = true, 
    loc_txt = {
            name = "Mirrored Joker",
            text = {
                "Earn {C:money}$#1#{} every time a",
                "card is {C:attention}retriggered{}"
            }
        },
    config = {
            extra = {
                dollars = 1,
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars, -- replace #1# in the description with this value
            }
        }
    end,

    calculate = function (self, card, context)
        -- calculate_individual_effect hook to check when a card is triggering
        local card_trigger = SMODS.calculate_effect
        function SMODS.calculate_effect(effect, scored_card, from_edition, pre_jokers)
            local ret = card_trigger(effect, scored_card, from_edition, pre_jokers)
            scored_card.triggered = true
            return ret
        end
        
        if context.individual then            
            -- increases the trigger count when card is triggered or sets it to 1 if it was nil before
            print(context.other_card.triggered)
            if (context.other_card.triggered or false) == true then
               context.other_card.count = (context.other_card.count or 0) + 1
               context.other_card.triggered = false
            end

            -- gives the player cash money $$$
            if (context.other_card.count or 0) >= 1 then
                context.other_card.count = nil
                context.other_card.triggered = false
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        --[[
        if context.joker_main then
            for i = 1, #G.hand.cards do
                if (G.hand.cards[i].count or 0) >= 2 then
                    G.hand.cards[i].count = nil
                    G.hand.cards[i].triggered = nil
                end
            end
            for i = 1, #context.scoring_hand do
                if (context.scoring_hand[i].count or 0) >= 2 then
                    context.scoring_hand[i].count = nil
                    context.scoring_hand[i].triggered = nil
                end
            end
        end
        --]]
    end,
}