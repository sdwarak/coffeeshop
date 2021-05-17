require 'spec_helper'
require './app/ordered_item'


describe OrderedItem do

    it 'should be initialized with an empty list' do
        expect(OrderedItem.new.items).to eq []
    end

end
