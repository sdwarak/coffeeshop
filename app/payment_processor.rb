class PaymentProcessor

    require_relative 'ordered_item'
    require_relative 'offer'

    def initialize
        @ordered_items = OrderedItem.new
        @total = 0
    end

    def reset_ordered_items
        @ordered_items = OrderedItem.new
    end

    def purchase item
        @ordered_items.add item
    end
    
    def cancel_ordered_item item
        @ordered_items.delete item
    end

    def show_ordered_items
        for oi in @ordered_items.items
            puts "#{oi.name}: $ #{oi.price}"
        end
        puts "Your total with taxes is #{@total.round(2)}"
        @ordered_items
    end

    def calculate
        offer_applied_items = Offer.apply @ordered_items
        for oAI in offer_applied_items.items
            @total += (oAI.price*(oAI.tax + 1)).round(2)
        end
        return @total.round(2)
    end

    def generate_receipt
        total = self.calculate
        puts "\nYour total with taxes is #{total}\n"
        puts "\n\n*** Receipt ***"
        self.show_ordered_items
        self.reset_ordered_items
    end
end
