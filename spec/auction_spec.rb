require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Auction do
  describe '#initialize' do
    it 'exists with attributes' do
      auction = Auction.new

      expect(auction).to be_a Auction 
      expect(auction.items).to eq []
    end
  end

  describe '#add_item' do
    it "can add items to an array" do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')

      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq [item1, item2]
    end
  end

  describe '#item_names' do
    it "can return name of all items within items array as an array" do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')

      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.item_names).to eq ["Chalkware Piggy Bank", "Bamboo Picture Frame"]
    end
  end

  

end


