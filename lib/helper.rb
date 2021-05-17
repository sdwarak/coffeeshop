require 'json'
require('./app/item')
require('./app/coffee_shop')
require('./app/offer')
require('./app/payment_processor')

module Helper

    def self.populate_shop
        file = File.read("items.json")
        menu_items = []
        file_items = JSON.parse file
        for item in file_items 
            menu_items.push Item.new(item)
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

    def self.select_and_pay(coffee_shop,orders)
        payment_processor = PaymentProcessor.new
        value_map = {}
        count = 1
        coffee_shop.items.each do |cs_item|
            value_map[count] = cs_item
            count += 1
        end
        for item_number in orders
            item = Item.new(value_map[item_number.to_i].to_h)
            payment_processor.purchase(item)
            puts "#{value_map[item_number.to_i].name} is selected."
        end
        payment_processor
    end

    def self.generate_receipt(processed_payment)
        processed_payment.generate_receipt
    end

end