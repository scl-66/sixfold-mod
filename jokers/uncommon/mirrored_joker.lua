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
                "scoring card is {C:attention}retriggered{}"
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
        
        if context.individual and context.cardarea == G.play then            

            -- sets the trigger count
            context.other_card.count = (context.other_card.count or 0) + 1

            -- gives the player cash money $$$
            if (context.other_card.count or 0) >= 2 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        
        -- reset the triggers
        if context.joker_main then
            for i = 1, #context.scoring_hand do
                if (context.scoring_hand[i].count or 0) >= 1 then
                    context.scoring_hand[i].count = nil
                end
            end
        end
    end,
}