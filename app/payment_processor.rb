class IncompletePayment < StandardError
    attr_reader :error
    attr_reader :amount
    attr_reader :difference


    def initialize(error, amount, difference)
      @error = error
      @amount = amount
      @difference = difference
    end
end

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

    def total_message
        @total = self.calculate
        puts "\nYour total with taxes is #{@total}\n"
    end

    def calculate
        offer_applied_items = Offer.apply @ordered_items
        for oAI in offer_applied_items.items
            @total += (oAI.price*(oAI.tax + 1)).round(2)
        end
        return @total.round(2)
    end

    def pay(amount)
        difference = (@total-amount).round(2)
        if amount < @total
            raise IncompletePayment.new("Incomplete Payment",
                                         amount, difference),
                                        "Kindly pay the difference of $ #{difference}."
        else
            @amount = amount
            puts "Amount paid"
        end
    end

    def generate_receipt
        puts "\n\n*** Receipt ***"
        puts "\nAmount paid is #{@amount}"
        puts "\nTip is #{(@amount-@total).round(2)}\n"
        self.show_ordered_items
        self.reset_ordered_items
    end
end
