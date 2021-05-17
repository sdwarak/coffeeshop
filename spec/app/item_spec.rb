require 'spec_helper'
require './app/item'

describe Item do

    before do
        @item = Item.new({"name" => "Sourdough",
                          "price" => 18.00,
                          "category" => "Sandwich"})
    end                      

    it "should get initizalized" do 
        expect(@item.name).to eq "Sourdough"
        expect(@item.price).to be 18.00
        expect(@item.category).to eq "Sandwich"
    end

    it "should calculate the tax on item" do
        expect(@item.tax).to be 0.1
    end

end
