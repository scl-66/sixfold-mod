return {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            --#region COMMON JOKERS
            j_sxf_creased_joker = {
                name = "Creased Joker",
                text = {
                    "Played cards with",
                    "ranks {C:attention}2-8{} give {C:chips}+#1#{} Chips",
                    "Played cards with ranks",
                    "{C:attention}9-A{} give {C:mult}+#2#{} Mult"
                },
            },
            j_sxf_receipt = {
                name = "Receipt",
                text = {
                    "Earn {C:money}$#1#{} if played hand",
                    "contains {C:attention}5{} cards with",
                    "different {C:attention}ranks{},"
                },
            },
            --#endregion
            --#region UNCOMMON JOKERS
            j_sxf_mirrored_joker = {
                name = "Mirrored Joker",
                text = {
                    "Earn {C:money}$#1#{} every time a",
                    "scoring card is {C:attention}retriggered{}"
                },
            },
            j_sxf_camera_shutter = {
                name = "Camera Shutter",
                text = {
                    "Sell this card to create",
                    "a free {C:dark_edition}Negative Tag{}"
                },
            },
            j_sxf_mandelbrot = {
                name = "Mandelbrot",
                text = {
                    "When a card is {C:attention}retriggered{}, add",
                    "{C:attention}half{} of its base Chip value to",
                    "this Joker's chips",
                    "{C:inactive}(currently{} {C:chips}+#1#{} {C:inactive}Chips){}"
                },
            },
            --#endregion
            --#region RARE JOKERS
            j_sxf_water_balloon = {
                name = "Water Balloon",
                text = {
                    "Earn {C:money}$#1#{} at end of round.",
                    "If {C:attention}single hand{} scores higher",
                    "than Blind requirement,",
                    "increase payout by {C:money}$#2#{}"
                },
            },
            j_sxf_ransom_note = {
                name = "Ransom Note",
                text = {
                    "{C:attention}Swaps{} base Mult and Chip",
                    "value of poker hand {C:attention}before{}",
                    "any other effects"
                },
            },
            j_sxf_valentine_card = {
                name = "Valentine Card",
                text = {
                    "If {C:attention}first hand{} of round is a",
                    "single {C:hearts}Heart{} card,",
                    "destroy it and add",
                    "{C:mult}+#1#{} Mult to this Joker",
                    "{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
                },
            },
            j_sxf_thankful_leaf = {
                name = "Thankful Leaf",
                text = {
                    "If {C:attention}first hand{} of round is a",
                    "single {C:spades}spade{} card,",
                    "destroy it and add",
                    "{C:chips}+#1#{} Chips to this Joker",
                    "{C:inactive}Currently{} {C:chips}+#2#{} {C:inactive}Chips{}"
                },
            },
            j_sxf_radiant_firework = {
                name = "Radiant Firework",
                text = {
                    "If {C:attention}first hand{} of round is a",
                    "single {C:diamonds}Diamond{} card,",
                    "destroy it and add",
                    "{X:mult,C:white}X#1#{} Mult to this Joker",
                    "{C:inactive}Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult{}"
                }
            },
            j_sxf_fortunate_clover = {
                name = "Fortunate Clover",
                text = {
                    "If {C:attention}first hand{} of round is a",
                    "single {C:clubs}Club{} card,",
                    "destroy it and add",
                    "{C:money}$#1#{} to this Joker's sell value",
                },
            },
            j_sxf_mr_rorschach = {
                name = "Mr. Rorschach",
                text = {
                    "{C:attention}Wild{} cards count as",
                    "{C:attention}any rank{} instead of any suit",
                    "{C:inactive}(Does not affect poker hands){}"
                }
            },
            --#endregion
        },
        Enhanced = {
            m_wild_rank = {
                name = "Wild Card",
                text = {
                    "Can be used",
                    "as any rank",
                },
            },
        }
    },
}
