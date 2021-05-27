require 'json'
require('./app/item')
Dir['./app/items/*.rb'].each { |file| require file }
require('./app/coffee_shop')
require('./app/offer')
require('./app/payment_processor')
require('byebug')

module Helper

    def self.populate_shop
        file = File.read("items.json")
        menu_items = []
        file_items = JSON.parse file
        for item in file_items 
            menu_items.push Object.const_get(item["category"].gsub(" ",'')).new(item)
        end
        CoffeeShop.new(menu_items)
    end

    def self.display_panel(coffee_shop)
        coffee_shop.display
        coffee_shop.menu
        Offer.display
    end

    def self.request_orders
        puts "\n\nWhat would you like to order?"
        puts "Select items by number seperated by comma."
        seletcted_items = gets.chomp
        seletcted_items.split(',')
    end

    def self.select(coffee_shop)
        selection = {}
        count = 1
        coffee_shop.items.each do |cs_item|
            selection[count] = cs_item
            count += 1
        end
        selection
    end

    def self.pay(selection,orders)
        payment_processor = PaymentProcessor.new
        for item_number in orders
            item = selection[item_number.to_i]
            item = item.class.new(item.to_h)
            payment_processor.purchase(item)
            puts "#{selection[item_number.to_i].name} is selected."
        end
        payment_processor.total_message
        difference = 0
        previous_amount = 0
        while (difference >= 0)
            begin
                self.get_payment(payment_processor, previous_amount)
                break
            rescue IncompletePayment => e
                puts e.message 
                puts e.error
                difference = e.difference
                previous_amount = e.amount
            end
        end
        payment_processor
    end

    def self.get_payment(payment_processor, previous_amount)
        puts "\nHow much would you like to pay?"
        amount = gets.chomp
        amount = amount.to_f.round(2) + previous_amount
        payment_processor.pay(amount)
    end

    def self.generate_receipt(processed_payment)
        processed_payment.generate_receipt
    end

end