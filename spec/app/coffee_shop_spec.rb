require 'spec_helper'
require './app/coffee_shop'

describe CoffeeShop do

    before do
        @coffee_shop = CoffeeShop.new
    end

    it 'should display welcome message' do
        expect{@coffee_shop.display}.to output("Welcome to the coffee shop!\n").to_stdout
    end

    it 'should display the menu' do
        expect{@coffee_shop.menu}.to output(/Menu:\n/).to_stdout
    end

end
