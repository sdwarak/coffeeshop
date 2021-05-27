require 'spec_helper'
require './app/item'
require './app/payment_processor'
require './app/ordered_item'

describe PaymentProcessor do 

    before do
        @item = Sandwich.new({"name"=> "Sourdough",
                            "price"=> 18.00})
        @items_hash = [{"name"=> "Sourdough",
                        "price"=> 18.00,
                        "category"=> "Sandwich"},
                        {"name"=> "Americano",
                        "price"=> 1.25,
                        "category"=> "Beverage"},
                        {"name"=> "Cuban",
                        "price"=> 1.75,
                        "category"=> "Beverage"}]
    end

    it 'should be possible to purchase and add items to ordered list' do
        ordered_item= OrderedItem.new
        ordered_item.add(@item)
        payment_processor = PaymentProcessor.new     
        payment_processor.purchase(@item)                      
        expect(payment_processor.show_ordered_items.items).to eq ordered_item.items
    end

    it 'should be possible to calculate the score' do
        items = []
        @items_hash.each {|ih| items.push Object.const_get(ih["category"]).new(ih)}  
        payment_processor = PaymentProcessor.new
        items.each {|i| payment_processor.purchase(i) }
                                                               
        expect(payment_processor.calculate).to be(22.89)
    end

end
