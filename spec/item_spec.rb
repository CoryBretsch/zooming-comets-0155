require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Item do
  describe '#initialize' do
    it 'exists with attributes' do
      item1 = Item.new('Chalkware Piggy Bank')

      expect(item1).to be_a Item
      expect(item1.name).to eq('Chalkware Piggy Bank')
    end
  end

  describe '#add_bid' do
    it "can add a bid on an item" do
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

      expect(item1.bids).to eq({})

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.bids).to eq({attendee2 => 20, attendee1 => 22})
    end
  end

  describe '#current_high_bid' do
    it "returns the highest bid as an integer for that item" do
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

      expect(item1.current_high_bid).to eq 22
    end
  end

  describe '#close_bidding' do
    it 'can close bidding so no more bids can be made on an item' do
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

      item1.close_bidding

      expect(item1.add_bid(attendee1, 22)).to eq "Pancakes"
      expect(item1.bids).to eq ({attendee2 => 20})
    end
  end
end