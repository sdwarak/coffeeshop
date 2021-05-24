require 'time'

module Discount

    DAYS_OF_THE_WEEK = [ 'Sunday', 'Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].freeze

    class OrderOver21

        def self.calculate(ordered_items)
            Discount.set_beverage_discount(ordered_items, 1) if Discount.total_before_taxes(ordered_items)>21
            ordered_items
        end

    end
  
    class Sandwich

        def self.calculate(ordered_items)
            Discount.set_beverage_discount(ordered_items, 0.25) if Discount.sandwich?(ordered_items)
            ordered_items
        end

    end
  
    class CoffeePowder

        def self.calculate(ordered_items)
            Discount.coffee_powder_on_tuesday(ordered_items,0.05)
            ordered_items
        end

    end

    def self.method_missing(m, *args, &block)
        category = m.to_s
        if category.include?('set') && category.include?('discount')
            ordered_items = args[0]
            discount = args[1]
            ['set', 'discount', '_'].inject(category) {|category,v| category.gsub!(v, '') }
            ordered_items.items.each do |oi|
                if  oi.send("#{category}?")
                    oi.price=((oi.price()*(1-discount))).round(2)
                    break
                end
            end
        elsif category.include?('?')
            flag = false
            ordered_items = args[0]
            ordered_items.items.each do |oi|
                if oi.send("#{category}")
                    flag = true
                    break
                end
            end
            flag
        elsif category.include?('_on_')
            arr = category.gsub!('_on_','-').split('-')
            ordered_items = args[0]
            discount = args[1]
            category = arr[0]
            day = arr[1].capitalize
            if DAYS_OF_THE_WEEK.index(day) == Time.now.wday
                ordered_items.items.each do |oi|
                    oi.price=((oi.price*(1-discount))).round(2) if oi.send("#{category}?")
                end
            end
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
            if oi.category? category
                flag = true
                break
            end
        end
        flag
    end

    def self.set_category_discount ordered_items, category, discount
        ordered_items.items.each do |oi|
            if  oi.category? category
                oi.price=((oi.price()*(1-discount))).round(2)
                break
            end
        end      
    end

    def self.category_discount_on_day ordered_items, category, discount, day 
        if DAYS_OF_THE_WEEK.index(day) == Time.now.wday
            ordered_items.items.each do |oi|
                oi.price=((oi.price*(1-discount))).round(2) if oi.category? category
            end
        end
        ordered_items
    end

end
