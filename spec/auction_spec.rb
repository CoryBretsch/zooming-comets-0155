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

  describe '#unpopular_items' do
    it "can return array of items that have no bids" do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
      attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq [item2, item3, item5]

      item3.add_bid(attendee2, 15)

      expect(auction.unpopular_items).to eq [item2, item5]
    end
  end

  describe '#potential_revenue' do
    it 'can return a sum of the items highest bids as an integer' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
      attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq 87
    end
  end

  describe '#bidders' do
    it 'can return array of bidders names as string' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
      attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
      attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      expect(auction.bidders).to eq []

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item3.add_bid(attendee2, 15)

      expect(auction.bidders).to eq ['Bob', 'Megan']
      item4.add_bid(attendee3, 50)

      expect(auction.bidders).to eq ['Bob', 'Megan', 'Mike']
    end
  end

  # describe '#bidder_info' do
  #   it 'can return hash with key as attendee object and value of hash with key as :budget and value of budget as integer
  # end
end

