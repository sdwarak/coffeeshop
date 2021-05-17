require 'time'

module Discount

    DAYS_OF_THE_WEEK = [ 'Sunday', 'Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].freeze

    class OrderOver21

        def self.calculate(ordered_items)
            Discount.set_category_discount(ordered_items,'Beverage',1) if Discount.total_before_taxes(ordered_items)>21
            ordered_items
        end

    end
  
    class Sandwich

        def self.calculate(ordered_items)
            Discount.set_category_discount(ordered_items,'Beverage',0.25) if Discount.category_discount?(ordered_items,'Sandwich')
            ordered_items
        end

    end
  
    class CoffeePowder

        def self.calculate(ordered_items)
            Discount.catergory_discount_on_day(ordered_items,'Coffee Powder',0.05, DAYS_OF_THE_WEEK[3]);
            ordered_items
        end

    end
    
    def self.total_before_taxes ordered_items
        total_before_tax = 0
        ordered_items.items.each {|i| total_before_tax += i.price }
        total_before_tax
    end

    def self.category_discount? ordered_items, category
        flag = false
        ordered_items.items.each do |oi|
            if oi.category == category
                flag = true
                break
            end
        end
        return flag
    end

    def self.set_category_discount ordered_items, category, discount
        ordered_items.items.each do |oi|
            if  oi.category() == category
                oi.price=((oi.price()*(1-discount))).round(2)
                break
            end
        end      
    end

    def self.catergory_discount_on_day ordered_items, category, discount, day 
        if DAYS_OF_THE_WEEK.index(day) == Time.now.wday
            ordered_items.items.each do |oi|
                oi.price=((oi.price*(1-discount))).round(2) if oi.category? category
            end
        end
        ordered_items
    end

end
