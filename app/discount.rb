require 'time'

module Discount

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
  
    class CoffeePowderWednesday

        def self.calculate(ordered_items)
            Discount.catergory_discount_on_day(ordered_items,'CoffeePowder',0.05, 'Wednesday')
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
            if oi.class.to_s  == category
                flag = true
                break
            end
        end
        return flag
    end

    def self.set_category_discount ordered_items, category, discount
        ordered_items.items.each do |oi|
            if  oi.class.to_s  == category
                oi.price=((oi.price()*(1-discount))).round(2)
                break
            end
        end      
    end

    def self.catergory_discount_on_day ordered_items, category, discount, day 
        if Time.now.send("#{day.downcase}?")
            ordered_items.items.each do |oi|
                oi.price=((oi.price*(1-discount))).round(2) if oi.class.to_s  == category
            end
        end
        ordered_items
    end

end
