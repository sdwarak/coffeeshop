require 'spec_helper'
require './app/item'
require './app/offer'
require './app/ordered_item'

describe Offer do

    before do 
        @items_1 = [Item.new({"name" => "Hoagie",
                                "price" => 12.25,
                                "category" => "Sandwich"}),
                    Item.new({"name" => "Americano",
                                "price" => 1.25,
                                "category" => "Beverage"})]
        @items_2 = [Item.new({"name"=> "Sourdough",
                                "price"=> 18.00,
                                "category"=> "Sandwich"}),
                    Item.new({"name"=> "Americano",
                                "price"=> 3.25,
                                "category"=> "Beverage"}),
                    Item.new( {"name"=> "Cuban",
                                "price"=> 1.75,
                                "category"=> "Beverage"})]
    end

    it "should apply discount" do
        ordered_item = OrderedItem.new
        @items_1.each {|i| ordered_item.add(i)}
        ordered_item = Offer.apply(ordered_item)
        discounted_item = nil
        ordered_item.items.each do |oi|
            if oi.beverage?
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
            if oi.beverage?
                free_item = oi;
                break
            end
        end
        expect(free_item.price).to be 0.0

    end

    

end


