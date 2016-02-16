require 'spec_helper'


RSpec.describe 'Where methods' do 
  before :context do
    @boris   = {:name => 'Boris The Blade',     :quote => "Heavy is good. Heavy is reliable. If it doesn't work you can always hit them.",          :title => 'Snatch',          :rank => 4}
    @charles = {:name => 'Charles De Mar',      :quote => 'Go that way, really fast. If something gets in your way, turn.',                         :title => 'Better Off Dead', :rank => 3}
    @wolf    = {:name => 'The Wolf',            :quote => 'I think fast, I talk fast and I need you guys to act fast if you wanna get out of this', :title => 'Pulp Fiction',    :rank => 4}
    @glen    = {:name => 'Glengarry Glen Ross', :quote => "Put. That coffee. Down. Coffee is for closers only.",                                    :title => "Blake",           :rank => 5}
    @fixtures = [@boris, @charles, @wolf, @glen]
  end
  describe 'Array#where' do 
    it 'returns matching value when passed a symbol (key)' do
      expect(@fixtures.where({:name => 'The Wolf'})).to eq [@wolf]
    end
    it 'returns titles with regex partial match' do
      expect(@fixtures.where({:title => /^B.*/})).to eq [@charles, @glen]
    end
    it 'returns multiple results and Fixnum input' do
      expect(@fixtures.where({:rank => 4})).to eq [@boris, @wolf]
    end
    it 'works with multiple criteria' do
      expect(@fixtures.where(:rank => 4, :quote => /get/)).to eq [@wolf]
    end
    it 'works with chained calls' do
      expect(@fixtures.where(:quote => /if/i).where(:rank => 3)).to eq [@charles]
    end
  end
end



# def test_with_chain_calls
#   assert_equal [@charles], @fixtures.where(:quote => /if/i).where(:rank => 3)
# end

