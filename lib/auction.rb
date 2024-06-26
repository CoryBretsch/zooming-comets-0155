class Auction
  attr_reader :items, :bidders
  
  def initialize
    @items = []
    @bidders = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    items_without_bids = []
    @items.each do |item|
      items_without_bids << item if item.bids == {}
    end
    items_without_bids
  end

  def items_with_bids #helper_method refactor
    items_with_bids = []
    @items.each do |item|
      items_with_bids << item if item.bids != {}
    end
    items_with_bids
  end

  def potential_revenue
    item_bids = []
    items_with_bids.each do |item|
      item_bids << item.current_high_bid
    end
    item_bids.sum
  end

  def bidders
    items_with_bids.each do |item|
      item.bids.keys.each do |attendee|
        @bidders << attendee.name
      end
    end
    @bidders.uniq
  end

  def bidder_info
    attendees = Attendee.see_all
    info_hash = Hash.new(0)
    attendees.each do |attendee|
      info_hash[attendee] = Hash.new(0)
    end
    info_hash.each do |attendee, sub_hash|
      sub_hash[:budget] = attendee.budget.delete("$").to_i
    end
    info_hash
    # require 'pry'; binding.pry
    # info_hash.each do |attendee, sub_hash|
    #   sub_hash[:items] = @items[0] if attendee.name == @items[0].bids.keys
    #   require 'pry'; binding.pry      
  end
end