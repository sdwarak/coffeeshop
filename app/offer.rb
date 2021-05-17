require_relative 'discount'

class Offer
    include Discount

    RULES = [
        Discount::OrderOver21,
        Discount::Sandwich,
        Discount::CoffeePowder
    ].freeze

    def self.display
        puts <<-DISPLAY 
            Get a beverage at a discounted price when you order a sandwich.
            If the total is over 21 dollar get a beverage for free.

            Offers cannot be combined.
            
            An additional 5 percent discount all coffee powders on Wednesdays.
        DISPLAY
    end

    def self.generate(oi, rule)
        rule.calculate(oi)
    end

    def self.apply(ordered_items)
        ordered_items = RULES.reduce(ordered_items) do |oi, rule|
                          Offer.generate(oi, rule)
                        end
        ordered_items
    end

end



