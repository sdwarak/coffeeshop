require 'spec_helper'
require './app/item'
require './app/offer'
require './app/ordered_item'
Dir['./app/items/*.rb'].each { |file| require file }

describe Offer do

    before do 
        @items_1 = [Sandwich.new({"name" => "Hoagie",
                                "price" => 12.25,}),
                    Beverage.new({"name" => "Americano",
                                "price" => 1.25})]
        @items_2 = [Sandwich.new({"name"=> "Sourdough",
                                "price"=> 18.00}),
                    Beverage.new({"name"=> "Americano",
                                "price"=> 3.25}),
                    Beverage.new( {"name"=> "Cuban",
                                "price"=> 1.75})]
    end

    it "should apply discount" do
        ordered_item = OrderedItem.new
        @items_1.each {|i| ordered_item.add(i)}
        ordered_item = Offer.apply(ordered_item)
        discounted_item = nil
        ordered_item.items.each do |oi|
            if oi.class.to_s == "Beverage"
                discounted_item = oi
                break
            end
        end
        expect(discounted_item.price).to be 0.94
    end

    it "should give a beverage free of charge" do
        ordered_item = OrderedItem.new
        @items_2.each {|i| ordered_item.add(i)}
        ordered_item = Offer.apply(ordered_item)
        free_item = nil
        ordered_item.items.each do |oi|
            if oi.class.to_s == "Beverage"
                free_item = oi;
                break
            end
        end
        expect(free_item.price).to be 0.0

    end

    

end


